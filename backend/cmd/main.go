package main

import (
	"ecommerce/cmd/env"
	"ecommerce/pkg/routes"
)

// add swagger doc api
func main() {
	r := routes.Routes(env.TOKEN_JWT_SECRET)
	r.Run(":8090")
}
