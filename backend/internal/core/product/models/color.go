package models

import (
	"errors"
	"time"
)

var (
	ErrColorNameIsEmpty              = errors.New("name of the color is empty")
	ErrColorNameMustHaveOneCharacter = errors.New("name of the color must have at least one character")
	ErrColorNameNameIsLong           = errors.New("name of the color is too long")
)

type Color struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (c *Color) Validate() error {
	if len(c.Name) == 0 {
		return ErrColorNameIsEmpty
	}
	if len(c.Name) < 2 {
		return ErrColorNameMustHaveOneCharacter
	}
	if len(c.Name) > 50 {
		return ErrColorNameNameIsLong
	}
	return nil
}
