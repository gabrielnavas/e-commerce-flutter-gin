package models

import (
	"errors"
	"time"
)

var (
	ErrKindCategoryNameIsEmpty              = errors.New("name of the kind of the category is empty")
	ErrKindCategoryNameMustHaveOneCharacter = errors.New("name of the kind of the category must have at least one character")
	ErrKindCategoryNameNameIsLong           = errors.New("name of the kind of the category is too long")
)

type KindCategory struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (c *KindCategory) Validate() error {
	if len(c.Name) == 0 {
		return ErrKindCategoryNameIsEmpty
	}
	if len(c.Name) < 2 {
		return ErrKindCategoryNameMustHaveOneCharacter
	}
	if len(c.Name) > 20 {
		return ErrKindCategoryNameNameIsLong
	}
	return nil
}
