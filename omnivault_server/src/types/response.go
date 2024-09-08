package types

import (
	"encoding/json"
	"net/http"
)

type Response interface {
	SetStatusCode(int)
	SetMessage(string)
	SetData(interface{})
	JSON(http.ResponseWriter)
}

type Success struct {
	StatusCode int         `json:"status_code"`
	Data       interface{} `json:"data"`
	Message    string      `json:"message"`
}

type Failure struct {
	StatusCode int    `json:"status_code"`
	Message    string `json:"message"`
}

func (s *Success) SetStatusCode(statusCode int) {
	s.StatusCode = statusCode
}

func (s *Success) SetMessage(message string) {
	s.Message = message
}

func (s *Success) SetData(data interface{}) {
	s.Data = data
}

func (s *Success) JSON(w http.ResponseWriter) {
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(s.StatusCode)
	json.NewEncoder(w).Encode(s)
}

func (f *Failure) SetStatusCode(statusCode int) {
	f.StatusCode = statusCode
}

func (f *Failure) SetMessage(message string) {
	f.Message = message
}

func (f *Failure) JSON(w http.ResponseWriter) {
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(f.StatusCode)
	json.NewEncoder(w).Encode(f)
}
