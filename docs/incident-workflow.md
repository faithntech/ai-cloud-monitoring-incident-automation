# Incident Demo

## Test Scenario

Grafana container is stopped to simulate downtime.

## Command Used

```bash
docker stop grafana
```

### Expected Result

1. Uptime Kuma detects Grafana is down.
2. Uptime Kuma sends webhook alert to n8n.
3. n8n processes the alert.
4. AI generates a short incident summary.
5. Telegram receives the alert message.

### Recovery Command

```
docker start grafana
```
