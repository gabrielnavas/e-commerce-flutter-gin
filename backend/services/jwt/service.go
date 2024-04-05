package jwtservice

import (
	"ecommerce/models"
	"time"

	"github.com/golang-jwt/jwt"
	"github.com/google/uuid"
)

func NewTokenService(secretToken string) TokenService {
	return &jwtService{secretToken: secretToken}
}

type jwtService struct {
	secretToken string
}

func (s *jwtService) NewAccessToken(userID string) (string, error) {
	now := time.Now().Unix()

	userClaims := models.UserClaims{
		StandardClaims: jwt.StandardClaims{
			Audience:  "all",
			Id:        uuid.NewString(),
			NotBefore: now,
			IssuedAt:  now,
			ExpiresAt: time.Now().Add(time.Minute * 15).Unix(),
			Issuer:    uuid.NewString(),
			Subject:   userID, // user id
		},
	}

	accessToken := jwt.NewWithClaims(jwt.SigningMethodHS256, userClaims)
	return accessToken.SignedString([]byte(s.secretToken))
}

func (s *jwtService) ParseAccessToken(accessToken string) (*models.UserClaims, error) {
	parsedAccessToken, err := jwt.ParseWithClaims(accessToken, &models.UserClaims{}, func(token *jwt.Token) (interface{}, error) {
		return []byte(s.secretToken), nil
	})
	if err != nil {
		return nil, err
	}
	return parsedAccessToken.Claims.(*models.UserClaims), nil
}
