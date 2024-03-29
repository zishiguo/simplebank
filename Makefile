.PHONY: createdb dropdb

createdb:
	docker exec -it docker-122-rpa_db-1 mysqladmin -u root -prpa create simple_bank
dropdb:
	docker exec -it docker-122-rpa_db-1 mysqladmin -u root -prpa -f drop simple_bank
migrateup1:
	migrate -path db/migration -database "mysql://root:mypassword@tcp(simple-bank.cenzyx78n0yk.ap-east-1.rds.amazonaws.com:3306)/simple_bank?parseTime=true" -verbose up 1
migrateup:
	migrate -path db/migration -database "mysql://root:mypassword@tcp(simple-bank.cenzyx78n0yk.ap-east-1.rds.amazonaws.com:3306)/simple_bank?parseTime=true" -verbose up
migratedown1:
	migrate -path db/migration -database "mysql://root:mypassword@tcp(simple-bank.cenzyx78n0yk.ap-east-1.rds.amazonaws.com:3306)/simple_bank?parseTime=true" -verbose down 1
migratedown:
	migrate -path db/migration -database "mysql://root:mypassword@tcp(simple-bank.cenzyx78n0yk.ap-east-1.rds.amazonaws.com:3306)/simple_bank?parseTime=true" -verbose down
sqlc:
	sqlc
test:
	go test -v -cover ./...
server:
	go run main.go
mock:
	mockgen -destination db/mock/store.go github.com/zishiguo/simplebank/db/sqlc Store