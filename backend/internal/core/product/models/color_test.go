package models_test

import (
	"ecommerce/internal/core/product/models"
	"testing"
	"time"
)

func TestColor(t *testing.T) {
	testCases := colorUseCaseTests()

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func colorUseCaseTests() []UseCaseTest[models.Color] {
	return []UseCaseTest[models.Color]{
		{
			data: models.Color{
				ID:        "1",
				Name:      "",
				CreatedAt: time.Now(),
			},
			expected: models.ErrNameColorIsEmpty,
		},
		{
			data: models.Color{
				ID:        "2",
				Name:      "1",
				CreatedAt: time.Now(),
			},
			expected: models.ErrNameColorMustHaveOneCharacter,
		},
		{
			data: models.Color{
				ID:        "3",
				Name:      makeAnyLongString(51),
				CreatedAt: time.Now(),
			},
			expected: models.ErrNameColorNameIsLong,
		},
	}
}
