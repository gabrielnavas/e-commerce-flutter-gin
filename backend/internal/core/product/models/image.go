package models

import (
	"errors"
	"regexp"
)

var (
	ErrUrlIsInvalid = errors.New("url of the image is invalid")
)

type Image struct {
	ID       string
	Product  Product
	ImageUrl string
}

func (i *Image) Validate() error {
	regex := regexp.MustCompile(`^(http|https):\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}(\/\S*)?$`)
	if regex.MatchString(i.ImageUrl) {
		return nil
	}

	return ErrUrlIsInvalid
}
