package products

import (
	"context"
	"ecommerce/internal/core/product/models"
	"ecommerce/internal/repository"
	"fmt"
	"time"

	"github.com/google/uuid"
)

type InititalData struct {
	productRepository repository.ProductRepository
}

func NewInititalData(productRepository repository.ProductRepository) *InititalData {
	return &InititalData{productRepository: productRepository}
}

func (initData *InititalData) Init(ctx context.Context) {
	initData.brands(ctx)
	initData.categories(ctx)
	initData.colors(ctx)
	initData.genders(ctx)
	initData.sizes(ctx)
}

func (initData *InititalData) brands(ctx context.Context) {
	brands := []models.Brand{
		{
			ID:        uuid.NewString(),
			Name:      "Adidas",
			CreatedAt: time.Now(),
		}, {
			ID:        uuid.NewString(),
			Name:      "Nike",
			CreatedAt: time.Now(),
		}, {
			ID:        uuid.NewString(),
			Name:      "Diesel",
			CreatedAt: time.Now(),
		}, {
			ID:        uuid.NewString(),
			Name:      "Jack & Jones",
			CreatedAt: time.Now(),
		},
	}

	for _, brand := range brands {
		b, err := initData.productRepository.FindBrandByName(ctx, brand.Name)
		if err != nil {
			panic(err)
		}
		if b != nil {
			panic(fmt.Errorf("[*] - brand name=%s already exists", brand.Name))
		} else {
			initData.productRepository.AddBrand(ctx, brand)
		}
	}
}

func (initData *InititalData) genders(ctx context.Context) {
	genders := []models.Gender{
		{
			ID:        uuid.NewString(),
			Name:      "Woman",
			CreatedAt: time.Now(),
		}, {
			ID:        uuid.NewString(),
			Name:      "Man",
			CreatedAt: time.Now(),
		},
		{
			ID:        uuid.NewString(),
			Name:      "Boys",
			CreatedAt: time.Now(),
		},
		{
			ID:        uuid.NewString(),
			Name:      "Girl",
			CreatedAt: time.Now(),
		}, {
			ID:        uuid.NewString(),
			Name:      "All",
			CreatedAt: time.Now(),
		},
	}

	for _, gender := range genders {
		b, err := initData.productRepository.FindGenderByName(ctx, gender.Name)
		if err != nil {
			panic(err)
		}
		if b != nil {
			panic(fmt.Errorf("[*] - gender name=%s already exists", gender.Name))
		} else {
			initData.productRepository.AddGender(ctx, gender)
		}
	}
}

func (initData *InititalData) colors(ctx context.Context) {
	colors := []models.Color{
		{
			ID:        uuid.NewString(),
			Name:      "Red",
			CreatedAt: time.Now(),
		}, {
			ID:        uuid.NewString(),
			Name:      "Blue",
			CreatedAt: time.Now(),
		}, {
			ID:        uuid.NewString(),
			Name:      "Green",
			CreatedAt: time.Now(),
		}, {
			ID:        uuid.NewString(),
			Name:      "Cyan",
			CreatedAt: time.Now(),
		},
	}

	for _, color := range colors {
		b, err := initData.productRepository.FindColorByName(ctx, color.Name)
		if err != nil {
			panic(err)
		}
		if b != nil {
			panic(fmt.Errorf("[*] - color name=%s already exists", color.Name))
		} else {
			initData.productRepository.AddColor(ctx, color)
		}
	}
}

func (initData *InititalData) sizes(ctx context.Context) {
	sizes := []models.Size{
		{
			ID:        uuid.NewString(),
			Name:      "Red",
			CreatedAt: time.Now(),
		},
	}

	for _, size := range sizes {
		b, err := initData.productRepository.FindSizeByName(ctx, size.Name)
		if err != nil {
			panic(err)
		}
		if b != nil {
			panic(fmt.Errorf("[*] - color name=%s already exists", size.Name))
		} else {
			initData.productRepository.AddSize(ctx, size)
		}
	}
}

func (initData *InititalData) categories(ctx context.Context) {
	categories := []models.Category{
		{
			ID:        uuid.NewString(),
			Name:      "Jeans",
			CreatedAt: time.Now(),
		},
		{
			ID:        uuid.NewString(),
			Name:      "Shorts",
			CreatedAt: time.Now(),
		},
		{
			ID:        uuid.NewString(),
			Name:      "Skirts",
			CreatedAt: time.Now(),
		},
	}

	for _, category := range categories {
		b, err := initData.productRepository.FindSizeByName(ctx, category.Name)
		if err != nil {
			panic(err)
		}
		if b != nil {
			panic(fmt.Errorf("[*] - category name=%s already exists", category.Name))
		} else {
			initData.productRepository.AddCategory(ctx, category)
		}
	}
}
