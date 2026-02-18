COMPOSE_FILE=./compose.yaml

.PHONY: up down

up:
	@echo "Starting Docker Compose..."
	docker compose -f $(COMPOSE_FILE) up -d

connector:
	@echo "Creating or updating Debezium connector..."
	curl -X PUT http://localhost:8083/connectors/sales-connector/config \
		-H "Content-Type: application/json" \
		-d @./connectors/sales-connector.json

down:
	@echo "Stopping Docker Compose..."
	docker compose -f $(COMPOSE_FILE) down --volumes --rmi all