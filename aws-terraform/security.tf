resource "aws_security_group" "server1_sg" {
  name = "server1-sg_${var.project_suffix}"
  description = "Security group for Server1 (SSM managed, no inbound allowed)"
  vpc_id = aws_vpc.vpc.id

# アウトバウンド通信
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-server1_${var.project_suffix}"
  }
}