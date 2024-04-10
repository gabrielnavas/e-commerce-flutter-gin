package handlers

import (
	"ecommerce/internal/core/usecase"
	"ecommerce/internal/handler/responses"
	"strings"

	"github.com/gin-gonic/gin"
)

type signInRequest struct {
	Email    string `json:"email" binding:"required"`
	Password string `json:"password" binding:"required"`
}

type signIn struct {
	signIn usecase.SignIn
}

func NewSignIn(
	signInUsecase usecase.SignIn,
) *signIn {
	return &signIn{signIn: signInUsecase}
}

func (h *signIn) Handler(c *gin.Context) {
	var signInRequest signInRequest

	if err := c.ShouldBindJSON(&signInRequest); err != nil {
		responses.JSONBadRequest(c, err.Error())
		return
	}

	token, err := h.signIn.SignIn(usecase.SignInRequest{
		Email:    strings.TrimSpace(signInRequest.Email),
		Password: strings.TrimSpace(signInRequest.Password),
	})
	if err != nil {
		responses.JSONBadRequest(c, err.Error())
		return
	}
	responses.JSONOk(c, gin.H{"token": token})
}
