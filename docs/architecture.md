# Project Architecture

```text
Cloud Server / EC2
│
├── Prometheus
│   └── Collects metrics from Node Exporter
│
├── Node Exporter
│   └── Exposes server metrics
│
├── Grafana
│   └── Visualizes CPU, RAM, disk, and network usage
│
├── Uptime Kuma
│   └── Checks service uptime
│
└── n8n
    └── Receives incident alerts and sends AI-powered summaries
```

## Alert Flow

Service Down
→ Uptime Kuma detects issue
→ Webhook sent to n8n
→ AI generates incident summary
→ Telegram receives alert
