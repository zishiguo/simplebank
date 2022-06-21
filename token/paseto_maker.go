package token

import (
	"fmt"
	"github.com/o1egl/paseto"
	"golang.org/x/crypto/chacha20poly1305"
	"time"
)

type PasetoMaker struct {
	paseto       *paseto.V2
	symmetricKey []byte
}

func NewPasetoMaker(symmetricKey string) (Maker, error) {
	if len(symmetricKey) != chacha20poly1305.KeySize {
		return nil, fmt.Errorf("invalid key size: must be exactly %d characters", chacha20poly1305.KeySize)
	}

	maker := &PasetoMaker{
		paseto:       paseto.NewV2(),
		symmetricKey: []byte(symmetricKey),
	}

	return maker, nil
}

func (m *PasetoMaker) CreateToken(username string, d time.Duration) (string, *Payload, error) {
	payload, err := NewPayload(username, d)
	if err != nil {
		return "", payload, err
	}
	token, err := m.paseto.Encrypt(m.symmetricKey, payload, nil)

	return token, payload, err
}

func (m *PasetoMaker) VerifyToken(token string) (*Payload, error) {

	var payload Payload

	err := m.paseto.Decrypt(token, m.symmetricKey, &payload, nil)
	if err != nil {
		return nil, ErrInvalidToken
	}

	err = payload.Valid()
	if err != nil {
		return nil, err
	}

	return &payload, nil
}
