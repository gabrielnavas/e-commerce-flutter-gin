package service

import (
	"ecommerce/internal/repository"
	"errors"
	"time"
)

var (
	ErrUserNotFound         = errors.New("user not found")
	ErrInvalidEmailPassword = errors.New("user not found")
	ErrUnavailable          = errors.New("service unavailable")
)

type SignInService interface {
	SignIn(data SignInRequest) (string, error)
}

func NewSignInService(userRepository repository.UserRepository, tokenService TokenService, passwordHash PasswordHash, log Log) SignInService {
	return &SignInDBService{userRepository: userRepository, tokenService: tokenService, passwordHash: passwordHash, log: log}
}

type SignInRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type SignInDBService struct {
	userRepository repository.UserRepository
	tokenService   TokenService
	passwordHash   PasswordHash
	log            Log
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
