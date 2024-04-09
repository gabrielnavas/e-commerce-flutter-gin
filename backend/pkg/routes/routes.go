package routes

import (
	"ecommerce/cmd/env"
	handlers "ecommerce/internal/handler"
	middlewares "ecommerce/internal/middleware"
	"ecommerce/internal/repository"
	"ecommerce/internal/service"
	"ecommerce/pkg/gbcrypt"
	pgdatabase "ecommerce/pkg/postgres"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func Routes(tokenSecret string) *gin.Engine {

	// pkgs
	pgPort, _ := strconv.ParseInt(env.PG_DATABASE_PORT, 10, 0)
	pgdatabase := pgdatabase.NewPostgresDB(env.PG_DATABASE_HOST, pgPort, env.PG_DATABASE_USER, env.PG_DATABASE_PASSWORD, env.PG_DATABASE_DBNAME, env.PG_DATABASE_SSLMODE)
	userRepository := repository.NewUserRepository(pgdatabase.ConnectDB())
	gBcrypt := gbcrypt.NewGBcrypt()

	// services
	log := service.NewLog()
	tokenService := service.NewTokenService(tokenSecret)
	signInService := service.NewSignInService(userRepository, tokenService, gBcrypt, log)
	signUpService := service.NewSignUpService(userRepository, signInService, gBcrypt, log)

	// middlewares instances
	authenticationMiddleware := middlewares.NewAuthenticationMiddleware(tokenSecret, tokenService)

	r := gin.Default()

	public := r.Group("/api/v1")
	{
		// handlers
		signUp := handlers.NewSignUp(signUpService)
		signIn := handlers.NewSignIn(signInService)

		public.POST("/signup", signUp.Handler)
		public.POST("/signin", signIn.Handler)
	}

	private := r.Group("/api/v1")
	private.Use(authenticationMiddleware.JwtMiddleware())
	{
		private.POST("/ping", func(ctx *gin.Context) {
			ctx.JSON(http.StatusOK, gin.H{"message": "service is online"})
		})
	}

	return r
}
