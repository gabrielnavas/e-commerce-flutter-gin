package models_test

import (
	"ecommerce/internal/core/product/models"
	"fmt"
	"testing"
)

func TestImage(t *testing.T) {
	testCases := imageUseCaseTests()

	for _, testCase := range testCases {
		received := testCase.data.Validate()
		verifyTest(t, received, testCase.expected)
	}
}

func imageUseCaseTests() []UseCaseTest[models.Image] {
	m := []UseCaseTest[models.Image]{}

	// invalids url
	invalidUrls := []string{
		"", "http", "https", "http://.com", "http:/google.com", "http//google.com", "http://google", "http://google.",
	}
	for index, imageUrl := range invalidUrls {
		m = append(m, UseCaseTest[models.Image]{
			data: models.Image{
				ID:       fmt.Sprintf("%d", index+1),
				Product:  models.Product{},
				ImageUrl: imageUrl,
			},
			expected: models.ErrUrlIsInvalid,
		})
	}

	// valids urls
	validUrls := []string{
		"http://google.com", "https://google.com",
	}
	for index, imageUrl := range validUrls {
		m = append(m, UseCaseTest[models.Image]{
			data: models.Image{
				ID:       fmt.Sprintf("%d", index+1),
				Product:  models.Product{},
				ImageUrl: imageUrl,
			},
			expected: nil,
		})
	}

	return m
}
