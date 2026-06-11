## Setup Guide

### 1. Start Containers

Launch all monitoring and automation services:

```bash
docker compose up -d
```

Verify containers are running:

```bash
docker ps
```

Expected services:

* Prometheus
* Grafana
* Uptime Kuma
* n8n

---

### 2. Access Services

Replace `SERVER_IP` with your EC2 Public IP or Elastic IP.

| Service     | URL                   |
| ----------- | --------------------- |
| Grafana     | http://SERVER_IP:3000 |
| Prometheus  | http://SERVER_IP:9090 |
| Uptime Kuma | http://SERVER_IP:3001 |
| n8n         | http://SERVER_IP:5678 |

---

### 3. Configure Grafana

#### Add Prometheus Data Source

Navigate to:

```text
Connections → Data Sources → Add Data Source
```

Select:

```text
Prometheus
```

URL:

```text
http://prometheus:9090
```

Click:

```text
Save & Test
```

#### Import Dashboard

Navigate to:

```text
Dashboards → Import
```

Dashboard ID:

```text
1860
```

Dashboard Name:

```text
Node Exporter Full
```

---

### 4. Configure Uptime Kuma

Create monitors for:

* Grafana
* Prometheus
* n8n
* Portfolio Website

Example URLs:

```text
http://grafana:3000
http://prometheus:9090
http://n8n:5678
https://your-portfolio-url
```

Recommended Settings:

```text
Monitor Type: HTTP(s)
Heartbeat Interval: 60 seconds
Retries: 3
```

---

### 5. Install and Configure Ollama

Install Ollama on the EC2 instance:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Download a model:

```bash
ollama pull llama3.2
```

Verify installation:

```bash
ollama list
```

Expected output:

```text
llama3.2:latest
```

---

### 6. Allow Docker Containers to Access Ollama

Create a systemd override:

```bash
sudo systemctl edit ollama
```

Add:

```ini
[Service]
Environment="OLLAMA_HOST=0.0.0.0:11434"
```

Reload and restart:

```bash
sudo systemctl daemon-reload
sudo systemctl restart ollama
```

Verify:

```bash
sudo ss -tulpn | grep 11434
```

Expected:

```text
0.0.0.0:11434
```

---

### 7. Configure Docker Networking

Update `docker-compose.yml`:

```yaml
n8n:
  extra_hosts:
    - "host.docker.internal:host-gateway"
```

Restart containers:

```bash
docker compose down
docker compose up -d
```

Verify connectivity:

```bash
docker exec -it n8n sh

wget -qO- http://host.docker.internal:11434/api/tags
```

Expected output:

```json
{
  "models": [...]
}
```

---

### 8. Create Telegram Bot

Open Telegram and search:

```text
@BotFather
```

Create a new bot:

```text
/newbot
```

Follow the prompts and save the Bot Token.

Example:

```text
123456789:AAxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

---

### 9. Obtain Telegram Chat ID

Send a message to your bot.

Open:

```text
https://api.telegram.org/bot<BOT_TOKEN>/getUpdates
```

Example:

```text
https://api.telegram.org/bot123456789:AAxxxx/getUpdates
```

Locate:

```json
"chat": {
  "id": 5529135588
}
```

Save the Chat ID.

---

### 10. Configure n8n Workflow

Workflow Architecture:

```text
Webhook
   ↓
IF (Status Check)
   ↓
Ollama LLM
   ↓
Telegram
```

#### Webhook

Path:

```text
incident-alert
```

Method:

```text
POST
```

Production URL:

```text
http://SERVER_IP:5678/webhook/incident-alert
```

---

### 11. Configure Ollama Chat Model

Base URL:

```text
http://host.docker.internal:11434
```

Model:

```text
llama3.2:latest
```

Authentication:

```text
Not Required
```

---

### 12. Configure Telegram Node

Credential:

```text
Telegram Bot Token
```

Chat ID:

```text
YOUR_CHAT_ID
```

Message:

```javascript
{{$json.text}}
```

---

### 13. Configure Uptime Kuma Webhook

Create a Webhook notification.

Webhook URL:

```text
http://n8n:5678/webhook/incident-alert
```

Method:

```text
POST
```

Content-Type:

```text
application/json
```

Body:

```json
{
  "service": "{{ monitor.name }}",
  "status": "{{ status }}",
  "message": "{{ msg }}",
  "time": "{{ heartbeat.time }}"
}
```

Assign this notification to all monitors.

Disable direct Telegram notifications in Uptime Kuma to prevent duplicate alerts.

---

### 14. Test Incident Response

Simulate a failure:

```bash
docker stop grafana
```

Expected flow:

```text
Grafana DOWN
      ↓
Uptime Kuma detects failure
      ↓
Webhook sent to n8n
      ↓
Ollama analyzes incident
      ↓
Telegram notification received
```

Restore service:

```bash
docker start grafana
```

Verify recovery notification is received.

---

### Final Workflow

```text
Grafana
Prometheus
n8n
Portfolio Website
        │
        ▼
   Uptime Kuma
        │
        ▼
      Webhook
        │
        ▼
        n8n
        │
        ▼
 Ollama (Llama 3.2)
        │
        ▼
    Telegram Bot
```

### Skills Demonstrated

* AWS EC2
* Docker Compose
* Infrastructure Monitoring
* Prometheus
* Grafana
* Uptime Kuma
* n8n Automation
* Ollama Local LLM
* Telegram Bot Integration
* Incident Response Automation
* AI-Powered Monitoring
* DevOps Troubleshooting
