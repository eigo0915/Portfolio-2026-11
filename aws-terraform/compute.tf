# Red Hat 公式の RHEL 9
data "aws_ami" "rhel9" {
  most_recent = true
  owners = ["309956199498"] 

  filter {
    name = "name"
    values = ["RHEL-9.*_HVM-*-x86_64-*-Hourly2-GP3"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

# 共通 SSH 公開鍵の登録
resource "aws_key_pair" "common_key" {
  key_name   = "key-common_${var.project_suffix}"
  public_key = file(var.ssh_public_key_path)
}

# EC2 インスタンス (Server1)
resource "aws_instance" "server1" {
  ami = data.aws_ami.rhel9.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.private.id
  private_ip = "10.0.1.5"
  vpc_security_group_ids = [aws_security_group.server1_sg.id]
  key_name = aws_key_pair.common_key.key_name
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  # RHEL 9 には SSM Agent が標準搭載されていないため起動時に導入
  user_data = <<-EOF
              #!/bin/bash
              dnf install -y https://s3.${var.region}.amazonaws.com/amazon-ssm-${var.region}/latest/linux_amd64/amazon-ssm-agent.rpm
              systemctl enable --now amazon-ssm-agent
              EOF

  tags = {
    Name = "Server1"
  }
}