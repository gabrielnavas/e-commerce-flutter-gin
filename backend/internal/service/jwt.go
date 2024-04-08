package service

import (
	"ecommerce/internal/model"
	tokenjwt "ecommerce/pkg/token-jwt"
)

type TokenService interface {
	ParseAccessToken(accessToken string) (*model.UserClaims, error)
	NewAccessToken(userID string) (string, error)
}

func NewTokenService(secretToken string) TokenService {
	return tokenjwt.NewJwt(secretToken)
}
