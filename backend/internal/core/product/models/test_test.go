package models_test

import "testing"

type UseCaseTest[T any] struct {
	data     T
	expected error
}

func makeAnyLongString(length int) (longStr string) {
	for i := 0; i < length; i++ {
		longStr += "a"
	}
	return longStr
}

func verifyTest(t *testing.T, received, expected any) {
	if received != expected {
		t.Errorf("Received: '%v'. Expected: '%v.'", received, expected)
	}
}
