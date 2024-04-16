package models_test

type UseCaseTest[T any] struct {
	data     T
	expected error
}

func anyLongString(length int) (longStr string) {
	for i := 0; i < length; i++ {
		longStr += "a"
	}
	return longStr
}
