package main

import (
	"bytes"
	"fmt"
	"os/exec"

	"github.com/joho/godotenv"
)

func main() {
	if err := godotenv.Load(); err != nil {
		panic(err)
	}

	cmd := exec.Command(
		"tern",
		"migrate",
		"--migrations",
		"./internal/store/pgstore/migrations",
		"--config",
		"./internal/store/pgstore/migrations/tern.conf",
	)
	// Capturar saída padrão e saída de erro
	var out bytes.Buffer
	var stderr bytes.Buffer
	cmd.Stdout = &out
	cmd.Stderr = &stderr

	// Executar o comando
	if err := cmd.Run(); err != nil {
		fmt.Println("Error: ", err)
		fmt.Println("Stderr: ", stderr.String())
		// Exibir a saída do comando
		fmt.Println("Result: ", out.String())
		return
	}
	fmt.Println("Success")

}
