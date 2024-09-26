package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/joho/godotenv"
	postgres "github.com/Mahaveer86619/OmniVault/src/database"
	middleware "github.com/Mahaveer86619/OmniVault/src/middlewares"
	handlers "github.com/Mahaveer86619/OmniVault/src/handlers"
)

func main() {
	mux := http.NewServeMux()

	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file:", err)
	}

	db, err := postgres.ConnectDB()
	if err != nil {
		fmt.Println("Error connecting to database:", err)
	}

	defer postgres.CloseDBConnection(db)

	err = postgres.CreateTables(db)
	if err != nil {
		log.Fatal("Error creating tables:", err)
	}

	postgres.SetDBConnection(db)

	fmt.Println(welcomeString)
	fmt.Println("Successfully connected to the database!")
	handleFunctions(mux)

	if err := http.ListenAndServe(":5060", mux); err != nil {
		fmt.Println("Error running server:", err)
	}
}

var welcomeString = `

 $$$$$$\                          $$\ 
$$  __$$\                         \__|
$$ /  $$ |$$$$$$\$$$$\  $$$$$$$\  $$\ 
$$ |  $$ |$$  _$$  _$$\ $$  __$$\ $$ |
$$ |  $$ |$$ / $$ / $$ |$$ |  $$ |$$ |
$$ |  $$ |$$ | $$ | $$ |$$ |  $$ |$$ |
 $$$$$$  |$$ | $$ | $$ |$$ |  $$ |$$ |
 \______/ \__| \__| \__|\__|  \__|\__|
                                      
                                      
$$\    $$\                    $$\   $$\     
$$ |   $$ |                   $$ |  $$ |    
$$ |   $$ |$$$$$$\  $$\   $$\ $$ |$$$$$$\   
\$$\  $$  |\____$$\ $$ |  $$ |$$ |\_$$  _|  
 \$$\$$  / $$$$$$$ |$$ |  $$ |$$ |  $$ |    
  \$$$  / $$  __$$ |$$ |  $$ |$$ |  $$ |$$\ 
   \$  /  \$$$$$$$ |\$$$$$$  |$$ |  \$$$$  |
    \_/    \_______| \______/ \__|   \____/ 
                                                   
`

func handleFunctions(mux *http.ServeMux) {
	mux.HandleFunc("GET /", func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path == "/favicon.ico" {
			return
		}
		fmt.Fprint(w, welcomeString)
	}) 

	//* Auth routes
	mux.HandleFunc("POST /api/v1/auth/register", middleware.LoggingMiddleware(handlers.RegisterUserController))
	mux.HandleFunc("POST /api/v1/auth/authenticate", middleware.LoggingMiddleware(handlers.AuthenticateUserController))
	mux.HandleFunc("POST /api/v1/auth/forgot_password", middleware.LoggingMiddleware(handlers.SendPassResetCodeController))
	mux.HandleFunc("POST /api/v1/auth/check_code", middleware.LoggingMiddleware(handlers.CheckResetPassCodeController))
	mux.HandleFunc("POST /api/v1/auth/refresh", middleware.LoggingMiddleware(handlers.RefreshTokenController))

	//* User routes
	mux.Handle("GET /api/v1/users", middleware.AuthMiddleware(http.HandlerFunc(handlers.GetUserByIDController)))
	mux.Handle("PATCH /api/v1/users", middleware.AuthMiddleware(http.HandlerFunc(handlers.UpdateUserController)))
	mux.Handle("DELETE /api/v1/users", middleware.AuthMiddleware(http.HandlerFunc(handlers.DeleteUserController)))

	//* Notes routes
	mux.Handle("POST /api/v1/notes", middleware.AuthMiddleware(http.HandlerFunc(handlers.CreateNoteHandler)))
	mux.Handle("GET /api/v1/notes", middleware.AuthMiddleware(http.HandlerFunc(handlers.GetAllNotesHandler)))
	mux.Handle("GET /api/v1/notes/id", middleware.AuthMiddleware(http.HandlerFunc(handlers.GetNoteByIdHandler)))
	mux.Handle("PATCH /api/v1/notes/id", middleware.AuthMiddleware(http.HandlerFunc(handlers.UpdateNoteHandler)))
	mux.Handle("DELETE /api/v1/notes/id", middleware.AuthMiddleware(http.HandlerFunc(handlers.DeleteNoteHandler)))

	//* Admin routes
	mux.HandleFunc("GET /api/v1/admin/users", middleware.LoggingMiddleware(handlers.GetAllUsersController))
	mux.HandleFunc("POST /api/v1/dev/email", middleware.LoggingMiddleware(handlers.SendBasicEmailHandler))
	mux.HandleFunc("POST /api/v1/dev/html_email", middleware.LoggingMiddleware(handlers.SendBasicHTMLEmailHandler))
}
