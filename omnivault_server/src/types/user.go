package types

type User struct {
	ID         string `json:"id"`
	Name       string `json:"name"`
	Email      string `json:"email"`
	Password   string `json:"password"`
	ProfilePic string `json:"profile_pic"`
	CreatedAt  string `json:"created_at"`
	UpdatedAt  string `json:"updated_at"`
}

type UserResponse struct {
	ID           string `json:"id"`
	Name         string `json:"name"`
	Email        string `json:"email"`
	ProfilePic   string `json:"profile_pic"`
	Token        string `json:"token"`
	RefreshToken string `json:"refresh_token"`
}

func (u *User) toResponse(token string, refreshToken string) *UserResponse {
	return &UserResponse{
		ID:           u.ID,
		Name:         u.Name,
		Email:        u.Email,
		ProfilePic:   u.ProfilePic,
		Token:        token,
		RefreshToken: refreshToken,
	}
}
