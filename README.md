# AI-Powered Cloud Monitoring & Incident Automation Platform

Designed and deployed a cloud monitoring and incident automation platform using AWS, Docker, Prometheus, Grafana, Uptime Kuma, and n8n. The system monitors infrastructure health in real time, tracks service availability, and automates operational alerting workflows through Telegram notifications.

Implemented monitoring for CPU, memory, disk usage, uptime, and service health using Prometheus, Node Exporter, and Grafana dashboards. Configured Uptime Kuma to detect service outages and trigger automated webhook-based workflows in n8n for incident processing and alert routing.

The project demonstrates practical DevOps, monitoring, observability, and automation skills, while preparing the architecture for future AI-powered incident summarization using OpenAI or Gemini APIs.

### Tech Stack

* AWS EC2
* Docker & Docker Compose
* Prometheus
* Grafana
* Node Exporter
* Uptime Kuma
* n8n
* Telegram API
* AI API Integration (Prepared)

### Features

* Real-time infrastructure monitoring
* Grafana observability dashboards
* Uptime and health checks
* Automated Telegram incident alerts
* Webhook-based workflow automation
* AI-ready incident automation architecture


## Final Architecture
```
AWS EC2 Ubuntu Server
│
├── Docker
│   ├── Prometheus
│   ├── Grafana
│   ├── Node Exporter
│   ├── Uptime Kuma
│   └── n8n
│
├── Slack / Telegram Alerts
│
└── OpenAI API
    └── AI incident summary
```
