package middlewares

import (
	"ecommerce/internal/core/service"
	"ecommerce/internal/model"
	"errors"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
)

type jwtAuthentication struct {
	secretKey  string
	jwtService service.TokenService
}

func NewAuthenticationMiddleware(secretKey string, jwtService service.TokenService) *jwtAuthentication {
	return &jwtAuthentication{secretKey: secretKey, jwtService: jwtService}
}

func (auth *jwtAuthentication) authenticate(authorizationHeader string) (*model.UserClaims, error) {
	authorizationSplited := strings.Split(authorizationHeader, " ")
	if len(authorizationSplited) != 2 {
		return nil, errors.New("token não fornecido")
	}
	tokenString := authorizationSplited[1]
	if tokenString == "" {
		return nil, errors.New("token não fornecido")
	}

	claims, err := auth.jwtService.ParseAccessToken(tokenString)
	if err != nil {
		return nil, errors.New("token não fornecido")
	}
	return claims, nil
}

func (auth *jwtAuthentication) JwtMiddleware() gin.HandlerFunc {
	return func(context *gin.Context) {
		authorization := context.GetHeader("Authorization")

		claims, err := auth.authenticate(authorization)

		if err != nil {
			context.JSON(http.StatusUnauthorized, gin.H{"error": err.Error()})
			context.Abort()
		}

		context.Set("userID", claims.Subject)
		context.Next()
	}
}
