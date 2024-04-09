package handlers

import (
	"ecommerce/internal/handler/responses"
	"ecommerce/internal/service"

	"github.com/gin-gonic/gin"
)

type SignUpRequest struct {
	Fullname             string `json:"full_name" binding:"required"`
	Email                string `json:"email" binding:"required"`
	Password             string `json:"password" binding:"required"`
	PasswordConfirmation string `json:"password_confirmation" binding:"required"`
}

type signUpHandler struct {
	signUpService service.SignUpService
}

func NewSignUp(
	signUpService service.SignUpService,
) *signUpHandler {
	return &signUpHandler{signUpService: signUpService}
}

func (h *signUpHandler) Handler(c *gin.Context) {
	var signInRequest SignUpRequest

	if err := c.ShouldBindJSON(&signInRequest); err != nil {
		responses.JSONBadRequest(c, err.Error())
		return
	}

	token, err := h.signUpService.SignUp(service.SignUpRequest{
		Fullname:             signInRequest.Fullname,
		Email:                signInRequest.Email,
		Password:             signInRequest.Password,
		PasswordConfirmation: signInRequest.PasswordConfirmation,
	})
	if err != nil {
		responses.JSONBadRequest(c, err.Error())
		return
	}
	responses.JSONCreated(c, gin.H{"token": token})
}
