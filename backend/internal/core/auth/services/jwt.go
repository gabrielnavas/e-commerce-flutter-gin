package services

import (
	"ecommerce/internal/core/auth/models"
	tokenjwt "ecommerce/pkg/token-jwt"
)

type TokenService interface {
	ParseAccessToken(accessToken string) (*models.UserClaims, error)
	NewAccessToken(userID string) (string, error)
}

func NewTokenService(secretToken string) TokenService {
	return tokenjwt.NewJwt(secretToken)
}
