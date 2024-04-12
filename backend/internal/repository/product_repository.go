package repository

import (
	"context"
	"database/sql"
	"ecommerce/internal/core/product/models"
)

type ProductRepository interface {
	AddProduct(context.Context, models.Product) error

	AddColor(context.Context, models.Color) error
	FindColorByName(ctx context.Context, name string) (*models.Color, error)

	AddCategory(context.Context, models.Category) error
	FindCategoryByName(ctx context.Context, name string) (*models.Category, error)

	AddSize(context.Context, models.Size) error
	FindSizeByName(ctx context.Context, name string) (*models.Size, error)

	AddBrand(context.Context, models.Brand) error
	FindBrandByName(ctx context.Context, name string) (*models.Brand, error)

	AddGender(context.Context, models.Gender) error
	FindGenderByName(ctx context.Context, name string) (*models.Gender, error)
}

func NewProductRepository(db *sql.DB) ProductRepository {
	return &ProductPostgresRepository{db: db}
}

type ProductPostgresRepository struct {
	db *sql.DB
}

func (r *ProductPostgresRepository) AddProduct(ctx context.Context, p models.Product) error {

	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return err
	}

	// insert product
	_, err = tx.ExecContext(ctx, `
		INSERT INTO products.products (
			id,
			name, 
			description, 
			created_at,
			updated_at,
			brand_id,
			categories_id,
			owner_created_id,
			size_id,
			color_id
		) VALUES (
			$1, $2, $3, $4, $5, $6, $7, $8, $9, $10
		)`, p.ID, p.Name, p.Description, p.CreatedAt, p.UpdatedAt, p.Brand.ID, p.Category.ID, p.OwnerCreated.ID, p.Size.ID, p.Color.ID)
	if err != nil {
		tx.Rollback()
		return err
	}

	// insert product images
	for _, img := range p.Images {
		_, err = tx.ExecContext(ctx, `
			INSERT INTO products.images (
				id,
				name, 
				products_id, 
				image_url
			) VALUES (
				$1, $2, $3, $4
			)`, img.ID, img.Product.ID, img.ImageUrl)
		if err != nil {
			tx.Rollback()
			return err
		}
	}

	err = tx.Commit()
	if err != nil {
		return err
	}

	return err
}

func (r *ProductPostgresRepository) AddColor(ctx context.Context, c models.Color) error {
	_, err := r.db.Exec(`
		INSERT INTO products.colors (
			id,
			name, 
			created_at,
			updated_at,
		) VALUES (
			$1, $2, $3, $4
		)`, c.ID, c.Name, c.CreatedAt, c.UpdatedAt)
	return err
}

func (r *ProductPostgresRepository) FindColorByName(ctx context.Context, name string) (*models.Color, error) {
	query := `
		SELECT 
			id, name, created_at, updated_at
		FROM 
			products.colors
		WHERE 
			name = $1
	`
	r.db.QueryRow(query)

	var c models.Color
	err := r.db.QueryRow(query, name).Scan(&c.ID, &c.Name, &c.CreatedAt, &c.UpdatedAt)

	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, err
	}

	return &c, nil
}

func (r *ProductPostgresRepository) AddCategory(ctx context.Context, c models.Category) error {
	_, err := r.db.Exec(`
		INSERT INTO products.categories (
			id,
			name, 
			created_at,
			updated_at,
		) VALUES (
			$1, $2, $3, $4
		)`, c.ID, c.Name, c.CreatedAt, c.UpdatedAt)
	return err
}

func (r *ProductPostgresRepository) FindCategoryByName(ctx context.Context, name string) (*models.Category, error) {
	query := `
		SELECT 
			id, name, created_at, updated_at
		FROM 
			products.categories
		WHERE 
			name = $1
	`
	r.db.QueryRow(query)

	var c models.Category
	err := r.db.QueryRow(query, name).Scan(&c.ID, &c.Name, &c.CreatedAt, &c.UpdatedAt)

	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, err
	}

	return &c, nil
}

func (r *ProductPostgresRepository) AddSize(ctx context.Context, s models.Size) error {
	_, err := r.db.Exec(`
		INSERT INTO products.sizes (
			id,
			name, 
			created_at,
			updated_at,
		) VALUES (
			$1, $2, $3, $4
		)`, s.ID, s.Name, s.CreatedAt, s.UpdatedAt)
	return err
}

func (r *ProductPostgresRepository) FindSizeByName(ctx context.Context, name string) (*models.Size, error) {
	query := `
		SELECT 
			id, name, created_at, updated_at
		FROM 
			products.categories
		WHERE 
			name = $1
	`
	r.db.QueryRow(query)

	var s models.Size
	err := r.db.QueryRow(query, name).Scan(&s.ID, &s.Name, &s.CreatedAt, &s.UpdatedAt)

	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, err
	}

	return &s, nil
}

func (r *ProductPostgresRepository) AddBrand(ctx context.Context, b models.Brand) error {
	_, err := r.db.Exec(`
		INSERT INTO products.sizes (
			id,
			name, 
			created_at,
			updated_at,
		) VALUES (
			$1, $2, $3, $4
		)`, b.ID, b.Name, b.CreatedAt, b.UpdatedAt)
	return err
}

func (r *ProductPostgresRepository) FindBrandByName(ctx context.Context, name string) (*models.Brand, error) {
	query := `
		SELECT 
			id, name, created_at, updated_at
		FROM 
			products.categories
		WHERE 
			name = $1
	`
	r.db.QueryRow(query)

	var b models.Brand
	err := r.db.QueryRow(query, name).Scan(&b.ID, &b.Name, &b.CreatedAt, &b.UpdatedAt)

	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, err
	}

	return &b, nil
}

func (r *ProductPostgresRepository) AddGender(ctx context.Context, g models.Gender) error {
	_, err := r.db.Exec(`
		INSERT INTO products.genders (
			id,
			name, 
			created_at,
			updated_at,
		) VALUES (
			$1, $2, $3, $4
		)`, g.ID, g.Name, g.CreatedAt, g.UpdatedAt)
	return err
}

func (r *ProductPostgresRepository) FindGenderByName(ctx context.Context, name string) (*models.Gender, error) {
	query := `
		SELECT 
			id, name, created_at, updated_at
		FROM 
			products.genders
		WHERE 
			name = $1
	`
	r.db.QueryRow(query)

	var g models.Gender
	err := r.db.QueryRow(query, name).Scan(&g.ID, &g.Name, &g.CreatedAt, &g.UpdatedAt)

	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, err
	}

	return &g, nil
}
