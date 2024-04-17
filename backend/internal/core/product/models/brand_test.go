package models_test

import (
	"ecommerce/internal/core/product/models"
	"testing"
	"time"
)

func TestBrand(t *testing.T) {
	testCases := brandUseCaseTests()

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func brandUseCaseTests() []UseCaseTest[models.Brand] {
	return []UseCaseTest[models.Brand]{
		{
			data: models.Brand{
				ID:        "1",
				Name:      "",
				CreatedAt: time.Now(),
			},
			expected: models.ErrNameBrandIsEmpty,
		},
		{
			data: models.Brand{
				ID:        "2",
				Name:      "1",
				CreatedAt: time.Now(),
			},
			expected: models.ErrNameBrandMustHaveOneCharacter,
		},
		{
			data: models.Brand{
				ID:        "3",
				Name:      makeAnyLongString(51),
				CreatedAt: time.Now(),
			},
			expected: models.ErrNameBrandNameIsLong,
		},
	}
}
