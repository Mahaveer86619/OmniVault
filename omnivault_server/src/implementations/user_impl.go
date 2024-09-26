package implementations

import (
	"database/sql"
	"fmt"
	"net/http"

	db "github.com/Mahaveer86619/OmniVault/src/database"
	helpers "github.com/Mahaveer86619/OmniVault/src/helpers"
	types "github.com/Mahaveer86619/OmniVault/src/types"
)

func GetAllUsers() ([]types.User, int, error) {
	conn := db.GetDBConnection()

	query := `
	  SELECT *
	  FROM profiles
	`

	rows, err := conn.Query(query)
	if err != nil {
		fmt.Print("error getting users: %w", err)
	}
	defer rows.Close()

	var users []types.User

	for rows.Next() {
		var user types.User
		if err := rows.Scan(
			&user.ID,
			&user.Name,
			&user.Email,
			&user.ProfilePic,
			&user.CreatedAt,
			&user.UpdatedAt,
		); err != nil {
			if err == sql.ErrNoRows {
				return []types.User{}, http.StatusOK, nil
			}
			return nil, http.StatusInternalServerError, fmt.Errorf("error scanning row: %w", err)
		}

		users = append(users, user)
	}
	return users, http.StatusOK, nil
}

func GetUserByID(userID string) (*types.UserSafeResponse, int, error) {
	conn := db.GetDBConnection()

	query := `
	  SELECT *
	  FROM profiles
	  WHERE id = $1
	`

	var user types.User
	if err := conn.QueryRow(
		query,
		userID,
	).Scan(
		&user.ID,
		&user.Name,
		&user.Email,
		&user.ProfilePic,
		&user.CreatedAt,
		&user.UpdatedAt,
	); err != nil {
		if err == sql.ErrNoRows {
			return nil, http.StatusNotFound, fmt.Errorf("user not found with id: %s", userID)
		}
		return nil, http.StatusInternalServerError, fmt.Errorf("error scanning row: %w", err)
	}

	// Generate user safe response
	userSafeResponse := types.GenUserSafeResponseFromUser(user)
	return userSafeResponse, http.StatusOK, nil
}

func UpdateUser(user *types.UserSafeResponse) (*types.UserSafeResponse, int, error) {
	conn := db.GetDBConnection()

	select_query_auth := `SELECT * FROM auth WHERE id = $1`
	select_query_profile := `SELECT * FROM profiles WHERE id = $1`

	update_query_auth := `UPDATE auth 
	SET name = $1, email = $2, password = $3
	WHERE id = $4`
	
	update_query_profile := `UPDATE profiles 
	SET name = $1, email = $2, profile_pic = $3, created_at = $4, updated_at = $5
	WHERE id = $6 RETURNING *`

	// get the auth user
	var authUser types.Auth

	if err := conn.QueryRow(
		select_query_auth,
		user.ID,
	).Scan(
		&authUser.ID,
		&authUser.Name,
		&authUser.Email,
		&authUser.Password,
	); err != nil {
		if err == sql.ErrNoRows {
			return nil, http.StatusNotFound, fmt.Errorf("auth user not found with id: %s", user.ID)
		}
		return nil, http.StatusInternalServerError, fmt.Errorf("error scanning row: %w", err)
	}

	// get the profile user
	var profileUser types.User

	if err := conn.QueryRow(
		select_query_profile,
		user.ID,
	).Scan(
		&profileUser.ID,
		&profileUser.Name,
		&profileUser.Email,
		&profileUser.ProfilePic,
		&profileUser.CreatedAt,
		&profileUser.UpdatedAt,
	); err != nil {
		if err == sql.ErrNoRows {
			return nil, http.StatusNotFound, fmt.Errorf("profile user not found with id: %s", user.ID)
		}
		return nil, http.StatusInternalServerError, fmt.Errorf("error scanning row: %w", err)
	}

	// Update the auth user
	_, err := conn.Exec(
		update_query_auth,
		&user.Name,
		&user.Email,
		authUser.Password,
		&user.ID,
	)

	if err != nil {
		return nil, http.StatusInternalServerError, fmt.Errorf("error updating row: %w", err)
	}

	// Update the profile user
	var userResp types.User
	err = conn.QueryRow(
		update_query_profile,
		user.Name,
		user.Email,
		user.ProfilePic,
		profileUser.CreatedAt,
		helpers.GetCurrentDateTimeAsString(),
		user.ID,
	).Scan(
		&userResp.ID,
		&userResp.Name,
		&userResp.Email,
		&userResp.ProfilePic,
		&userResp.CreatedAt,
		&userResp.UpdatedAt,
	)

	if err != nil {
		return nil, http.StatusInternalServerError, fmt.Errorf("error updating user profile: %w", err)
	}

	// Generate user safe response
	userSafeResponse := types.GenUserSafeResponseFromUser(userResp)
	return userSafeResponse, http.StatusOK, nil
}

func DeleteUser(userId string) (int, error) {
	conn := db.GetDBConnection()

	query := `SELECT * FROM profiles WHERE id = $1`
	del_query := "DELETE FROM profiles WHERE id = $1"

	var user types.User
	if err := conn.QueryRow(
		query,
		userId,
	).Scan(
		&user.ID,
		&user.Name,
		&user.Email,
		&user.ProfilePic,
		&user.CreatedAt,
		&user.UpdatedAt,
	); err != nil {
		if err == sql.ErrNoRows {
			return http.StatusNotFound, fmt.Errorf("user not found with id: %s", userId)
		}
		return http.StatusInternalServerError, fmt.Errorf("error scanning row: %w", err)
	} else {
		_, err = conn.Exec(del_query, userId)
		if err != nil {
			return http.StatusInternalServerError, fmt.Errorf("error deleting row: %w", err)
		}
	}

	return http.StatusNoContent, nil
}
