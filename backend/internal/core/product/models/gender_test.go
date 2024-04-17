package models_test

import (
	"ecommerce/internal/core/product/models"
	"testing"
	"time"
)

func TestGender(t *testing.T) {
	testCases := genderUseCaseTests()

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func genderUseCaseTests() []UseCaseTest[models.Gender] {
	return []UseCaseTest[models.Gender]{
		{
			data: models.Gender{
				ID:        "1",
				Name:      "",
				CreatedAt: time.Now(),
			},
			expected: models.ErrNameGenderIsEmpty,
		},
		{
			data: models.Gender{
				ID:        "2",
				Name:      "1",
				CreatedAt: time.Now(),
			},
			expected: models.ErrNameGenderMustHaveOneCharacter,
		},
		{
			data: models.Gender{
				ID:        "3",
				Name:      makeAnyLongString(51),
				CreatedAt: time.Now(),
			},
			expected: models.ErrNameGenderNameIsLong,
		},

		{
			data: models.Gender{
				ID:        "4",
				Name:      "aa",
				CreatedAt: time.Now(),
			},
			expected: nil,
		},
	}
}
