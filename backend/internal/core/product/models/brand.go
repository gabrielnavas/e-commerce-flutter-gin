package models

import (
	"errors"
	"time"
)

var (
	ErrNameBrandIsEmpty              = errors.New("name is empty")
	ErrNameBrandMustHaveOneCharacter = errors.New("name must have at least one character")
	ErrNameBrandNameIsLong           = errors.New("name is too long")
)

type Brand struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt *time.Time
}

func (b *Brand) Validate() error {
	if len(b.Name) == 0 {
		return ErrNameBrandIsEmpty
	}
	if len(b.Name) < 2 {
		return ErrNameBrandMustHaveOneCharacter
	}
	if len(b.Name) > 50 {
		return ErrNameBrandNameIsLong
	}
	return nil
}
