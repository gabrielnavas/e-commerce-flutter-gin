package models

import (
	"ecommerce/internal/core/auth/models"
	"time"
)

type Product struct {
	ID          string
	Description string
	Brand       Brand
	Category    Category
	OwnerCreate models.User
	CreatedAt   time.Time
	UpdatedAt   time.Time
}
