package models_test

import (
	modelAuth "ecommerce/internal/core/auth/models"
	modelProducts "ecommerce/internal/core/product/models"
	"testing"
	"time"
)

func TestValidValidProductName(t *testing.T) {
	useCases := []UseCaseTest[modelProducts.Product]{}

	useCases = append(useCases, makeUseCaseProduct("4", makeAnyLongString(50), makeAnyLongString(50), nil))

	for _, usecase := range useCases {
		received := usecase.data.Validate()
		verifyTest(t, received, usecase.expected)
	}
}

func TestInvalidProductName(t *testing.T) {
	useCases := []UseCaseTest[modelProducts.Product]{}

	useCases = append(useCases, makeUseCaseProduct("1", "", makeAnyLongString(50), modelProducts.ErrProductNameIsEmpty))
	useCases = append(useCases, makeUseCaseProduct("2", "a", makeAnyLongString(50), modelProducts.ErrProductNameMustHaveOneCharacter))
	useCases = append(useCases, makeUseCaseProduct("3", makeAnyLongString(51), makeAnyLongString(50), modelProducts.ErrProductNameNameIsLong))

	for _, usecase := range useCases {
		received := usecase.data.Validate()
		verifyTest(t, received, usecase.expected)
	}
}

func TestValidValidProductDescription(t *testing.T) {
	useCases := []UseCaseTest[modelProducts.Product]{}

	useCases = append(useCases, makeUseCaseProduct("4", makeAnyLongString(50), makeAnyLongString(50), nil))

	for _, usecase := range useCases {
		received := usecase.data.Validate()
		verifyTest(t, received, usecase.expected)
	}
}

func TestInvalidProductDescription(t *testing.T) {
	useCases := []UseCaseTest[modelProducts.Product]{}

	useCases = append(useCases, makeUseCaseProduct("5", "valid_name", "", modelProducts.ErrProductDescriptionIsEmpty))
	useCases = append(useCases, makeUseCaseProduct("6", "valid_name", "a", modelProducts.ErrProductDescriptionMustHaveOneCharacter))
	useCases = append(useCases, makeUseCaseProduct("7", "valid_name", makeAnyLongString(101), modelProducts.ErrProductDescriptionNameIsLong))

	for _, usecase := range useCases {
		received := usecase.data.Validate()
		verifyTest(t, received, usecase.expected)
	}
}

func makeUseCaseProduct(id, name, description string, expected error) UseCaseTest[modelProducts.Product] {
	return UseCaseTest[modelProducts.Product]{
		data:     makeProduct(id, name, description),
		expected: expected,
	}
}

func makeProduct(id, name, description string) modelProducts.Product {
	return modelProducts.Product{
		ID:          id,
		Name:        name,
		Description: description,
		Brand: modelProducts.Brand{
			ID:        "1",
			Name:      "valid_name",
			CreatedAt: time.Now(),
		},
		Category: modelProducts.Category{
			ID:        "1",
			Name:      "valid_name",
			CreatedAt: time.Now(),
		},
		Size: modelProducts.Size{
			ID:        "1",
			Name:      "valid_name",
			CreatedAt: time.Now(),
		},
		Color: modelProducts.Color{
			ID:        "1",
			Name:      "valid_name",
			CreatedAt: time.Now(),
		},
		OwnerCreated: modelAuth.User{
			ID:       "1",
			Fullname: "primary_name second_name",
			Email:    "validemail@email.com",
			Password: "Ab!@1&3%",
		},
	}
}
