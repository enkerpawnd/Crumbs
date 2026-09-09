package logger

import (
	"log/slog"
	"os"
)

func MakeLogger() *slog.Logger {
	loggerHandler := slog.NewTextHandler(os.Stdout, nil)
	logger := slog.New(loggerHandler)

	return logger
}
