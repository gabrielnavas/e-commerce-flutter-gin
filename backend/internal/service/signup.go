package service

import (
	"ecommerce/internal/model"
	"ecommerce/internal/repository"
	"errors"
	"time"

	"github.com/google/uuid"
)

var (
	ErrUserEmailDuplicated = errors.New("user already exists with email")
)

type SignUpService interface {
	SignUp(data SignUpRequest) (token string, err error)
}

func NewSignUpService(userRepository repository.UserRepository, signInService SignInService, passwordHash PasswordHash, log Log) SignUpService {
	return &SignUpDBService{userRepository: userRepository, signInService: signInService, passwordHash: passwordHash, log: log}
}

type SignUpRequest struct {
	Fullname             string `json:"full_name"`
	Email                string `json:"email"`
	Password             string `json:"password"`
	PasswordConfirmation string `json:"password_confirmation"`
}

type SignUpDBService struct {
	userRepository repository.UserRepository
	signInService  SignInService
	passwordHash   PasswordHash
	log            Log
}

func (s *SignUpDBService) SignUp(data SignUpRequest) (string, error) {
	err := s.handleSignUp(data)
	if err != nil {
		return "", err
	}

	token, err := s.handleSignIn(data)
	if err != nil {
		return "", err
	}

	return token, nil
}

func (s *SignUpDBService) handleSignIn(data SignUpRequest) (string, error) {
	token, err := s.signInService.SignIn(SignInRequest{
		Email:    data.Email,
		Password: data.Password,
	})
	return token, err
}

func (s *SignUpDBService) handleSignUp(data SignUpRequest) error {
	user := model.User{
		ID:       uuid.NewString(),
		Fullname: data.Fullname,
		Email:    data.Email,
		Password: data.Password,
	}

	passwordHashed, err := s.passwordHash.Generate(data.Password)
	if err != nil {
		s.log.Handle(err.Error(), time.Now())
		return errors.New("it is not possible to create account now")
	}
	user.Password = passwordHashed

	userFound, err := s.userRepository.FindUserByEmail(data.Email)
	if err != nil {
		s.log.Handle(err.Error(), time.Now())
		return errors.New("it is not possible to create account now")
	}
	if userFound != nil {
		return ErrUserEmailDuplicated
	}

	err = s.userRepository.AddUser(user)
	if err != nil {
		s.log.Handle(err.Error(), time.Now())
		return err
	}
	return nil
}
