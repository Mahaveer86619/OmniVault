package db

import (
	"database/sql"
	"fmt"
	"os"

	_ "github.com/lib/pq"
)

var db *sql.DB

func ConnectDB() (*sql.DB, error) {
	db, err := sql.Open("postgres", os.Getenv("DATABASE_URL"))
	if err != nil {
		fmt.Printf("Unable to connect to database: %v", err)
	}

	return db, nil
}

// SetDBConnection sets the database connection
func SetDBConnection(conn *sql.DB) {
	db = conn
}

// GetDBConnection returns the database connection
func GetDBConnection() *sql.DB {
	return db
}

func CloseDBConnection(conn *sql.DB) {
	conn.Close()
}

func CreateTables(conn *sql.DB) error {
	queries := []string{
		`CREATE TABLE IF NOT EXISTS auth (
  			id UUID PRIMARY KEY,
  			name TEXT UNIQUE NOT NULL,
  			email TEXT UNIQUE NOT NULL,
  			password TEXT NOT NULL
		);`,
		`CREATE TABLE IF NOT EXISTS profiles (
  			id UUID PRIMARY KEY,
  			name TEXT UNIQUE NOT NULL,
  			email TEXT UNIQUE NOT NULL,
  			profile_pic TEXT,
  			created_at TEXT,
  			updated_at TEXT
		);`,
		`CREATE TABLE IF NOT EXISTS forgot_password (
  			id UUID PRIMARY KEY,
  			email TEXT UNIQUE NOT NULL,
  			code TEXT UNIQUE NOT NULL
		);`,
		`CREATE TABLE IF NOT EXISTS notes (
			id UUID PRIMARY KEY,
			user_id UUID REFERENCES profiles(id) NOT NULL,
			title TEXT NOT NULL,
			content TEXT,
			cover_image_url TEXT,
  			created_at TEXT,
  			updated_at TEXT
		);`,
		`CREATE TABLE IF NOT EXISTS secrets (
			id UUID PRIMARY KEY,
			user_id UUID REFERENCES profiles(id) NOT NULL,
			title TEXT NOT NULL,
			json_pairs TEXT,
  			created_at TEXT,
  			updated_at TEXT
		);`,
		`CREATE TABLE IF NOT EXISTS todos (
			id UUID PRIMARY KEY,
			user_id UUID REFERENCES profiles(id) NOT NULL,
			title TEXT NOT NULL,
			description TEXT,
			completed BOOLEAN,
  			created_at TEXT,
  			updated_at TEXT
		);`,
		`CREATE TABLE IF NOT EXISTS voice_notes (
			id UUID PRIMARY KEY,
			user_id UUID REFERENCES profiles(id) NOT NULL,
			title TEXT NOT NULL,
			note_url TEXT NOT NULL,
  			created_at TEXT,
  			updated_at TEXT
		);`,
	}

	for _, query := range queries {
		_, err := conn.Exec(query)
		if err != nil {
			return fmt.Errorf("error creating table: %w", err)
		}
	}

	return nil
}
