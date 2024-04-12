package models

import "time"

type Gender struct {
	ID        string
	Name      string
	CreatedAt time.Time
	UpdatedAt time.Time
}
