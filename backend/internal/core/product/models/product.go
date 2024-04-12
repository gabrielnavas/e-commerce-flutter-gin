package models

import (
	"ecommerce/internal/core/auth/models"
	"time"
)

type Product struct {
	ID           string
	Name         string
	Description  string
	Brand        Brand
	Category     Category
	OwnerCreated models.User
	Color        Color
	Size         Size
	CreatedAt    time.Time
	UpdatedAt    time.Time
	Images       []Image
}
