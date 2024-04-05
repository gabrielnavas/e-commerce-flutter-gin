package main

import (
	"ecommerce/handlers"
	"ecommerce/middlewares"
	jwtservice "ecommerce/services/jwt"

	"github.com/gin-gonic/gin"
)

func Routes(tokenSecret string) *gin.Engine {

	// services
	tokenService := jwtservice.NewTokenService(tokenSecret)

	// middlewares instances
	authenticationMiddleware := middlewares.NewAuthenticationMiddleware(tokenSecret, tokenService)

	r := gin.Default()

	public := r.Group("/api/v1")
	{
		// handlers
		signUp := handlers.NewSignUp(tokenService)

		public.POST("/signup", signUp.Handler)
	}

	private := r.Group("/api/v1")
	private.Use(authenticationMiddleware.JwtMiddleware())
	{
		// handlers
		signIn := handlers.NewSignIn(tokenService)

		private.POST("/signin", signIn.Handler)
	}

	return r
}
