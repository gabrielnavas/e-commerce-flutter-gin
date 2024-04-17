package models

import (
	"errors"
	"time"
)

var (
	ErrSizeNameIsEmpty              = errors.New("name of the size is empty")
	ErrSizeNameMustHaveOneCharacter = errors.New("name of the size must have at least one character")
	ErrSizeNameIsLong               = errors.New("name of the size is too long")
)

type Size struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (c *Size) Validate() error {
	if len(c.Name) == 0 {
		return ErrSizeNameIsEmpty
	}
	if len(c.Name) < 2 {
		return ErrSizeNameMustHaveOneCharacter
	}
	if len(c.Name) > 20 {
		return ErrSizeNameIsLong
	}
	return nil
}
