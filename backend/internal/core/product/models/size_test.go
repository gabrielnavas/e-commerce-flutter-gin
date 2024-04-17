package models_test

import (
	"ecommerce/internal/core/product/models"
	"testing"
	"time"
)

func TestSize(t *testing.T) {
	testCases := sizeUseCaseTests()

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func sizeUseCaseTests() []UseCaseTest[models.Size] {
	return []UseCaseTest[models.Size]{
		{
			data: models.Size{
				ID:        "1",
				Name:      "",
				CreatedAt: time.Now(),
			},
			expected: models.ErrSizeNameIsEmpty,
		},
		{
			data: models.Size{
				ID:        "2",
				Name:      "1",
				CreatedAt: time.Now(),
			},
			expected: models.ErrSizeNameMustHaveOneCharacter,
		},
		{
			data: models.Size{
				ID:        "3",
				Name:      makeAnyLongString(21),
				CreatedAt: time.Now(),
			},
			expected: models.ErrSizeNameIsLong,
		},

		{
			data: models.Size{
				ID:        "4",
				Name:      "aa",
				CreatedAt: time.Now(),
			},
			expected: nil,
		},
	}
}
