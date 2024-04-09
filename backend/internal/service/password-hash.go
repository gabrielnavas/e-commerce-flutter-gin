package service

type PasswordHash interface {
	Generate(password string) (string, error)
	Compare(hashedPassword, password string) bool
}
