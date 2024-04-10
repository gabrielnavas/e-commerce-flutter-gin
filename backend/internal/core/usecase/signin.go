package usecase

import (
	"ecommerce/internal/core/service"
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
	SignIn(data SignInRequest) (string, error)
}

func NewSignInService(userRepository repository.UserRepository, tokenService service.TokenService, passwordHash service.PasswordHash, log service.Log) SignIn {
	return &SignInDBService{userRepository: userRepository, tokenService: tokenService, passwordHash: passwordHash, log: log}
}

type SignInRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type SignInDBService struct {
	userRepository repository.UserRepository
	tokenService   service.TokenService
	passwordHash   service.PasswordHash
	log            service.Log
}

func (s *SignInDBService) SignIn(data SignInRequest) (string, error) {
	user, err := s.userRepository.FindUserByEmail(data.Email)
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
