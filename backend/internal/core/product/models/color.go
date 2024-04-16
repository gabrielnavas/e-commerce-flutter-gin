package models

import (
	"errors"
	"time"
)

var (
	ErrNameColorIsEmpty              = errors.New("name is empty")
	ErrNameColorMustHaveOneCharacter = errors.New("name must have at least one character")
	ErrNameColorNameIsLong           = errors.New("name is too long")
)

type Color struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (c *Color) Validate() error {
	if len(c.Name) == 0 {
		return ErrNameColorIsEmpty
	}
	if len(c.Name) < 2 {
		return ErrNameColorMustHaveOneCharacter
	}
	if len(c.Name) > 50 {
		return ErrNameColorNameIsLong
	}
	return nil
}
