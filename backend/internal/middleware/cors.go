package middlewares

import (
	"ecommerce/cmd/env"
	"strings"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func Cors() gin.HandlerFunc {
	// CORS for https://foo.com and https://github.com origins, allowing:
	// - PUT and PATCH methods
	// - Origin header
	// - Credentials share
	// - Preflight requests cached for 12 hours
	return cors.New(cors.Config{
		AllowOrigins:     strings.Split(env.CORS_ALLOW_ORIGINS, ","),
		AllowMethods:     strings.Split(env.CORS_ALLOW_METHODS, ","),
		AllowHeaders:     strings.Split(env.CORS_ALLOW_HEADERS, ","),
		ExposeHeaders:    strings.Split(env.CORS_EXPOSE_HEADERS, ","),
		AllowCredentials: env.CORS_ALLOW_CREDENTIALS,
		AllowOriginFunc: func(origin string) bool {
			// return origin == "https://github.com"
			return true
		},
		MaxAge: time.Duration(env.CORS_MAX_AGE),
	})
}
