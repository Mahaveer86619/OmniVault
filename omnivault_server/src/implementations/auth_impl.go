package implementations

import (
	"database/sql"
	"fmt"
	"net/http"

	db "github.com/Mahaveer86619/OmniVault/src/database"
	helpers "github.com/Mahaveer86619/OmniVault/src/helpers"
	middleware "github.com/Mahaveer86619/OmniVault/src/middlewares"
	services "github.com/Mahaveer86619/OmniVault/src/services"
	types "github.com/Mahaveer86619/OmniVault/src/types"

	"github.com/dgrijalva/jwt-go"
	"github.com/google/uuid"
)

func AuthenticateUser(credentials *types.AuthenticatingCredentials) (*types.UserResponse, int, error) {
	conn := db.GetDBConnection()

	search_query := `
	  SELECT *
	  FROM auth
	  WHERE email = $1
	`

	var authUser types.Auth

	// Search for user in database
	err := conn.QueryRow(
		search_query,
		credentials.Email,
	).Scan(
		&authUser.ID,
		&authUser.Name,
		&authUser.Email,
		&authUser.Password,
	)

	if err != nil {
		if err == sql.ErrNoRows {
			return nil, http.StatusNotFound, fmt.Errorf("user not found with email: %s", credentials.Email)
		}
		return nil, http.StatusInternalServerError, fmt.Errorf("error scanning row: %w", err)
	}

	// User found, but password is wrong
	if credentials.Password != authUser.Password {
		return nil, http.StatusUnauthorized, fmt.Errorf("wrong password")
	}

	// Generate tokens
	token, err := middleware.GenerateToken(authUser.Email)
	if err != nil {
		return nil, http.StatusInternalServerError, fmt.Errorf("error creating token: %w", err)
	}

	refreshToken, err := middleware.GenerateRefreshToken(authUser.Email)
	if err != nil {
		return nil, http.StatusInternalServerError, fmt.Errorf("error creating refresh token: %w", err)
	}

	// Return credentials for successful authentication
	credsToReturn := types.GenAuthResponseToReturn(authUser, token, refreshToken)
	return credsToReturn, http.StatusOK, nil
}

func RegisterUser(credentials *types.RegisteringCredentials) (*types.UserResponse, int, error) {
	conn := db.GetDBConnection()

	search_query := `
	  SELECT *
	  FROM auth
	  WHERE email = $1
	`
	insert_query_auth := `
		INSERT INTO auth (id, name, email, password)
		VALUES ($1, $2, $3, $4)
	`
	insert_query_profiles := `
		INSERT INTO profiles (id, name, email, profile_pic, created_at, updated_at)
		VALUES ($1, $2, $3, $4, $5, $6) RETURNING *
	`

	// If user already exists, return error
	var authUser types.Auth

	userNotFound := false
	err := conn.QueryRow(
		search_query,
		credentials.Email,
	).Scan(
		&authUser.ID,
		&authUser.Name,
		&authUser.Email,
		&authUser.Password,
	)

	if err != nil {
		if err == sql.ErrNoRows {
			// User not found, so create user
			userNotFound = true
		} else {
			return nil, http.StatusInternalServerError, fmt.Errorf("error scanning row: %w", err)
		}
	}

	// User already registered
	if !userNotFound {
		return nil, http.StatusInternalServerError, fmt.Errorf("user is already registerd with email: %s", credentials.Email)
	}

	var user types.User
	user.ID = uuid.New().String()

	// Create user
	_, err = conn.Exec(
		insert_query_auth,
		user.ID,
		credentials.Name,
		credentials.Email,
		credentials.Password,
	)

	if err != nil {
		return nil, http.StatusInternalServerError, fmt.Errorf("error creating user in auth: %w", err)
	}

	err = conn.QueryRow(
		insert_query_profiles,
		user.ID,
		credentials.Name,
		credentials.Email,
		"",
		helpers.GetCurrentDateTimeAsString(),
		helpers.GetCurrentDateTimeAsString(),
	).Scan(
		&user.ID,
		&user.Name,
		&user.Email,
		&user.ProfilePic,
		&user.CreatedAt,
		&user.UpdatedAt,
	)

	if err != nil {
		return nil, http.StatusInternalServerError, fmt.Errorf("error creating user profile: %w", err)
	}

	// Generate tokens
	token, err := middleware.GenerateToken(user.Email)
	if err != nil {
		return nil, http.StatusInternalServerError, fmt.Errorf("error creating token: %w", err)
	}

	refreshToken, err := middleware.GenerateRefreshToken(user.Email)
	if err != nil {
		return nil, http.StatusInternalServerError, fmt.Errorf("error creating refresh token: %w", err)
	}

	// Return credentials for successful registration
	credsToReturn := types.GenUserResponseFromUser(user, token, refreshToken)
	return credsToReturn, http.StatusOK, nil
}

