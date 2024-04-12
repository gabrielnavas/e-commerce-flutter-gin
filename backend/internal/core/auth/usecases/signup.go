package usecases

import (
	"context"
	"ecommerce/internal/core/auth/models"
	servicesAuth "ecommerce/internal/core/auth/services"
	servicesLog "ecommerce/internal/core/log/services"
	"ecommerce/internal/repository"
	"errors"
	"time"

	"github.com/google/uuid"
)

var (
	ErrUserEmailDuplicated = errors.New("user already exists with email")
	ErrServiceIsOffline    = errors.New("it is not possible to create account now")
)

type SignUp interface {
	SignUp(ctx context.Context, data SignUpRequest) (token string, err error)
}

func NewSignUp(userRepository repository.UserRepository, signInService SignIn, passwordHash servicesAuth.PasswordHash, log servicesLog.Log) SignUp {
	return &SignUpDB{userRepository: userRepository, signInService: signInService, passwordHash: passwordHash, log: log}
}

type SignUpRequest struct {
	Fullname             string `json:"full_name"`
	Email                string `json:"email"`
	Password             string `json:"password"`
	PasswordConfirmation string `json:"password_confirmation"`
}

type SignUpDB struct {
	userRepository repository.UserRepository
	signInService  SignIn
	passwordHash   servicesAuth.PasswordHash
	log            servicesLog.Log
}

func (s *SignUpDB) SignUp(ctx context.Context, data SignUpRequest) (string, error) {
	err := s.handleSignUp(ctx, data)
	if err != nil {
		return "", err
	}

	token, err := s.handleSignIn(ctx, data)
	if err != nil {
		return "", err
	}

	return token, nil
}

func (s *SignUpDB) handleSignIn(ctx context.Context, data SignUpRequest) (string, error) {
	token, err := s.signInService.SignIn(ctx, SignInRequest{
		Email:    data.Email,
		Password: data.Password,
	})
	return token, err
}

func (s *SignUpDB) handleSignUp(ctx context.Context, data SignUpRequest) error {
	user := models.User{
		ID:       uuid.NewString(),
		Fullname: data.Fullname,
		Email:    data.Email,
		Password: data.Password,
	}

	passwordHashed, err := s.passwordHash.Generate(data.Password)
	if err != nil {
		s.log.Handle(err.Error(), time.Now())
		return ErrServiceIsOffline
	}
	user.Password = passwordHashed

	userFound, err := s.userRepository.FindUserByEmail(ctx, data.Email)
	if err != nil {
		s.log.Handle(err.Error(), time.Now())
		return ErrServiceIsOffline
	}
	if userFound != nil {
		return ErrUserEmailDuplicated
	}

	err = s.userRepository.AddUser(ctx, user)
	if err != nil {
		s.log.Handle(err.Error(), time.Now())
		return err
	}
	return nil
}
