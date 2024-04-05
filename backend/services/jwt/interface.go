package jwtservice

import "ecommerce/models"

type TokenService interface {
	ParseAccessToken(accessToken string) (*models.UserClaims, error)
	NewAccessToken(userID string) (string, error)
}
