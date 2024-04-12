package usecases

type Product interface {
	insert(data ProductDBInput)
}

type ProductDBInput struct {
	Description string
	BrandID     string
	CategoryID  string
}

func NewProduct() Product {
	return &ProductDB{}
}

type ProductDB struct {
}

func (i *ProductDB) insert(data ProductDBInput) {

}
