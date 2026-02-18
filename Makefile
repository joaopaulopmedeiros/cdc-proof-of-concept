COMPOSE_FILE=./compose.yaml

.PHONY: up connector console-consumer bucket down

up:
	@echo "Starting Docker Compose..."
	docker compose -f $(COMPOSE_FILE) up -d

connector:
	@echo "Creating or updating Debezium connector..."
	curl -X PUT http://localhost:8083/connectors/sales-connector/config \
		-H "Content-Type: application/json" \
		-d @./connectors/sales-connector.json

console-consumer:
	@echo "Starting Kafka Console Consumer..."
	docker exec -it kafka kafka-console-consumer \
	--bootstrap-server kafka:9092 \
	--topic salesdb.public.sales \
	--from-beginning

bucket:
	@echo "Creating S3 bucket..."
	aws --endpoint-url=http://localhost:4566 s3 mb s3://datalake

down:
	@echo "Stopping Docker Compose..."
	docker compose -f $(COMPOSE_FILE) down --volumes