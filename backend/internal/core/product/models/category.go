package models

import (
	"errors"
	"time"
)

var (
	ErrCategoryNameIsEmpty              = errors.New("name of the category is empty")
	ErrCategoryNameMustHaveOneCharacter = errors.New("name of the category must have at least one character")
	ErrCategoryNameNameIsLong           = errors.New("name of the category is too long")
)

type Category struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (c *Category) Validate() error {
	if len(c.Name) == 0 {
		return ErrCategoryNameIsEmpty
	}
	if len(c.Name) < 2 {
		return ErrCategoryNameMustHaveOneCharacter
	}
	if len(c.Name) > 50 {
		return ErrCategoryNameNameIsLong
	}
	return nil
}
