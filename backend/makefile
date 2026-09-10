.PHONY: migrate check-deps install-deps ensure-deps migrate-up migrate-down
include .env

check-deps:
	@if migrate --version >/dev/null 2>&1; then \
		echo "Dependency check passed: golang-migrate is installed."; \
	else \
		echo "Error: golang-migrate is not installed."; \
		exit 1; \
	fi

determine-os := ${shell uname -s}

install-deps:
ifeq ($(determine-os), Darwin)
	@echo "Installing golang-migrate on MacOS..."
	brew install golang-migrate
else ifeq ($(determine-os), Linux)
	@echo "Installing golang-migrate on Linux..."
	curl -fsSL https://packagecloud.io/golang-migrate/migrate/gpgkey | sudo gpg --dearmor -o /etc/apt/keyrings/migrate.gpg
	echo "deb [signed-by=/etc/apt/keyrings/migrate.gpg] https://packagecloud.io/golang-migrate/migrate/ubuntu/ lsb_release -sc) main" > /etc/apt/sources.list.d/migrate.list
	apt-get update
	apt-get install -y migrate
else
	@echo "Error: unsupported operating system."
	@echo "Installation instructions: https://github.com/golang-migrate/migrate/tree/master/cmd/migrate"
endif

ensure-deps:
	@$(MAKE) check-deps 2>/dev/null || ($(MAKE) install-deps && $(MAKE) check-deps 2>/dev/null)

migrate: ensure-deps
	migrate create -ext sql -dir db/migrations -seq $(name)

migrate-up: ensure-deps
	migrate -path db/migrations -database "$(DATABASE_URL)?sslmode=disable" up

migrate-down: ensure-deps
	migrate -path db/migrations -database "$(DATABASE_URL)?sslmode=disable" down 1
