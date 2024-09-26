package types

type Note struct {
	ID            string `json:"id"`
	UserID        string `json:"user_id"`
	Title         string `json:"title"`
	Content       string `json:"content"`
	Color         string `json:"color"`
	Tags          string `json:"tags"`
	CoverImageUrl string `json:"cover_image_url"`
	CreatedAt     string `json:"created_at"`
	UpdatedAt     string `json:"updated_at"`
}

type NoteBody struct {
	UserID        string `json:"user_id"`
	Title         string `json:"title"`
	Content       string `json:"content"`
	Color         string `json:"color"`
	Tags          string `json:"tags"`
	CoverImageUrl string `json:"cover_image_url"`
}

type NoteUpdateBody struct {
	ID            string `json:"id"`
	Title         string `json:"title"`
	Content       string `json:"content"`
	Color         string `json:"color"`
	Tags          string `json:"tags"`
	CoverImageUrl string `json:"cover_image_url"`
}

type NoteResponse struct {
	ID            string `json:"id"`
	UserID        string `json:"user_id"`
	Title         string `json:"title"`
	Content       string `json:"content"`
	Color         string `json:"color"`
	Tags          string `json:"tags"`
	CoverImageUrl string `json:"cover_image_url"`
}

func GenNoteResponseFromNote(n Note) *NoteResponse {
	resp := &NoteResponse{
		ID:            n.ID,
		UserID:        n.UserID,
		Title:         n.Title,
		Content:       n.Content,
		Color:         n.Color,
		Tags:          n.Tags,
		CoverImageUrl: n.CoverImageUrl,
	}

	return resp
}
