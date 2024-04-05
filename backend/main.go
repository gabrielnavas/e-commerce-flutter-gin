package main

import "os"

func main() {
	TOKEN_SECRET := os.Getenv("TOKEN_SECRET")

	r := Routes(TOKEN_SECRET)
	r.Run(":8090")
}
