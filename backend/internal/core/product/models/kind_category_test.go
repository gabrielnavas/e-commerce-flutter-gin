package models_test

import (
	"ecommerce/internal/core/product/models"
	"testing"
	"time"
)

func TestInvalidKindCategory(t *testing.T) {
	testCases := []UseCaseTest[models.KindCategory]{}

	testCases = append(testCases, makeUseCaseKindCategory("1", "", models.ErrKindCategoryNameIsEmpty))
	testCases = append(testCases, makeUseCaseKindCategory("2", "a", models.ErrKindCategoryNameMustHaveOneCharacter))
	testCases = append(testCases, makeUseCaseKindCategory("3", makeAnyLongString(51), models.ErrKindCategoryNameNameIsLong))

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func TestValidKindCategory(t *testing.T) {
	testCases := []UseCaseTest[models.KindCategory]{}

	testCases = append(testCases, makeUseCaseKindCategory("1", "aa", nil))
	testCases = append(testCases, makeUseCaseKindCategory("2", makeAnyLongString(20), nil))

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func makeUseCaseKindCategory(id, name string, expected error) UseCaseTest[models.KindCategory] {
	return UseCaseTest[models.KindCategory]{
		data:     makeKindCategory(id, name),
		expected: expected,
	}
}

func makeKindCategory(id, name string) models.KindCategory {
	return models.KindCategory{
		ID:        id,
		Name:      name,
		CreatedAt: time.Now(),
	}
}
