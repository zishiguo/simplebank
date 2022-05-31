-- name: CreateTransfer :execresult
INSERT INTO transfers (
    from_account_id, to_account_id, amount
) VALUES (
             ?, ?, ?
         );

-- name: GetTransfer :one
SELECT * FROM transfers
WHERE id = ? LIMIT 1;