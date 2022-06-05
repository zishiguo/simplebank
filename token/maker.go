package token

import "time"

type Maker interface {
	CreateToken(username string, d time.Duration) (string, error)
	VerifyToken(token string) (*Payload, error)
}
