package handlers

import (
	jwtservice "ecommerce/services/jwt"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type signInRequest struct {
	Email    string `json:"email" binding:"required"`
	Password string `json:"password" binding:"required"`
}

type signIn struct {
	tokenService jwtservice.TokenService
}

func NewSignIn(
	tokenService jwtservice.TokenService,
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
