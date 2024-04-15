package models_test

type UseCaseTest[T any] struct {
	data     T
	expected error
}
