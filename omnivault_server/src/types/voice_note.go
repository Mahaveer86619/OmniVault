package types

type VoiceNote struct {
	ID        string `json:"id"`
	UserID    string `json:"user_id"`
	Title     string `json:"title"`
	NoteUrl   string `json:"note_url"`
	CreatedAt string `json:"created_at"`
	UpdatedAt string `json:"updated_at"`
}