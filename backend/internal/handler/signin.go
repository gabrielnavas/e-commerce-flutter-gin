package handlers

import (
	"ecommerce/internal/handler/responses"
	"ecommerce/internal/service"
	"strings"

	"github.com/gin-gonic/gin"
)

type signInRequest struct {
	Email    string `json:"email" binding:"required"`
	Password string `json:"password" binding:"required"`
}

type signIn struct {
	signInService service.SignInService
}

func NewSignIn(
	signInService service.SignInService,
) *signIn {
	return &signIn{signInService: signInService}
}

func (h *signIn) Handler(c *gin.Context) {
	var signInRequest signInRequest

	if err := c.ShouldBindJSON(&signInRequest); err != nil {
		responses.JSONBadRequest(c, err.Error())
		return
	}

	token, err := h.signInService.SignIn(service.SignInRequest{
		Email:    strings.TrimSpace(signInRequest.Email),
		Password: strings.TrimSpace(signInRequest.Password),
	})
	if err != nil {
		responses.JSONBadRequest(c, err.Error())
		return
	}
	responses.JSONOk(c, gin.H{"token": token})
}
