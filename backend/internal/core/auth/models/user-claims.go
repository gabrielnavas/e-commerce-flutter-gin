package models

import "github.com/golang-jwt/jwt"

type UserClaims struct {
	jwt.StandardClaims
}
