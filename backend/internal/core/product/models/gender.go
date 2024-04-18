package models

import (
	"errors"
	"time"
)

var (
	ErrGenderNameIsEmpty              = errors.New("name of the gender is empty")
	ErrGenderNameMustHaveOneCharacter = errors.New("name of the gender must have at least one character")
	ErrGenderNameNameIsLong           = errors.New("name of the gender is too long")
)

type Gender struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (c *Gender) Validate() error {
	if len(c.Name) == 0 {
		return ErrGenderNameIsEmpty
	}
	if len(c.Name) < 2 {
		return ErrGenderNameMustHaveOneCharacter
	}
	if len(c.Name) > 50 {
		return ErrGenderNameNameIsLong
	}
	return nil
}
