package service

import (
	"math/rand"
	"strconv"
	"time"
)

type randomNumbers struct {
	rng      *rand.Rand
	nNumbers int
}

func NewRandomNumbers(nNumbers int) *randomNumbers {
	source := rand.NewSource(time.Now().UnixNano())
	rng := rand.New(source)
	return &randomNumbers{rng: rng, nNumbers: nNumbers}
}

func (r *randomNumbers) generateRandomNumbers() string {
	source := rand.NewSource(time.Now().UnixNano())
	rng := rand.New(source)

	var result string

	for i := 0; i < 6; i++ {
		randomNumber := rng.Intn(9)
		result += strconv.Itoa(randomNumber)
	}

	return result
}
