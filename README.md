# CDC - Proof of Concept
This repository demonstrates a Change Data Capture (CDC) streaming pipeline that captures transactional changes from PostgreSQL and delivers them into a Delta Lake-based data lake with open-source technologies.
The goal of this proof of concept is to showcase a real-time data pipeline following modern data engineering patterns.

<img src="./docs/arch.png">

This solution implements a streaming pipeline composed of:
- PostgreSQL: OLTP database generating transactional changes
- Debezium: Connector that captures database changes via WAL (Write-Ahead Log)
- Apache Kafka: Event streaming platform
- Apache Spark: Processes streaming events
- Delta Lake: ACID-compliant storage layer
- S3 (via LocalStack): Object storage for the data lake