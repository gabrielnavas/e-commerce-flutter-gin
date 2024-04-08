package model

import (
	"errors"
	"net/mail"
	"regexp"
	"strings"
	"time"

	"github.com/google/uuid"
)

type User struct {
	ID              string
	Fullname        string
	Email           string
	Password        string
	ProfileImageUrl string
	PhoneNumber     string
	BirthDay        time.Time
}

func NewUser(Fullname string,
	Email string,
	Password string,
) *User {
	return &User{
		ID:       uuid.NewString(),
		Fullname: Fullname,
		Email:    Email,
		Password: Password,
	}
}

func (u *User) Validate() error {
	if len(u.Fullname) < 2 {
		return errors.New("nome precisa ter pelo menos 2 caracteres")
	}
	if len(u.Fullname) > 120 {
		return errors.New("nome precisa ser menor que 120 caracteres")
	}
	if len(strings.Split(u.Fullname, " ")) < 2 {
		return errors.New("nome precisa ter sobrenome")
	}

	_, err := mail.ParseAddress(u.Email)
	if err != nil {
		return errors.New("e-mail inválido")
	}

	passwordErr := validatePassword(u.Password)
	if passwordErr != nil {
		return passwordErr
	}

	return nil
}

func validatePassword(password string) error {
	// Verifica se a senha tem pelo menos 8 caracteres
	if len(password) < 8 {
		return errors.New("a senha deve ter pelo menos 8 caracteres")
	}

	if len(password) > 100 {
		return errors.New("a senha deve ser menor que 120 caracteres")
	}

	// Verifica se a senha contém pelo menos uma letra maiúscula
	hasUpperCase, _ := regexp.MatchString(`[A-Z]`, password)
	if !hasUpperCase {
		return errors.New("a senha deve conter pelo menos uma letra maiúscula")
	}

	// Verifica se a senha contém pelo menos uma letra minúscula
	hasLowerCase, _ := regexp.MatchString(`[a-z]`, password)
	if !hasLowerCase {
		return errors.New("a senha deve conter pelo menos uma letra minúscula")
	}

	// Verifica se a senha contém pelo menos um número
	hasNumber, _ := regexp.MatchString(`[0-9]`, password)
	if !hasNumber {
		return errors.New("a senha deve conter pelo menos um número")
	}

	// Verifica se a senha contém pelo menos um caractere especial
	hasSpecialChar, _ := regexp.MatchString(`[\W_]`, password)
	if !hasSpecialChar {
		return errors.New("a senha deve conter pelo menos um caractere especial")
	}

	return nil
}
