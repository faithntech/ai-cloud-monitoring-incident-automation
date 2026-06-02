# Setup Guide

### 1. Start Containers

```bash
docker compose up -d
```

### 2. Check Containers
```
docker ps
```

### 3. Access Services
```
Grafana: http://SERVER_IP:3000
Prometheus: http://SERVER_IP:9090
Uptime Kuma: http://SERVER_IP:3001
n8n: http://SERVER_IP:5678
```

### 4. Configure Grafana

Add Prometheus as a data source:
```
http://prometheus:9090
```

Import dashboard ID:
```
1860
```

### 5. Configure Uptime Kuma

Add monitors for:

- Grafana
- Prometheus
- n8n
- Portfolio website

### 6. Configure n8n

Create workflow:
```
Webhook → Google Gemini API → AI Summary → Telegram
```
