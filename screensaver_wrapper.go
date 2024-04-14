package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"syscall"

	"github.com/postfinance/single"
)

func main() {
	// Specify the path to your Godot game executable
	gamePath := "./ldjam55.exe"

	// Get the absolute path of the game executable
	absGamePath, err := filepath.Abs(gamePath)
	if err != nil {
		fmt.Printf("Error finding game executable: %v\n", err)
		return
	}

	// Create a single instance lock for your application
	s, err := single.New(filepath.Base(absGamePath))
	if err != nil {
		if err == single.ErrAlreadyRunning {
			fmt.Println("Another instance of the program is already running.")
			return
		}
		fmt.Printf("Error creating single instance: %v\n", err)
		return
	}

	defer func() {
		// Release the single instance lock when the function exits
		if err := s.Unlock(); err != nil {
			fmt.Printf("Error releasing single instance lock: %v\n", err)
		}
	}()

	// Check if the game executable exists
	if _, err := os.Stat(absGamePath); os.IsNotExist(err) {
		fmt.Printf("Game executable not found: %s\n", absGamePath)
		return
	}

	// Parse command line arguments
	args := os.Args[1:]
	mode := "/c" // Default mode if no arguments are given

	if len(args) > 0 {
		mode = strings.ToLower(args[0])
	}

	switch mode {
	case "/p":
		// Show preview in screensaver selection dialog box
		return
		// TODO: Figure out how to do this
	case "/c":
		// Show screensaver configuration dialog box
		return
		// TODO: Show popup that there is no settings
	}

	// Execute the game as a background process
	cmd := exec.Command(absGamePath)

	// Suppress command window on Windows
	cmd.SysProcAttr = &syscall.SysProcAttr{HideWindow: true}

	_ = cmd.Start()
	_, _ = cmd.Process.Wait()
}
