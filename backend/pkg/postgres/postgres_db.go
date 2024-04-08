package database

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

type Database interface {
	ConnectDB() *sql.DB
}

type postgresDB struct {
	host     string
	port     int32
	user     string
	password string
	dbname   string
	sslmode  string
}

func NewPostgresDB(host string, port int32, user string, password string, dbname string, sslmode string) *postgresDB {
	return &postgresDB{
		host: host, port: port, user: user, password: password, dbname: dbname, sslmode: sslmode,
	}
}

func (db *postgresDB) ConnectDB() *sql.DB {
	connStr := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=%s",
		db.host, db.port, db.user, db.password, db.dbname, db.sslmode)

	dbPg, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal("Error connecting to database:", err)
	}
	err = dbPg.Ping()
	if err != nil {
		log.Fatal("Error pinging database:", err)
	}
	fmt.Println("Connected to database successfully!")
	return dbPg
}
