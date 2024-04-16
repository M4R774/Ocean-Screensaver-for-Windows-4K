package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

func main() {
	ex, err := os.Executable()
	if err != nil {
		panic(err)
	}
	pwd := filepath.Dir(ex)

	// Specify the path to your Godot game executable
	gamePath := pwd + "/game.exe"
	// Get the absolute path of the game executable
	absGamePath, err := filepath.Abs(gamePath)
	if err != nil {
		fmt.Printf("Error finding game executable: %v\n", err)
		fmt.Println("Press the Enter Key to exit...")
		fmt.Scanln() // wait for Enter Key
		return
	}

	// Check if the game executable exists
	if _, err := os.Stat(absGamePath); os.IsNotExist(err) {
		fmt.Println("Game executable not found: " + absGamePath)
		fmt.Println("Press the Enter Key to exit...")
		fmt.Scanln() // wait for Enter Key
		return
	}

	// Parse command line arguments
	args := os.Args[1:]
	mode := "/c" // Default mode if no arguments are given

	if len(args) > 0 {
		// Split the argument to handle mode and potential window handle
		argParts := strings.SplitN(args[0], ":", 2)
		mode = strings.ToLower(argParts[0])
	}

	switch mode {
	case "/p": // Show preview in screensaver selection dialog box
		return
	case "/c": // Show screensaver configuration dialog box
		fmt.Println("This screensaver has no adjustable settings.")
		fmt.Println("Press the Enter Key to exit...")
		fmt.Scanln() // wait for Enter Key
		return
	}

	// Execute the game as a background process
	cmd := exec.Command(absGamePath)

	_ = cmd.Start()
	_, _ = cmd.Process.Wait()
}
