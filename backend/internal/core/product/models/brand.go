package models

import (
	"errors"
	"time"
)

var (
	ErrBrandNameIsEmpty              = errors.New("name of the brand is empty")
	ErrBrandNameMustHaveOneCharacter = errors.New("name of the brand must have at least one character")
	ErrBrandNameNameIsLong           = errors.New("name of the brand is too long")
)

type Brand struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt *time.Time
}

func (b *Brand) Validate() error {
	if len(b.Name) == 0 {
		return ErrBrandNameIsEmpty
	}
	if len(b.Name) < 2 {
		return ErrBrandNameMustHaveOneCharacter
	}
	if len(b.Name) > 50 {
		return ErrBrandNameNameIsLong
	}
	return nil
}
