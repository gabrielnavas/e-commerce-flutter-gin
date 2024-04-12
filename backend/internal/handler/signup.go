package handlers

import (
	"ecommerce/internal/core/auth/usecases"
	"ecommerce/internal/handler/responses"

	"github.com/gin-gonic/gin"
)

type SignUpRequest struct {
	Fullname             string `json:"full_name" binding:"required"`
	Email                string `json:"email" binding:"required"`
	Password             string `json:"password" binding:"required"`
	PasswordConfirmation string `json:"password_confirmation" binding:"required"`
}

type signUpHandler struct {
	signUp usecases.SignUp
}

func NewSignUp(
	signUpUsecase usecases.SignUp,
) *signUpHandler {
	return &signUpHandler{signUp: signUpUsecase}
}

func (h *signUpHandler) Handler(c *gin.Context) {
	var signInRequest SignUpRequest

	if err := c.ShouldBindJSON(&signInRequest); err != nil {
		responses.JSONBadRequest(c, err.Error())
		return
	}

	token, err := h.signUp.SignUp(c, usecases.SignUpRequest{
		Fullname:             signInRequest.Fullname,
		Email:                signInRequest.Email,
		Password:             signInRequest.Password,
		PasswordConfirmation: signInRequest.PasswordConfirmation,
	})
	if err != nil {
		if err == usecases.ErrServiceIsOffline {
			responses.JSONInternalServerError(c, err.Error())
		} else if err == usecases.ErrUserEmailDuplicated {
			responses.JSONBadRequest(c, err.Error())
		} else {
			responses.JSONInternalServerError(c, err.Error())
		}
		return

	}
	responses.JSONCreated(c, gin.H{"token": token})
}
