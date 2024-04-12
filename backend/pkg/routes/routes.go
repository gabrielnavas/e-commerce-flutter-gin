package routes

import (
	"ecommerce/cmd/env"
	servicesAuth "ecommerce/internal/core/auth/services"
	usecasesAuth "ecommerce/internal/core/auth/usecases"
	servicesLog "ecommerce/internal/core/log/services"
	handlers "ecommerce/internal/handler"
	middlewares "ecommerce/internal/middleware"
	"ecommerce/internal/repository"
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
	log := servicesLog.NewLog()
	tokenService := servicesAuth.NewTokenService(tokenSecret)
	signInService := usecasesAuth.NewSignIn(userRepository, tokenService, gBcrypt, log)
	signUpService := usecasesAuth.NewSignUp(userRepository, signInService, gBcrypt, log)

	// middlewares instances
	cors := middlewares.Cors()
	authenticationMiddleware := middlewares.NewAuthenticationMiddleware(tokenSecret, tokenService)

	r := gin.Default()
	r.Use(cors)

	public := r.Group("/api/v1")
	{
		// handlers
		signUp := handlers.NewSignUp(signUpService)
		signIn := handlers.NewSignIn(signInService)

		public.POST("/signup", signUp.Handler)
		public.POST("/signin", signIn.Handler)
		public.GET("/ping", func(ctx *gin.Context) {
			ctx.JSON(http.StatusOK, gin.H{"message": "service is online"})
		})
	}

	private := r.Group("/api/v1")
	private.Use(authenticationMiddleware.JwtMiddleware())
	{
	}

	return r
}
