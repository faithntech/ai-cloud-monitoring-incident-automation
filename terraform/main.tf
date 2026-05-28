resource "aws_security_group" "monitoring_sg" {
  name        = "ai-cloud-monitoring-sg"
  description = "Security group for AI Cloud Monitoring setup"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "Prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "Uptime Kuma"
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "n8n"
    from_port   = 5678
    to_port     = 5678
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "Node Exporter"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "ai-cloud-monitoring-sg"
    Project = "AI Cloud Monitoring"
  }
}

resource "aws_key_pair" "ai_cloud_key" {
  key_name   = var.key_name
  public_key = file("ai-cloud-key.pub")
}

resource "aws_instance" "monitoring_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ai_cloud_key.key_name
  vpc_security_group_ids = [aws_security_group.monitoring_sg.id]

  user_data = file("docker-install.sh")

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name    = "ai-cloud-monitoring-server"
    Project = "AI Cloud Monitoring"
  }
}
