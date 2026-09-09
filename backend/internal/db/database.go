package db

import (
	"context"
	"os"

	logger "github.com/enkerpawnd/crumbs-module/internal/utils"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/joho/godotenv"
)

func CreateDBConnectionPool(backCtx context.Context) *pgxpool.Pool {
	logger := logger.MakeLogger()
	err := godotenv.Load()

	if err != nil {
		logger.Error("loading env file failed", "err", err)
		os.Exit(1)
	}

	config, err := pgxpool.ParseConfig(os.Getenv("DATABASE_URL"))

	if err != nil {
		logger.Error("Unable to parse config: %v\n", "err", err)
		os.Exit(1)
	}

	db, err := pgxpool.NewWithConfig(backCtx, config)

	if err != nil {
		logger.Error("Unable to create pool: %v\n", "err", err)
		os.Exit(1)
	}

	return db
}
