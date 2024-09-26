package implementations

import (
	"database/sql"
	"fmt"
	"net/http"

	db "github.com/Mahaveer86619/OmniVault/src/database"
	helpers "github.com/Mahaveer86619/OmniVault/src/helpers"
	types "github.com/Mahaveer86619/OmniVault/src/types"
	"github.com/google/uuid"
)

func CreateNote(note *types.NoteBody) (*types.NoteResponse, int, error) {
	conn := db.GetDBConnection()

	query := `
		INSERT INTO notes (id, user_id, title, content, color, tags, cover_image_url, created_at, updated_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING *
	`

	var noteResp types.Note
	id := uuid.New().String()

	if err := conn.QueryRow(
		query,
		id,
		note.UserID,
		note.Title,
		note.Content,
		note.Color,
		note.Tags,
		note.CoverImageUrl,
		helpers.GetCurrentDateTimeAsString(),
		helpers.GetCurrentDateTimeAsString(),
	).Scan(
		&noteResp.ID,
		&noteResp.UserID,
		&noteResp.Title,
		&noteResp.Content,
		&noteResp.Color,
		&noteResp.Tags,
		&noteResp.CoverImageUrl,
		&noteResp.CreatedAt,
		&noteResp.UpdatedAt,
	); err != nil {
		return nil, http.StatusInternalServerError, fmt.Errorf("error creating note: %w", err)
	}

	return types.GenNoteResponseFromNote(noteResp), http.StatusOK, nil
}

func GetAllNotes(userId string) ([]types.NoteResponse, int, error) {
	conn := db.GetDBConnection()

	query := `
	  SELECT *
	  FROM notes
	  WHERE user_id = $1
	`

	rows, err := conn.Query(query, userId)
	if err != nil {
		fmt.Print("error getting notes: %w", err)
	}
	defer rows.Close()

	var notes []types.NoteResponse

	for rows.Next() {
		var note types.Note
		if err := rows.Scan(
			&note.ID,
			&note.UserID,
			&note.Title,
			&note.Content,
			&note.Color,
			&note.Tags,
			&note.CoverImageUrl,
			&note.CreatedAt,
			&note.UpdatedAt,
		); err != nil {
			if err == sql.ErrNoRows {
				return []types.NoteResponse{}, http.StatusOK, nil
			}
			return nil, http.StatusInternalServerError, fmt.Errorf("error scanning row: %w", err)
		}

		// Generate note response
		noteResp := types.GenNoteResponseFromNote(note)

		notes = append(notes, *noteResp)
	}

	return notes, http.StatusOK, nil
}

func GetNoteById(noteId string) (*types.NoteResponse, int, error) {
	conn := db.GetDBConnection()

	query := `
	  SELECT *
	  FROM notes
	  WHERE id = $1
	`

	var note types.Note
	if err := conn.QueryRow(
		query,
		noteId,
	).Scan(
		&note.ID,
		&note.UserID,
		&note.Title,
		&note.Content,
		&note.Color,
		&note.Tags,
		&note.CoverImageUrl,
		&note.CreatedAt,
		&note.UpdatedAt,
	); err != nil {
		if err == sql.ErrNoRows {
			return nil, http.StatusNotFound, fmt.Errorf("note not found with id: %s", noteId)
		}
		return nil, http.StatusInternalServerError, fmt.Errorf("error scanning row: %w", err)
	}

	// Generate note response
	noteResp := types.GenNoteResponseFromNote(note)
	return noteResp, http.StatusOK, nil
}

func UpdateNote(noteBody *types.NoteUpdateBody) (*types.NoteResponse, int, error) {
	conn := db.GetDBConnection()

	query := `
	  SELECT *
	  FROM notes
	  WHERE id = $1
	`

	var note types.Note
	if err := conn.QueryRow(
		query,
		noteBody.ID,
	).Scan(
		&note.ID,
		&note.UserID,
		&note.Title,
		&note.Content,
		&note.Color,
		&note.Tags,
		&note.CoverImageUrl,
		&note.CreatedAt,
		&note.UpdatedAt,
	); err != nil {
		if err == sql.ErrNoRows {
			return nil, http.StatusNotFound, fmt.Errorf("note not found with id: %s", noteBody.ID)
		}
		return nil, http.StatusInternalServerError, fmt.Errorf("error scanning row: %w", err)
	}

	update_query := `
		UPDATE notes
		SET title = $1, content = $2, color = $3, tags = $4, cover_image_url = $5
		WHERE id = $6 RETURNING *
	`

	_, err := conn.Exec(
		update_query,
		note.Title,
		note.Content,
		note.Color,
		note.Tags,
		note.CoverImageUrl,
		note.ID,
	)

	if err != nil {
		return nil, http.StatusInternalServerError, fmt.Errorf("error updating row: %w", err)
	}

	// Generate note response
	noteResp := types.GenNoteResponseFromNote(note)
	return noteResp, http.StatusOK, nil
}

func DeleteNote(noteId string) (int, error) {
	conn := db.GetDBConnection()

	query := `SELECT * FROM notes WHERE id = $1`
	del_query := "DELETE FROM notes WHERE id = $1"

	var note types.Note
	if err := conn.QueryRow(
		query,
		noteId,
	).Scan(
		&note.ID,
		&note.UserID,
		&note.Title,
		&note.Content,
		&note.Color,
		&note.Tags,
		&note.CoverImageUrl,
		&note.CreatedAt,
		&note.UpdatedAt,
	); err != nil {
		if err == sql.ErrNoRows {
			return http.StatusNotFound, fmt.Errorf("note not found with id: %s", noteId)
		}
		return http.StatusInternalServerError, fmt.Errorf("error scanning row: %w", err)
	} else {
		_, err = conn.Exec(del_query, noteId)
		if err != nil {
			return http.StatusInternalServerError, fmt.Errorf("error deleting row: %w", err)
		}
	}

	return http.StatusNoContent, nil
}