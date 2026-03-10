# CDC - Proof of Concept
This repository demonstrates a Change Data Capture (CDC) streaming pipeline which captures transactional changes from a PostgreSQL database and ingests them into a Delta Lake-based data lake using open-source technologies.

The goal of this proof of concept is to showcase how modern, real-time data pipelines can be built on an event-driven architecture and a scalable streaming stack, while providing a simple, reproducible local development environment that enables developers to experiment freely and at no cost.

By capturing database changes directly from the Write-Ahead Log (WAL) and propagating them through a streaming platform, the system achieves near real-time data ingestion into the data lake while preserving full transactional consistency.

### Architecture Overview

<p align="left">
  <img src="./docs/arch.png">
</p>

This solution consists of the following components:
-  PostgreSQL: OLTP database responsible for generating transactional data and change events

- Debezium: CDC connector that reads changes directly from PostgreSQL WAL logs

- Apache Kafka: Distributed event streaming platform used to transport change events

- Apache Spark: Processes the streaming events and applies transformations

- Delta Lake: ACID-compliant storage layer for reliable data lake ingestion

- LocalStack / S3: Object storage used as the data lake storage layer

### Prerequisites

Before running this project, ensure the following tools are installed:
- Docker
- Docker Compose
- Make (optional but recommended)

### Running the Project
Type ```make up``` in your terminal.