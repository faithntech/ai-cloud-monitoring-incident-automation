# AI-Powered Cloud Monitoring & Incident Automation Platform

## Project Overview

Designed and deployed a cloud monitoring and incident automation platform using AWS, Docker, Prometheus, Grafana, Uptime Kuma, and n8n. The platform monitors infrastructure health, detects service outages, automates operational alerting workflows, and prepares the architecture for AI-powered incident summarization.

---

# Architecture

```text
AWS EC2 Ubuntu Server
│
├── Docker Compose
│   ├── Prometheus
│   ├── Grafana
│   ├── Node Exporter
│   ├── Uptime Kuma
│   └── n8n
│
├── Telegram Alerting
│
└── AI-Ready Workflow Automation
    └── OpenAI / Gemini Integration Prepared
```

### Tech Stack

- AWS EC2
- Docker
- Docker Compose
- Prometheus
- Grafana
- Node Exporter
- Uptime Kuma
- n8n
- Telegram API
- OpenAI API (Prepared)
- Gemini API (Prepared)


## Step-by-Step Implementation

### 1. Provisioned AWS EC2 Server

Created an Ubuntu EC2 instance to host the monitoring platform.

Configured required ports:
```
22    SSH
3000  Grafana
3001  Uptime Kuma
5678  n8n
9090  Prometheus
9100  Node Exporter
```

### 2. Installed Docker & Docker Compose

Installed Docker and Docker Compose on the EC2 server to containerize all monitoring services.

Verified installation:
```
docker --version
docker compose version
```

### 3. Built Monitoring Stack with Docker Compose

Created a containerized monitoring stack including:
```
Prometheus = collects metrics
Grafana = dashboard
Node Exporter = server CPU/RAM/disk metrics
Uptime Kuma = website/app uptime monitoring
n8n = workflow automation
```

Started services using:
```
docker compose up -d
```

### 4. Configured Prometheus Monitoring

Created prometheus.yml configuration file and configured Prometheus to scrape metrics from Node Exporter.

Collected infrastructure metrics such as:
```
CPU usage
Memory usage
Disk usage
Server uptime
```

Verified targets:
```
http://EC2_PUBLIC_IP:9090/targets
```

### 5. Configured Grafana Dashboards

Connected Prometheus as Grafana data source:
```
http://prometheus:9090
```

Imported Node Exporter Full dashboard:
```
Dashboard ID: 1860
```

Created dashboards visualizing:
```
CPU utilization
RAM usage
Disk usage
Infrastructure health
Server uptime
```

### 6. Added Uptime Monitoring with Uptime Kuma

Configured Uptime Kuma to monitor:
```
Portfolio website
Grafana dashboard
Prometheus server
Service endpoints
```

Used internal Docker networking for monitoring:
```
http://grafana:3000
```

### 7. Implemented Telegram Alerting

Created Telegram bot using BotFather and configured Telegram notifications in Uptime Kuma.

Implemented automated alerts for:
```
Service outages
Service recovery
Monitoring failures
```

Example alerts:
```
🔴 Grafana Dashboard DOWN
🟢 Grafana Dashboard UP
```

### 8. Added Workflow Automation using n8n

Configured n8n automation workflows using webhook-based incident processing.

Created workflow:
```
Webhook → Telegram Notification
```
Webhook endpoint:
```
/uptime-incident
```
Connected Uptime Kuma webhook notifications to n8n automation workflows.

### 9. Simulated Incident Detection

Tested incident workflows by stopping Grafana container:
```
docker stop grafana
```
Recovered service using:
```
docker start grafana
```
Verified successful detection and automated Telegram alert delivery.

### 10. Prepared AI Incident Automation

Prepared architecture for future AI-powered incident summaries using:

- OpenAI API
- Gemini API

Planned AI capabilities:

- AI-generated incident summaries
- Root cause suggestions
- Automated operational recommendations
- AI-assisted incident reporting

## Features

- Real-time infrastructure monitoring
- CPU, memory, disk, and uptime monitoring
- Grafana observability dashboards
- Automated Telegram alerting
- Service uptime monitoring
- Dockerized deployment architecture
- Webhook-based workflow automation
- AI-ready incident automation architecture
  
## Business Value

- Reduces manual monitoring effort
- Improves operational visibility
- Speeds up incident response time
- Automates repetitive operational tasks
- Demonstrates cloud monitoring and automation capability
- Prepares infrastructure for AI-assisted operations

## Skills Demonstrated

- Cloud Infrastructure
- DevOps
- Monitoring & Observability
- Docker Containerization
- Linux Administration
- Incident Automation
- Workflow Automation
- Infrastructure Monitoring
- Operational Alerting
- AI Integration Preparation


## Final Workflow
```
Uptime Kuma
↓
Webhook Trigger
↓
n8n Workflow
↓
Telegram Alert Notification
```

## Future AI workflow:
```
Uptime Kuma
↓
n8n Webhook
↓
OpenAI / Gemini API
↓
AI Incident Summary
↓
Telegram Alert
```
