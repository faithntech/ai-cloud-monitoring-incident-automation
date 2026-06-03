# Troubleshooting Guide

## AI Cloud Monitoring & Incident Automation Project

This document summarizes the issues encountered while integrating Uptime Kuma, n8n, Gemini AI, and Telegram notifications.

---

# 1. Uptime Kuma Webhook Notification Keeps Loading

## Problem

When saving or testing a Webhook notification in Uptime Kuma, the loading spinner never completes.

## Root Cause

The webhook URL was incorrect or unreachable from the Uptime Kuma container.

Examples:

```text
http://localhost:5678/webhook/incident-alert
```

Inside Docker, `localhost` refers to the Uptime Kuma container itself, not the n8n container.

## Solution

Use the Docker service name instead:

```text
http://n8n:5678/webhook/incident-alert
```

For external access:

```text
http://<EC2_PUBLIC_IP>:5678/webhook/incident-alert
```

---

# 2. n8n Webhook Not Triggering

## Problem

The Webhook node displayed:

```text
Waiting for you to call the Test URL
```

and no execution appeared.

## Root Cause

No request was reaching the webhook endpoint.

## Solution

Verify:

* Webhook path is correct
* HTTP method is POST
* Workflow is active
* Uptime Kuma uses the correct URL

Test manually:

```bash
curl -X POST http://<IP>:5678/webhook-test/incident-alert \
-H "Content-Type: application/json" \
-d '{"service":"Grafana","status":"DOWN","message":"Connection refused"}'
```

---

# 3. Basic LLM Chain Error: No Prompt Specified

## Problem

```text
NodeOperationError: No prompt specified
```

## Root Cause

The Basic LLM Chain was configured to use:

```text
Connected Chat Trigger Node
```

instead of receiving data from the Webhook node.

## Solution

Change:

```text
Source for Prompt (User Message)
```

to:

```text
Define Below
```

Then provide a custom prompt.

Example:

```text
You are an AI incident response assistant.

Analyze this alert:

Service: {{$json.body.service}}
Status: {{$json.body.status}}
Message: {{$json.body.message}}

Provide:
Summary
Possible Cause
Recommended Action
```

---

# 4. OpenAI API Insufficient Quota

## Problem

```text
Insufficient quota detected
```

## Root Cause

ChatGPT Plus does not include OpenAI API credits.

The OpenAI API requires separate billing.

## Solution

Options:

### Option 1

Add billing to OpenAI Platform:

```text
https://platform.openai.com
```

Generate a new API key and update n8n credentials.

### Option 2

Switch to Gemini API.

This project was migrated to Gemini AI.

---

# 5. Gemini Responds With "Please Provide Details of the Incident"

## Problem

Gemini returned:

```text
Incident response started. Please provide details of the incident.
```

## Root Cause

Prompt variables referenced fields that did not exist.

Example:

```text
{{$json.service}}
{{$json.status}}
```

Actual webhook structure:

```json
{
  "body": {
    "service": "Grafana",
    "status": "DOWN",
    "message": "Connection refused"
  }
}
```

## Solution

Use:

```text
{{$json.body.service}}
{{$json.body.status}}
{{$json.body.message}}
```
---

# 6. Telegram Displays "undefined"

## Problem

Telegram message contained:

```text
undefined
```

## Root Cause

Telegram referenced a field that did not exist.

Example:

```text
{{$json.output}}
```

or

```text
{{$json.chatInput}}
```

## Solution

Inspect the LLM output JSON.

Actual Gemini response:

```json
{
  "text": "..."
}
```

Use:

```text
{{$json.text}}
```

---

# 8. Gemini Returns Empty Service, Status, and Message

## Problem

Telegram output:

```text
Summary: The service status is .
Message: .
```

## Root Cause

Prompt variables referenced incorrect paths.

## Solution

Inspect Webhook Input JSON and use the correct fields.

Example:

```text
Service: {{$json.body.service}}
Status: {{$json.body.status}}
Message: {{$json.body.message}}
```

---

# 9. Understanding JSON.stringify($json)

## Purpose

Used for debugging webhook payloads.

Example:

```text
{{ JSON.stringify($json) }}
```

## Input

```json
{
  "body": {
    "service": "Grafana",
    "status": "DOWN",
    "message": "Connection refused"
  }
}
```

## Output

```text
{"body":{"service":"Grafana","status":"DOWN","message":"Connection refused"}}
```

This helps determine the exact JSON structure being passed between nodes.

---

# Lessons Learned

* Always inspect webhook payloads before building prompts.
* Use `JSON.stringify($json)` for debugging.
* Verify node output fields before referencing them.
* ChatGPT Plus does not include OpenAI API credits.
* Gemini is a practical free alternative for AI automation projects.
* Telegram formatting can break AI-generated messages if Markdown is enabled.
* Test each component independently:

  * Uptime Kuma
  * Webhook
  * AI Model
  * Telegram

This troubleshooting process helped build a working AI-powered incident response workflow using Uptime Kuma, n8n, Gemini AI, and Telegram notifications.
