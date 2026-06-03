# n8n Incident Automation Workflow 

This folder contains the exported n8n workflow used for AI-powered incident response. 

## Workflow Flow 

```
text Webhook Trigger → Google Gemini API → AI Incident Summary → Telegram Notification
```

## Purpose

The workflow receives monitoring alerts from Uptime Kuma, generates an AI-powered incident summary, and sends the result to Telegram.

## Webhook Path
```
/webhook/incident-alert
```

### Example Incident Payload
```
{
  "service": "Grafana",
  "status": "DOWN",
  "severity": "Critical",
  "message": "Grafana is not responding",
  "time": "2026-06-01 14:00"
}
```
---
