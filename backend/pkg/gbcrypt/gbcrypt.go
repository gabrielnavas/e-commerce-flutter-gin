package gbcrypt

import "golang.org/x/crypto/bcrypt"

type gBcrypt struct{}

func NewGBcrypt() *gBcrypt {
	return &gBcrypt{}
}

func (b *gBcrypt) Generate(password string) (string, error) {
	data, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return "", err
	}
	return string(data), nil
}

func (b *gBcrypt) Compare(hashedPassword, password string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password))
	return err == nil
}
