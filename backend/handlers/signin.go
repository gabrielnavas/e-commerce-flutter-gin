package handlers

import (
	"ecommerce/services"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type signInRequest struct {
	Email    string `json:"email" binding:"required"`
	Password string `json:"password" binding:"required"`
}

type signIn struct {
	tokenService services.TokenService
}

func NewSignIn(
	tokenService services.TokenService,
) *signIn {
	return &signIn{tokenService: tokenService}
}

func (h *signIn) Handler(c *gin.Context) {
	var signInRequest signInRequest

	if err := c.ShouldBindJSON(&signInRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// verifica se o usuario existe
	// se nao existir, retorna status 401
	// cria o token, retorna-o com 201
	userID := uuid.NewString()
	h.tokenService.NewAccessToken(userID)
}
