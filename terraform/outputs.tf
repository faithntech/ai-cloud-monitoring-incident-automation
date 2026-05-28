output "instance_public_ip" {
  value = aws_instance.monitoring_server.public_ip
}

output "ssh_command" {
  value = "ssh -i ${aws_key_pair.ai_cloud_key.key_name} ubuntu@${aws_instance.monitoring_server.public_ip}"
}

output "grafana_url" {
  value = "http://${aws_instance.monitoring_server.public_ip}:3000"
}

output "prometheus_url" {
  value = "http://${aws_instance.monitoring_server.public_ip}:9090"
}

output "uptimekuma_url" {
  value = "http://${aws_instance.monitoring_server.public_ip}:3001"
}

output "n8n_url" {
  value = "http://${aws_instance.monitoring_server.public_ip}:5678"
}
