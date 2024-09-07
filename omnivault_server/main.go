package main

import (
	"log"
	"net/http"
)

func main() {
	mux := http.NewServeMux()

	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file:", err)
	}
}
