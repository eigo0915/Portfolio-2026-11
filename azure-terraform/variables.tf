variable "location" {
    description = "リソースをデプロイするAzureリｰジョン"
    type = string
    default = "japaneast"
}

variable "project_suffix" {
    description = "リソース命名に使用する識別サフィックス"
    type = string
    default = "IaC"
}
variable "vm_size" {
    description = "Server1の仮想マシンサイズ"
    type = string
    default = "Standard_B1s"
}
variable "admin_username" {
    description = "仮想マシンの管理者ユーザー名"
    type = string
    default = "adminuser"
}
variable "ssh_public_key_path" {
    description = "VMに登録するSSH公開鍵ファイルのパス"
    type = string
    default = "~/.ssh/id_rsa.pub"
}