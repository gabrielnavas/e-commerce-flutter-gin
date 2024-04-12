package routes

import (
	"context"
	"ecommerce/cmd/env"
	"ecommerce/cmd/initital-data/products"
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

	// crypt
	gBcrypt := gbcrypt.NewGBcrypt()

	//databases
	pgPort, _ := strconv.ParseInt(env.PG_DATABASE_PORT, 10, 0)
	pgdatabase := pgdatabase.NewPostgresDB(env.PG_DATABASE_HOST, pgPort, env.PG_DATABASE_USER, env.PG_DATABASE_PASSWORD, env.PG_DATABASE_DBNAME, env.PG_DATABASE_SSLMODE)
	dbPostgres := pgdatabase.ConnectDB()

	// repositories
	userPGRepository := repository.NewUserRepository(dbPostgres)
	productPGRepository := repository.NewProductRepository(dbPostgres)

	// services
	log := servicesLog.NewLog()
	tokenService := servicesAuth.NewTokenService(tokenSecret)
	signInService := usecasesAuth.NewSignIn(userPGRepository, tokenService, gBcrypt, log)
	signUpService := usecasesAuth.NewSignUp(userPGRepository, signInService, gBcrypt, log)

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

	// init default data postgres db
	initData := products.NewInititalData(productPGRepository)
	ctx := context.Background()
	initData.Init(ctx)

	return r
}
