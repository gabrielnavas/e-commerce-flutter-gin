package repository

import (
	"database/sql"
	"ecommerce/internal/model"
)

type UserRepository interface {
	AddUser(user model.User) error
	FindUserByID(db *sql.DB, userID string) (model.User, error)
}

func NewUserRepository(db *sql.DB) UserRepository {
	return &UserPostgresRepository{db: db}
}

type UserPostgresRepository struct {
	db *sql.DB
}

func (r *UserPostgresRepository) AddUser(user model.User) error {
	_, err := r.db.Exec(`
		INSERT INTO users (
			full_name, 
			email, 
			password_hash
		) VALUES (
			$1, $2, $3
		)`, user.Fullname, user.Email, user.Password)
	return err
}

func (r *UserPostgresRepository) FindUserByID(db *sql.DB, userID string) (model.User, error) {
	var user model.User
	err := db.QueryRow(`
		SELECT
			id,
			full_name,
			email,
			password_hash,
			profile_image_url,
			phone_number,
			birth_day
		FROM 
			users.users  
		WHERE 
			id = $1
	`, userID).Scan(&user.ID, &user.Fullname, &user.Email, &user.Password, &user.ProfileImageUrl, &user.PhoneNumber, &user.BirthDay)
	return user, err
}
