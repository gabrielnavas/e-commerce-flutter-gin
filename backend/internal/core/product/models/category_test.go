package models_test

import (
	"ecommerce/internal/core/product/models"
	"testing"
	"time"
)

func TestInvalidCategory(t *testing.T) {
	testCases := []UseCaseTest[models.Category]{}

	testCases = append(testCases, makeUseCaseCategory("1", "", models.ErrCategoryNameIsEmpty))
	testCases = append(testCases, makeUseCaseCategory("2", "a", models.ErrCategoryNameMustHaveOneCharacter))
	testCases = append(testCases, makeUseCaseCategory("3", makeAnyLongString(51), models.ErrCategoryNameNameIsLong))

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func TestValidCategory(t *testing.T) {
	testCases := []UseCaseTest[models.Category]{}

	testCases = append(testCases, makeUseCaseCategory("1", "aa", nil))
	testCases = append(testCases, makeUseCaseCategory("2", makeAnyLongString(50), nil))

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func makeUseCaseCategory(id, name string, expected error) UseCaseTest[models.Category] {
	return UseCaseTest[models.Category]{
		data:     makeCategory(id, name),
		expected: expected,
	}
}

func makeCategory(id, name string) models.Category {
	return models.Category{
		ID:        id,
		Name:      name,
		CreatedAt: time.Now(),
	}
}
