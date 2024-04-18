package models_test

import (
	"ecommerce/internal/core/product/models"
	"testing"
	"time"
)

func TestInvalidBrand(t *testing.T) {
	testCases := []UseCaseTest[models.Brand]{}

	testCases = append(testCases, makeUseCaseBrand("1", "", models.ErrBrandNameIsEmpty))
	testCases = append(testCases, makeUseCaseBrand("2", "a", models.ErrBrandNameMustHaveOneCharacter))
	testCases = append(testCases, makeUseCaseBrand("3", makeAnyLongString(51), models.ErrBrandNameNameIsLong))

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func TestValidBrand(t *testing.T) {
	testCases := []UseCaseTest[models.Brand]{}

	testCases = append(testCases, makeUseCaseBrand("1", "aa", nil))
	testCases = append(testCases, makeUseCaseBrand("2", makeAnyLongString(50), nil))

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func makeUseCaseBrand(id, name string, expected error) UseCaseTest[models.Brand] {
	return UseCaseTest[models.Brand]{
		data:     makeBrand(id, name),
		expected: expected,
	}
}

func makeBrand(id, name string) models.Brand {
	return models.Brand{
		ID:        id,
		Name:      name,
		CreatedAt: time.Now(),
	}
}
