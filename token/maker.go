package token

import "time"

type Maker interface {
	CreateToken(username string, d time.Duration) (string, *Payload, error)
	VerifyToken(token string) (*Payload, error)
}
