package handlers

import (
	"encoding/json"
	"net/http"

	impl "github.com/Mahaveer86619/OmniVault/src/implementations"
	types "github.com/Mahaveer86619/OmniVault/src/types"
)

func CreateNoteHandler(w http.ResponseWriter, r *http.Request) {
	var my_note types.NoteBody
	err := json.NewDecoder(r.Body).Decode(&my_note)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(http.StatusBadRequest)
		failureResponse.SetMessage("Invalid request body")
		failureResponse.JSON(w)
		return
	}

	note, statusCode, err := impl.CreateNote(&my_note)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(statusCode)
		failureResponse.SetMessage(err.Error())
		failureResponse.JSON(w)
		return
	}

	successResponse := &types.Success{}
	successResponse.SetStatusCode(http.StatusCreated)
	successResponse.SetData(note)
	successResponse.SetMessage("Note created successfully")
	successResponse.JSON(w)
}

func GetAllNotesHandler(w http.ResponseWriter, r *http.Request) {
	user_id := r.URL.Query().Get("user_id")
	if user_id == "" {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(http.StatusBadRequest)
		failureResponse.SetMessage("Invalid request body: user_id is required")
		failureResponse.JSON(w)
		return
	}

	notes, statusCode, err := impl.GetAllNotes(user_id)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(statusCode)
		failureResponse.SetMessage(err.Error())
		failureResponse.JSON(w)
		return
	}

	successResponse := &types.Success{}
	successResponse.SetStatusCode(statusCode)
	successResponse.SetData(notes)
	successResponse.SetMessage("Notes fetched successfully")
	successResponse.JSON(w)
}

func GetNoteByIdHandler(w http.ResponseWriter, r *http.Request) {
	note_id := r.URL.Query().Get("id")
	if note_id == "" {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(http.StatusBadRequest)
		failureResponse.SetMessage("Invalid request body: id is required")
		failureResponse.JSON(w)
		return
	}

	note, statusCode, err := impl.GetNoteById(note_id)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(statusCode)
		failureResponse.SetMessage(err.Error())
		failureResponse.JSON(w)
		return
	}

	successResponse := &types.Success{}
	successResponse.SetStatusCode(statusCode)
	successResponse.SetData(note)
	successResponse.SetMessage("Note fetched successfully")
	successResponse.JSON(w)
}

func UpdateNoteHandler(w http.ResponseWriter, r *http.Request) {
	var note types.NoteUpdateBody
	err := json.NewDecoder(r.Body).Decode(&note)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(http.StatusBadRequest)
		failureResponse.SetMessage("Invalid request body")
		failureResponse.JSON(w)
		return
	}

	noteResp, statusCode, err := impl.UpdateNote(&note)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(statusCode)
		failureResponse.SetMessage(err.Error())
		failureResponse.JSON(w)
		return
	}

	successResponse := &types.Success{}
	successResponse.SetStatusCode(statusCode)
	successResponse.SetData(noteResp)
	successResponse.SetMessage("Note updated successfully")
	successResponse.JSON(w)
}

func DeleteNoteHandler(w http.ResponseWriter, r *http.Request) {
	note_id := r.URL.Query().Get("id")
	if note_id == "" {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(http.StatusBadRequest)
		failureResponse.SetMessage("Invalid request body: id is required")
		failureResponse.JSON(w)
		return
	}

	statusCode, err := impl.DeleteNote(note_id)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(statusCode)
		failureResponse.SetMessage(err.Error())
		failureResponse.JSON(w)
		return
	}

	successResponse := &types.Success{}
	successResponse.SetStatusCode(statusCode)
	successResponse.SetData(nil)
	successResponse.SetMessage("Note deleted successfully")
	successResponse.JSON(w)
}