package repository

import (
	"database/sql"
	"ecommerce/internal/model"
)

type UserRepository interface {
	AddUser(user model.User) error
	FindUserByEmail(email string) (*model.User, error)
}

func NewUserRepository(db *sql.DB) UserRepository {
	return &UserPostgresRepository{db: db}
}

type UserPostgresRepository struct {
	db *sql.DB
}

func (r *UserPostgresRepository) AddUser(user model.User) error {
	_, err := r.db.Exec(`
		INSERT INTO users.users (
			id,
			full_name, 
			email, 
			password_hash
		) VALUES (
			$1, $2, $3, $4
		)`, user.ID, user.Fullname, user.Email, user.Password)
	return err
}

func (r *UserPostgresRepository) FindUserByEmail(email string) (*model.User, error) {
	var user model.User
	err := r.db.QueryRow(`
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
			email = $1
	`, email).Scan(&user.ID, &user.Fullname, &user.Email, &user.Password, &user.ProfileImageUrl, &user.PhoneNumber, &user.BirthDay)

	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, err
	}

	return &user, nil
}
