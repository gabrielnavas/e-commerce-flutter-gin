package responses

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func JSONBadRequest(c *gin.Context, message string) {
	c.JSON(http.StatusCreated, gin.H{"message": message})
}

func JSONCreated(c *gin.Context, h gin.H) {
	c.JSON(http.StatusCreated, h)
}

func JSONOk(c *gin.Context, h gin.H) {
	c.JSON(http.StatusOK, h)
}
