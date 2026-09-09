package main

import (
	"context"

	"github.com/enkerpawnd/crumbs-module/internal/db"
)

func main() {
	backgroundContext := context.Background()

	// need to pass it down to handlers
	db.CreateDBConnectionPool(backgroundContext)
}
