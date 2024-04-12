package usecases

import (
	"context"
	servicesAuth "ecommerce/internal/core/auth/services"
	servicesLog "ecommerce/internal/core/log/services"
	"ecommerce/internal/repository"
	"errors"
	"time"
)

var (
	ErrUserNotFound         = errors.New("user not found")
	ErrInvalidEmailPassword = errors.New("user not found")
	ErrUnavailable          = errors.New("service unavailable")
)

type SignIn interface {
	SignIn(context.Context, SignInRequest) (string, error)
}

func NewSignIn(userRepository repository.UserRepository, tokenService servicesAuth.TokenService, passwordHash servicesAuth.PasswordHash, log servicesLog.Log) SignIn {
	return &SignInDB{userRepository: userRepository, tokenService: tokenService, passwordHash: passwordHash, log: log}
}

type SignInRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type SignInDB struct {
	userRepository repository.UserRepository
	tokenService   servicesAuth.TokenService
	passwordHash   servicesAuth.PasswordHash
	log            servicesLog.Log
}

func (s *SignInDB) SignIn(ctx context.Context, data SignInRequest) (string, error) {
	user, err := s.userRepository.FindUserByEmail(ctx, data.Email)
	if err != nil {
		s.log.Handle(err.Error(), time.Now())
		return "", ErrUnavailable
	}
	if user == nil {
		return "", ErrUserNotFound
	}
	if !s.passwordHash.Compare(user.Password, data.Password) {
		return "", ErrInvalidEmailPassword
	}
	token, err := s.tokenService.NewAccessToken(user.ID)
	if err != nil {
		s.log.Handle(err.Error(), time.Now())
		return "", ErrUnavailable
	}
	return token, nil
}
