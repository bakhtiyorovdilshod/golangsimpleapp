postgres:
	docker run --name postgres -p 5433:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres

createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5433/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5433/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...


.PHONY: postgres createdb dropdb migrateup migratedown test






# .PHONY: devup devdown migrate-up migrate-down migrate-add

# devup:
#   docker rm -f simple_bank_postgres

#   docker run -d                                           \
#     --name simple_bank_postgres                           \
#     -e POSTGRES_DB=simple_bank                            \
#     -e POSTGRES_PASSWORD=secret                           \
#     -e TZ='Asia/Tashkent'                                 \
#     -p 5433:5432                                          \
#     -v simple_bank_postgres_data:/var/lib/postgresql/data \
#     postgres:15


# devdown:
#   docker rm -f simple_bank_postgres


# migrate-up:
#   migrate -path db/migration -database "postgresql://postgres:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up


# migrate-down:
#   migrate -path db/migrations -database postgresql://postgres:secret@localhost:5432/simple_bank?sslmode=disable -verbose down 1


# migrate-add:
#   migrate create -ext sql -dir internal/repo/pgstore/migrations -seq ${FILE_NAME}
