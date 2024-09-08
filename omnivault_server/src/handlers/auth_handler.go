package handlers

import (
	"encoding/json"
	"log"
	"net/http"

	impl "github.com/Mahaveer86619/OmniVault/src/implementations"
	types "github.com/Mahaveer86619/OmniVault/src/types"
)

func AuthenticateUserController(w http.ResponseWriter, r *http.Request) {
	var creds types.AuthenticatingCredentials
	err := json.NewDecoder(r.Body).Decode(&creds)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(http.StatusBadRequest)
		failureResponse.SetMessage("Invalid request body")
		failureResponse.JSON(w)
		return
	}

	returned_creds, statusCode, err := impl.AuthenticateUser(&creds)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(statusCode)
		failureResponse.SetMessage(err.Error())
		failureResponse.JSON(w)
		return
	}

	successResponse := &types.Success{}
	successResponse.SetStatusCode(statusCode)
	successResponse.SetData(returned_creds)
	successResponse.SetMessage("User Authenticated successfully")
	successResponse.JSON(w)
}

func RegisterUserController(w http.ResponseWriter, r *http.Request) {
	var creds types.RegisteringCredentials
	err := json.NewDecoder(r.Body).Decode(&creds)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(http.StatusBadRequest)
		failureResponse.SetMessage("Invalid request body")
		failureResponse.JSON(w)
		return
	}

	log.Println(creds)

	returned_creds, statusCode, err := impl.RegisterUser(&creds)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(statusCode)
		failureResponse.SetMessage(err.Error())
		failureResponse.JSON(w)
		return
	}

	successResponse := &types.Success{}
	successResponse.SetStatusCode(statusCode)
	successResponse.SetData(returned_creds)
	successResponse.SetMessage("User Registered successfully")
	successResponse.JSON(w)
}

func SendPassResetCodeController(w http.ResponseWriter, r *http.Request) {
	var reqBody types.SendPassResetCodeBody
	err := json.NewDecoder(r.Body).Decode(&reqBody)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(http.StatusBadRequest)
		failureResponse.SetMessage("Invalid request body")
		failureResponse.JSON(w)
		return
	}

	statusCode, err := impl.SendPassResetCode(reqBody.Email)
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
	successResponse.SetMessage("Code sent successfully")
	successResponse.JSON(w)
}

func CheckResetPassCodeController(w http.ResponseWriter, r *http.Request) {
	var reqBody types.CheckPassResetCodeBody
	err := json.NewDecoder(r.Body).Decode(&reqBody)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(http.StatusBadRequest)
		failureResponse.SetMessage("Invalid request body")
		failureResponse.JSON(w)
		return
	}

	code, statusCode, err := impl.CheckResetPassCode(reqBody.Code, reqBody.Email)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(statusCode)
		failureResponse.SetMessage(err.Error())
		failureResponse.JSON(w)
		return
	}

	successResponse := &types.Success{}
	successResponse.SetStatusCode(statusCode)
	successResponse.SetData(code)
	successResponse.SetMessage("Code is valid")
	successResponse.JSON(w)
}

func RefreshTokenController(w http.ResponseWriter, r *http.Request) {
	var refreshingToken types.RefreshTokenBody
	err := json.NewDecoder(r.Body).Decode(&refreshingToken)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(http.StatusBadRequest)
		failureResponse.SetMessage("Invalid request body")
		failureResponse.JSON(w)
		return
	}

	returned_tokens, statusCode, err := impl.RefreshToken(&refreshingToken)
	if err != nil {
		failureResponse := types.Failure{}
		failureResponse.SetStatusCode(statusCode)
		failureResponse.SetMessage(err.Error())
		failureResponse.JSON(w)
		return
	}

	successResponse := &types.Success{}
	successResponse.SetStatusCode(statusCode)
	successResponse.SetData(returned_tokens)
	successResponse.SetMessage("Token refreshed successfully")
	successResponse.JSON(w)
}
