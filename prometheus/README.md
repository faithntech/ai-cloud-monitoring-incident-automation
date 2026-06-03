# Prometheus Configuration

## Overview

This folder contains the Prometheus configuration used by the AI-Powered Cloud Monitoring & Incident Automation Platform.

Prometheus is responsible for collecting and storing time-series metrics from monitored services. In this project, Prometheus collects infrastructure metrics from Node Exporter and internal metrics from Prometheus itself.

---

# Folder Structure

```text
prometheus/
├── prometheus.yml
└── README.md
```

---

# What is Prometheus?

Prometheus is an open-source monitoring and alerting toolkit designed for reliability and scalability.

Prometheus works by:

1. Connecting to configured targets
2. Scraping metrics at regular intervals
3. Storing metrics in a time-series database
4. Making metrics available for visualization in Grafana

---

# Architecture

```text
Node Exporter
      │
      │ Metrics
      ▼
Prometheus
      │
      ▼
Grafana Dashboard
```

---

# Configuration File

File:

```text
prometheus.yml
```

Example configuration:

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: "node-exporter"
    static_configs:
      - targets: ["node-exporter:9100"]

  - job_name: "prometheus"
    static_configs:
      - targets: ["prometheus:9090"]
```

---

# Configuration Breakdown

## Global Settings

```yaml
global:
  scrape_interval: 15s
```

### Purpose

Defines how often Prometheus collects metrics from configured targets.

### Explanation

```text
15s = every 15 seconds
```

Prometheus will poll each configured target every 15 seconds.

Example:

```text
00:00:00
00:00:15
00:00:30
00:00:45
```

A lower interval provides more granular monitoring but increases resource usage.

---

# Scrape Configurations

The `scrape_configs` section defines which services Prometheus should monitor.

---

## Job 1: Node Exporter

```yaml
- job_name: "node-exporter"
```

### Purpose

Collect infrastructure metrics from the server.

Metrics include:

* CPU usage
* Memory usage
* Disk utilization
* Network traffic
* System load
* Uptime

---

### Target Configuration

```yaml
static_configs:
  - targets: ["node-exporter:9100"]
```

### Explanation

```text
node-exporter = Docker container name
9100 = Node Exporter metrics port
```

Prometheus accesses:

```text
http://node-exporter:9100/metrics
```

Sample metric:

```text
node_cpu_seconds_total
```

This metric tracks CPU utilization.

---

## Job 2: Prometheus Self-Monitoring

```yaml
- job_name: "prometheus"
```

### Purpose

Allow Prometheus to monitor itself.

This helps track:

* Prometheus health
* Scrape performance
* Storage usage
* Query performance

---

### Target Configuration

```yaml
static_configs:
  - targets: ["prometheus:9090"]
```

Prometheus scrapes:

```text
http://prometheus:9090/metrics
```

Example metrics:

```text
prometheus_tsdb_head_series
prometheus_engine_queries
prometheus_build_info
```

---

# Why Node Exporter is Important

Node Exporter exposes operating system metrics to Prometheus.

Without Node Exporter:

```text
Prometheus
❌ Cannot monitor CPU
❌ Cannot monitor RAM
❌ Cannot monitor Disk
```

With Node Exporter:

```text
Prometheus
✓ CPU Monitoring
✓ RAM Monitoring
✓ Disk Monitoring
✓ Network Monitoring
✓ Server Health Monitoring
```

---

# Verifying Prometheus Targets

Open:

```text
http://<SERVER-IP>:9090/targets
```

Expected result:

```text
node-exporter = UP

prometheus = UP
```

If a target shows:

```text
DOWN
```

Check:

```bash
docker ps
```

Verify the container is running.

---

# Useful Prometheus Queries

## CPU Usage

```promql
100 - (avg by(instance)
(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

---

## Memory Usage

```promql
(node_memory_MemTotal_bytes
-
node_memory_MemAvailable_bytes)
/
node_memory_MemTotal_bytes * 100
```

---

## Disk Usage

```promql
100 -
(
node_filesystem_avail_bytes
/
node_filesystem_size_bytes
* 100
)
```

---

# Troubleshooting

## Target DOWN

### Problem

Prometheus cannot scrape metrics.

### Check

```bash
docker ps
```

### Verify

```bash
docker logs prometheus
docker logs node-exporter
```

---

## No Metrics in Grafana

### Cause

Prometheus data source is not configured correctly.

### Solution

Verify Grafana Data Source:

```text
http://prometheus:9090
```

---

# Learning Outcomes

Through this configuration, I learned:

* Prometheus architecture
* Metric scraping
* Time-series monitoring
* Infrastructure observability
* Integration with Grafana
* Monitoring Linux servers using Node Exporter
* Troubleshooting monitoring pipelines

```
```
