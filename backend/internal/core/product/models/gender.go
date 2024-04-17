package models

import (
	"errors"
	"time"
)

var (
	ErrNameGenderIsEmpty              = errors.New("name of the gender is empty")
	ErrNameGenderMustHaveOneCharacter = errors.New("name of the gender must have at least one character")
	ErrNameGenderNameIsLong           = errors.New("name of the gender is too long")
)

type Gender struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (c *Gender) Validate() error {
	if len(c.Name) == 0 {
		return ErrNameGenderIsEmpty
	}
	if len(c.Name) < 2 {
		return ErrNameGenderMustHaveOneCharacter
	}
	if len(c.Name) > 50 {
		return ErrNameGenderNameIsLong
	}
	return nil
}
