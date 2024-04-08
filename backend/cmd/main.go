package main

import (
	"ecommerce/pkg/routes"
	"os"
)

// add swagger doc api
// create user repository using sql postgres
// create service signin
// create service signu
func main() {
	TOKEN_SECRET := os.Getenv("TOKEN_SECRET")

	r := routes.Routes(TOKEN_SECRET)
	r.Run(":8090")
}
