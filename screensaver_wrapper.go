package main

import (
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"syscall"

	"github.com/postfinance/single"
	"tawesoft.co.uk/go/dialog"
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
		dialog.Alert("Error finding game executable: %v\n", err)
		return
	}

	// create a new lockfile in /var/lock/filename
	one, err := single.New("single", single.WithLockPath(pwd))
	if err != nil {
		dialog.Alert(err.Error())
	}

	// lock and defer unlocking
	if err := one.Lock(); err != nil {
		dialog.Alert(err.Error())
	}

	// Check if the game executable exists
	if _, err := os.Stat(absGamePath); os.IsNotExist(err) {
		dialog.Alert("Game executable not found: " + absGamePath)
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
		dialog.Alert("This screensaver has no adjustable settings.")
		return
	}

	// Execute the game as a background process
	cmd := exec.Command(absGamePath)

	// Suppress command window on Windows
	cmd.SysProcAttr = &syscall.SysProcAttr{HideWindow: true}

	_ = cmd.Start()
	_, _ = cmd.Process.Wait()

	if err := one.Unlock(); err != nil {
		dialog.Alert(err.Error())
	}
}
