package service

import (
	"ecommerce/internal/model"
	"ecommerce/internal/repository"

	"github.com/google/uuid"
)

type SignUpService interface {
	Sigup(data SignUpRequest) (token string, err error)
}

func NewSignUpService(userRepository repository.UserRepository) SignUpService {
	return &SignUpDBService{userRepository: userRepository}
}

type SignUpRequest struct {
	Fullname             string
	Email                string
	Password             string
	PasswordConfirmation string
}

type SignUpDBService struct {
	userRepository repository.UserRepository
}

func (s *SignUpDBService) Sigup(data SignUpRequest) (token string, err error) {
	user := model.User{
		ID:       uuid.NewString(),
		Fullname: data.Fullname,
		Email:    data.Email,
		Password: data.Password,
	}
	err = s.userRepository.AddUser(user)
	if err != nil {
		return "", err
	}

	return "", err
}
