package pgdatabase

import (
	"database/sql"
	"ecommerce/cmd/env"
	"fmt"
	"log"
	"os"

	_ "github.com/lib/pq"
)

type Database interface {
	ConnectDB() *sql.DB
}

type postgresDB struct {
	host     string
	port     int64
	user     string
	password string
	dbname   string
	sslmode  string
}

func NewPostgresDB(host string, port int64, user string, password string, dbname string, sslmode string) *postgresDB {
	return &postgresDB{
		host: host, port: port, user: user, password: password, dbname: dbname, sslmode: sslmode,
	}
}

func (pg *postgresDB) ConnectDB() *sql.DB {
	connStr := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=%s",
		pg.host, pg.port, pg.user, pg.password, pg.dbname, pg.sslmode)

	dbPg, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal("Error connecting to database:", err)
	}
	err = dbPg.Ping()
	if err != nil {
		log.Fatal("Error pinging database:", err)
	}
	fmt.Println("[*] - connected to database successfully")
	if env.PG_EXECUTE_CREATE_TABLES {
		createTables(dbPg)
	}
	return dbPg
}

func createTables(db *sql.DB) {
	// Carregar o conteúdo do arquivo .sql
	sqlFile, err := os.ReadFile(env.PG_PATH_CREATE_TABLES)
	if err != nil {
		log.Fatal(err)
	}

	// Executar as consultas contidas no arquivo .sql
	_, err = db.Exec(string(sqlFile))
	if err != nil {
		println(fmt.Sprintf("[*] - postgres database error: %s", err.Error()))
	} else {
		fmt.Println("[*] - create table executed")
	}
}
