COMPOSE_FILE=./compose.yaml

.PHONY: up infra spark connector console-consumer bucket wait-topic down

up: infra bucket connector wait-topic spark
	@echo "Fully started."

infra:
	@echo "Starting infrastructure..."
	docker compose -f $(COMPOSE_FILE) up -d db kafka connect localstack

bucket:
	@echo "Creating S3 bucket..."
	@until curl -s http://localhost:4566 > /dev/null; do \
		echo "Waiting for LocalStack..."; \
		sleep 2; \
	done
	aws --endpoint-url=http://localhost:4566 s3 mb s3://datalake || true

connector:
	@echo "Creating Debezium connector..."
	@until curl -s http://localhost:8083/connectors > /dev/null; do \
		echo "Waiting for Kafka Connect..."; \
		sleep 2; \
	done
	curl -X PUT http://localhost:8083/connectors/sales-connector/config \
		-H "Content-Type: application/json" \
		-d @./connectors/sales-connector.json

wait-topic:
	@echo "Waiting for Kafka topic to be created..."
	@until docker exec kafka kafka-topics \
		--bootstrap-server kafka:9092 \
		--list | grep salesdb.public.sales; do \
		echo "Topic not ready yet... Insert data in Postgres!"; \
		sleep 3; \
	done

spark:
	@echo "Starting Spark..."
	docker compose -f $(COMPOSE_FILE) up -d spark

console-consumer:
	docker exec -it kafka kafka-console-consumer \
		--bootstrap-server kafka:9092 \
		--topic salesdb.public.sales \
		--from-beginning

down:
	docker compose -f $(COMPOSE_FILE) down --volumes