func SendPassResetCode(email string) (int, error) {
	conn := db.GetDBConnection()

	insert_query := `
		INSERT INTO forgot_password (id, email, code)
		VALUES ($1, $2, $3) RETURNING *
	`
	select_user_query := `
	  SELECT *
	  FROM auth
	  WHERE email = $1
	`

	var authUser types.Auth

	// Search for user in database
	err := conn.QueryRow(
		select_user_query,
		email,
	).Scan(
		&authUser.ID,
		&authUser.Name,
		&authUser.Email,
		&authUser.Password,
	)

	if err != nil {
		if err == sql.ErrNoRows {
			return http.StatusNotFound, fmt.Errorf("provided email is not registered: %s", email)
		}
		return http.StatusInternalServerError, fmt.Errorf("error scanning row: %w", err)
	}

	var forgotPassword types.ForgotPassword
	forgotPassword.ID = uuid.New().String()
	forgotPassword.Email = email
	forgotPassword.Code = helpers.Gen6DigitCode()

	err = conn.QueryRow(
		insert_query,
		forgotPassword.ID,
		forgotPassword.Email,
		forgotPassword.Code,
	).Scan(
		&forgotPassword.ID,
		&forgotPassword.Email,
		&forgotPassword.Code,
	)

	if err != nil {
		return http.StatusInternalServerError, fmt.Errorf("error generating forgot password code: %w", err)
	}

	// Send email with forgot password code
	err = services.SendBasicHTMLEmail(
		[]string{email},
		"Reset your password",
		services.GeneratePasswordResetHTML(forgotPassword.Code, email),
	)

	if err != nil {
		return http.StatusInternalServerError, fmt.Errorf("error sending email: %w", err)
	}

	return http.StatusOK, nil
}

func CheckResetPassCode(code string, email string) (string, int, error) {
	conn := db.GetDBConnection()

	select_query := `
	  SELECT *
	  FROM forgot_password
	  WHERE email = $1
	`
	del_query := "DELETE FROM forgot_password WHERE id = $1"

	var forgotPassword types.ForgotPassword

	// Search for forgot password in database
	if err := conn.QueryRow(
		select_query,
		email,
	).Scan(
		&forgotPassword.ID,
		&forgotPassword.Email,
		&forgotPassword.Code,
	); err != nil {
		if err == sql.ErrNoRows {
			return "", http.StatusNotFound, fmt.Errorf("forgot password row not found with email: %s", email)
		}
		return "", http.StatusInternalServerError, fmt.Errorf("error scanning row: %w", err)
	}

	// Delete forgot password row if code is correct
	if forgotPassword.Code != code {
		return "", http.StatusBadRequest, fmt.Errorf("invalid code")
	}

	_, err := conn.Exec(del_query, forgotPassword.ID)
	if err != nil {
		return "", http.StatusInternalServerError, fmt.Errorf("error deleting row: %w", err)
	}

	return forgotPassword.Code, http.StatusOK, nil
}

func RefreshToken(refreshingToken *types.RefreshTokenBody) (*types.RefreshTokenResp, int, error) {
	claims := &middleware.Claims{}
	token, err := jwt.ParseWithClaims(refreshingToken.RefreshTokenKey, claims, func(token *jwt.Token) (interface{}, error) {
		return middleware.JwtKey, nil
	})

	if err != nil || !token.Valid {
		return nil, http.StatusUnauthorized, fmt.Errorf("invalid refresh token")
	}

	newToken, err := middleware.GenerateToken(claims.Email)
	if err != nil {
		return nil, http.StatusInternalServerError, fmt.Errorf("error generating new token: %w", err)
	}

	newRefreshToken, err := middleware.GenerateRefreshToken(claims.Email)
	if err != nil {
		return nil, http.StatusInternalServerError, fmt.Errorf("error generating new token: %w", err)
	}

	return &types.RefreshTokenResp{
		TokenKey:        newToken,
		RefreshTokenKey: newRefreshToken,
	}, http.StatusOK, nil
}
