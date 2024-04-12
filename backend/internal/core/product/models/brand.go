package models

import "time"

type Brand struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt time.Time
}
