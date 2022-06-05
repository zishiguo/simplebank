-- name: CreateAccount :execresult
INSERT INTO accounts (owner, balance, currency) VALUES (?, ?, ?);

-- name: GetAccount :one
SELECT * FROM accounts WHERE id = ?;

-- name: GetAccountForUpdate :one
SELECT * FROM accounts WHERE id = ? FOR UPDATE;

-- name: ListAccounts :many
SELECT * FROM accounts WHERE owner = ? ORDER BY id LIMIT ?, ?;

-- name: UpdateAccount :exec
UPDATE accounts SET balance = ? where id = ?;

-- name: AddAccountBalance :exec
UPDATE accounts SET balance = balance + sqlc.arg(amount) where id = ?;

-- name: DeleteAccount :exec
DELETE FROM accounts WHERE id = ?;