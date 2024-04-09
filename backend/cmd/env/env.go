package env

// var (
// 	TOKEN_JWT_SECRET = os.Getenv("TOKEN_JWT_SECRET")

// 	PG_DATABASE_HOST     = os.Getenv("PG_DATABASE_HOST")
// 	PG_DATABASE_PORT     = os.Getenv("PG_DATABASE_PORT")
// 	PG_DATABASE_USER     = os.Getenv("PG_DATABASE_USER")
// 	PG_DATABASE_PASSWORD = os.Getenv("PG_DATABASE_PASSWORD")
// 	PG_DATABASE_DBNAME   = os.Getenv("PG_DATABASE_DBNAME")
// 	PG_DATABASE_SSLMODE  = os.Getenv("PG_DATABASE_SSLMODE")
//  PG_PATH_CREATE_TABLES = os.Getenv("PG_PATH_CREATE_TABLES")
//  PG_EXECUTE_CREATE_TABLES =  os.Getenv("PG_EXECUTE_CREATE_TABLES")
// )

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
)
