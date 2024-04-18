package models_test

import (
	"ecommerce/internal/core/product/models"
	"testing"
	"time"
)

func TestInvalidSize(t *testing.T) {
	testCases := []UseCaseTest[models.Size]{}

	testCases = append(testCases, makeUseCaseSize("1", "", models.ErrSizeNameIsEmpty))
	testCases = append(testCases, makeUseCaseSize("2", "a", models.ErrSizeNameMustHaveOneCharacter))
	testCases = append(testCases, makeUseCaseSize("3", makeAnyLongString(21), models.ErrSizeNameIsLong))

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func TestValidSize(t *testing.T) {
	testCases := []UseCaseTest[models.Size]{}

	testCases = append(testCases, makeUseCaseSize("1", "aa", nil))
	testCases = append(testCases, makeUseCaseSize("2", makeAnyLongString(20), nil))

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func makeUseCaseSize(id, name string, expected error) UseCaseTest[models.Size] {
	return UseCaseTest[models.Size]{
		data:     makeSize(id, name),
		expected: expected,
	}
}

func makeSize(id, name string) models.Size {
	return models.Size{
		ID:        id,
		Name:      name,
		CreatedAt: time.Now(),
	}
}
