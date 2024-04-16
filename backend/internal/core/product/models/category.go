package models

import (
	"errors"
	"time"
)

var (
	ErrNameCategoryIsEmpty              = errors.New("name is empty")
	ErrNameCategoryMustHaveOneCharacter = errors.New("name must have at least one character")
	ErrNameCategoryNameIsLong           = errors.New("name is too long")
)

type Category struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (c *Category) Validate() error {
	if len(c.Name) == 0 {
		return ErrNameCategoryIsEmpty
	}
	if len(c.Name) < 2 {
		return ErrNameCategoryMustHaveOneCharacter
	}
	if len(c.Name) > 50 {
		return ErrNameCategoryNameIsLong
	}
	return nil
}
