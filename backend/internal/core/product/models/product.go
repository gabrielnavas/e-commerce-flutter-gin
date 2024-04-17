package models

import (
	"ecommerce/internal/core/auth/models"
	"errors"
	"time"
)

var (
	ErrProductNameIsEmpty              = errors.New("name of the product is empty")
	ErrProductNameMustHaveOneCharacter = errors.New("name of the product must have at least one character")
	ErrProductNameNameIsLong           = errors.New("name of the product is too long")

	ErrProductDescriptionIsEmpty              = errors.New("description of the product is empty")
	ErrProductDescriptionMustHaveOneCharacter = errors.New("description of the product must have at least one character")
	ErrProductDescriptionNameIsLong           = errors.New("description of the product is too long")

	ErrCreatedAtIsBeforeUpdatedAt = errors.New("created at is before updated at in the product")
)

type Product struct {
	ID           string
	Name         string
	Description  string
	Brand        Brand
	Category     Category
	OwnerCreated models.User
	Color        Color
	Size         Size
	CreatedAt    time.Time
	UpdatedAt    time.Time
	Images       []Image
}

func (p *Product) Validate() error {
	if len(p.Name) == 0 {
		return ErrProductNameIsEmpty
	}
	if len(p.Name) < 2 {
		return ErrProductNameMustHaveOneCharacter
	}
	if len(p.Name) > 50 {
		return ErrProductNameNameIsLong
	}

	if len(p.Description) == 0 {
		return ErrProductDescriptionIsEmpty
	}
	if len(p.Description) < 2 {
		return ErrProductDescriptionMustHaveOneCharacter
	}
	if len(p.Description) > 100 {
		return ErrProductDescriptionNameIsLong
	}

	errBrand := p.Brand.Validate()
	if errBrand != nil {
		return errBrand
	}

	errCategory := p.Category.Validate()
	if errCategory != nil {
		return errCategory
	}

	errOwnerCreated := p.OwnerCreated.Validate()
	if errOwnerCreated != nil {
		return errOwnerCreated
	}

	errSize := p.Size.Validate()
	if errSize != nil {
		return errSize
	}

	errColor := p.Color.Validate()
	if errColor != nil {
		return errColor
	}

	for _, image := range p.Images {
		errImage := image.Validate()
		if errImage != nil {
			return errImage
		}
	}

	return nil
}
