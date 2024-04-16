package models_test

import (
	"ecommerce/internal/core/product/models"
	"testing"
	"time"
)

func TestCategory(t *testing.T) {
	testCases := categoryUseCaseTests()

	for _, testCase := range testCases {
		received := testCase.data.Validate()

		if received != testCase.expected {
			t.Errorf("received %v expected %v", received, testCase.expected)
		}
	}
}

func categoryUseCaseTests() []UseCaseTest[models.Category] {
	return []UseCaseTest[models.Category]{
		{
			data: models.Category{
				ID:        "1",
				Name:      "",
				CreatedAt: time.Now(),
			},
			expected: models.ErrNameCategoryIsEmpty,
		},
		{
			data: models.Category{
				ID:        "2",
				Name:      "1",
				CreatedAt: time.Now(),
			},
			expected: models.ErrNameCategoryMustHaveOneCharacter,
		},
		{
			data: models.Category{
				ID:        "3",
				Name:      anyLongString(51),
				CreatedAt: time.Now(),
			},
			expected: models.ErrNameCategoryNameIsLong,
		},
	}
}
