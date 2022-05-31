package main

import (
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
	"github.com/zishiguo/simplebank/api"
	db "github.com/zishiguo/simplebank/db/sqlc"
	"log"
)

const (
	dbDriver      = "mysql"
	dbSource      = "root:rpa@tcp(localhost:3306)/simple_bank?parseTime=true"
	serverAddress = "0.0.0.0:9090"
)

func main() {
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}
	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAddress)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}
