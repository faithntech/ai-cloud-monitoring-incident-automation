output "elastic_ip" {
  value = aws_eip.monitoring_eip.public_ip
}

output "ssh_command" {
  value = "ssh -i key-pair/ai-cloud-key ubuntu@${aws_eip.monitoring_eip.public_ip}"
}

output "grafana_url" {
  value = "http://${aws_eip.monitoring_eip.public_ip}:3000"
}

output "prometheus_url" {
  value = "http://${aws_eip.monitoring_eip.public_ip}:9090"
}

output "uptimekuma_url" {
  value = "http://${aws_eip.monitoring_eip.public_ip}:3001"
}

output "n8n_url" {
  value = "http://${aws_eip.monitoring_eip.public_ip}:5678"
}
