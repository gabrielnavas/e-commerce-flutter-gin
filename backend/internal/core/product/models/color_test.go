package models_test

import (
	"ecommerce/internal/core/product/models"
	"testing"
	"time"
)

func TestInvalidColor(t *testing.T) {
	testCases := []UseCaseTest[models.Color]{}

	testCases = append(testCases, makeUseCaseColor("1", "", models.ErrColorNameIsEmpty))
	testCases = append(testCases, makeUseCaseColor("2", "a", models.ErrColorNameMustHaveOneCharacter))
	testCases = append(testCases, makeUseCaseColor("3", makeAnyLongString(51), models.ErrColorNameNameIsLong))

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func TestValidColor(t *testing.T) {
	testCases := []UseCaseTest[models.Color]{}

	testCases = append(testCases, makeUseCaseColor("1", "aa", nil))
	testCases = append(testCases, makeUseCaseColor("2", makeAnyLongString(50), nil))

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func makeUseCaseColor(id, name string, expected error) UseCaseTest[models.Color] {
	return UseCaseTest[models.Color]{
		data:     makeColor(id, name),
		expected: expected,
	}
}

func makeColor(id, name string) models.Color {
	return models.Color{
		ID:        id,
		Name:      name,
		CreatedAt: time.Now(),
	}
}
