package models

import "time"

type Color struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt time.Time
}
