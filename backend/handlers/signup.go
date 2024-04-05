package handlers

import (
	"ecommerce/services"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type SignUpRequest struct {
	Fullname             string `json:"full_name" binding:"required"`
	Email                string `json:"email" binding:"required"`
	Password             string `json:"password" binding:"required"`
	PasswordConfirmation string `json:"password_confirmation" binding:"required"`
}

type signUpHandler struct {
	tokenService services.TokenService
}

func NewSignUp(
	tokenService services.TokenService,
) *signUpHandler {
	return &signUpHandler{}
}

func (h *signUpHandler) Handler(c *gin.Context) {
	var signInRequest SignUpRequest

	if err := c.ShouldBindJSON(&signInRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// verifica se o usuarios existe
	// se existir, retorna status 400, usuario já existe
	// se não, cria o usuario
	// cria o token, retorna-o com 201
	userID := uuid.NewString()
	h.tokenService.NewAccessToken(userID)
}
