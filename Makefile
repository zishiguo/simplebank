.PHONY: createdb dropdb

createdb:
	docker exec -it docker-122-rpa_db-1 mysqladmin -u root -prpa create simple_bank
dropdb:
	docker exec -it docker-122-rpa_db-1 mysqladmin -u root -prpa -f drop simple_bank
migrateup:
	migrate -path db/migration -database "mysql://root:rpa@tcp(localhost:3306)/simple_bank" -verbose up
migratedown:
	migrate -path db/migration -database "mysql://root:rpa@tcp(localhost:3306)/simple_bank" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
server:
	go run main.go
mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/zishiguo/simplebank/db/sqlc Store