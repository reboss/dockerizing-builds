package main

import (
    "net/http"
    "github.com/gin-gonic/gin"
)

func main() {
    engine := gin.Default()

    engine.Get("/", func(c *gin.Context) {
        c.JSON(http.StatusOK, gin.H{
            "message": "Hello, world!",
        })
    })

    engine.Run(":8080")
}
