package models

import "time"

type Size struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt time.Time
}
