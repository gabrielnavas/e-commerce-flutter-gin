package models_test

import (
	"ecommerce/internal/core/product/models"
	"testing"
	"time"
)

func TestInvalidGender(t *testing.T) {
	testCases := []UseCaseTest[models.Gender]{}

	testCases = append(testCases, makeUseCaseGender("1", "", models.ErrGenderNameIsEmpty))
	testCases = append(testCases, makeUseCaseGender("2", "a", models.ErrGenderNameMustHaveOneCharacter))
	testCases = append(testCases, makeUseCaseGender("3", makeAnyLongString(51), models.ErrGenderNameNameIsLong))

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func TestValidGender(t *testing.T) {
	testCases := []UseCaseTest[models.Gender]{}

	testCases = append(testCases, makeUseCaseGender("1", "aa", nil))
	testCases = append(testCases, makeUseCaseGender("2", makeAnyLongString(50), nil))

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func makeUseCaseGender(id, name string, expected error) UseCaseTest[models.Gender] {
	return UseCaseTest[models.Gender]{
		data:     makeGender(id, name),
		expected: expected,
	}
}

func makeGender(id, name string) models.Gender {
	return models.Gender{
		ID:        id,
		Name:      name,
		CreatedAt: time.Now(),
	}
}
