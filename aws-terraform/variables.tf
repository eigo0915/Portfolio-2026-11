variable "region" {
    description = "リソースをデプロイするAWSリージョン"
    type = string
    default = "ap-northeast-1"
}

variable "project_suffix" {
    description = "リソース命名に使用する識別サフィックス"
    type = string
    default = "IaC"
}

variable "instance_type" {
    description = "Server1のEC2インスタンスタイプ"
    type = string
    default = "t3.micro"
}

variable "ssh_public_key_path" {
    description = "VMに登録するSSH公開鍵ファイルのパス"
    type        = string
    default     = "~/.ssh/id_rsa.pub"
}