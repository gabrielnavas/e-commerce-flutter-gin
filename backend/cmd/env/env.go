package env

// var (
// 	TOKEN_JWT_SECRET = os.Getenv("TOKEN_JWT_SECRET")

// 	PG_DATABASE_HOST                                         = os.Getenv("PG_DATABASE_HOST")
// 	PG_DATABASE_PORT                                         = os.Getenv("PG_DATABASE_PORT")
// 	PG_DATABASE_USER                                         = os.Getenv("PG_DATABASE_USER")
// 	PG_DATABASE_PASSWORD                                     = os.Getenv("PG_DATABASE_PASSWORD")
// 	PG_DATABASE_DBNAME                                       = os.Getenv("PG_DATABASE_DBNAME")
// 	PG_DATABASE_SSLMODE                                      = os.Getenv("PG_DATABASE_SSLMODE")
// 	PG_PATH_CREATE_TABLES                                    = os.Getenv("PG_PATH_CREATE_TABLES")
// 	PG_EXECUTE_CREATE_TABLES, ERROR_PG_EXECUTE_CREATE_TABLES = strconv.ParseBool(os.Getenv("PG_EXECUTE_CREATE_TABLES"))

// 	CORS_ALLOW_ORIGINS                                   = os.Getenv("CORS_ALLOW_ORIGINS")
// 	CORS_ALLOW_METHODS                                   = os.Getenv("CORS_ALLOW_METHODS")
// 	CORS_ALLOW_HEADERS                                   = os.Getenv("CORS_ALLOW_HEADERS")
// 	CORS_EXPOSE_HEADERS                                  = os.Getenv("CORS_EXPOSE_HEADERS")
// 	CORS_ALLOW_CREDENTIALS, ERROR_CORS_ALLOW_CREDENTIALS = strconv.ParseBool(os.Getenv("CORS_ALLOW_CREDENTIALS"))
// 	CORS_MAX_AGE, ERROR_CORS_MAX_AGE                     = strconv.ParseInt(os.Getenv("CORS_MAX_AGE"), 10, 0)
// )

// func init() {
// 	if ERROR_PG_EXECUTE_CREATE_TABLES != nil {
// 		log.Fatalln(ERROR_PG_EXECUTE_CREATE_TABLES)
// 	}
// 	if ERROR_CORS_ALLOW_CREDENTIALS != nil {
// 		log.Fatalln(ERROR_CORS_ALLOW_CREDENTIALS)
// 	}

// 	if ERROR_CORS_MAX_AGE != nil {
// 		log.Fatalln(ERROR_CORS_MAX_AGE)
// 	}
// }

var (
	TOKEN_JWT_SECRET = "123"

	PG_DATABASE_HOST         = "localhost"
	PG_DATABASE_PORT         = "5436"
	PG_DATABASE_USER         = "postgres"
	PG_DATABASE_PASSWORD     = "postgres123"
	PG_DATABASE_DBNAME       = "postgres"
	PG_DATABASE_SSLMODE      = "disable"
	PG_PATH_CREATE_TABLES    = "doc/create-tables.sql"
	PG_EXECUTE_CREATE_TABLES = false

	CORS_ALLOW_ORIGINS     = "*"
	CORS_ALLOW_METHODS     = "*"
	CORS_ALLOW_HEADERS     = "*"
	CORS_EXPOSE_HEADERS    = "*"
	CORS_ALLOW_CREDENTIALS = true
	CORS_MAX_AGE           = 43200 // 12 hours in seconds
)
