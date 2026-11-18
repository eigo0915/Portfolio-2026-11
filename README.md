# マルチクラウド インフラ基盤構築 (Terraform / IaC)

同一のネットワーク・仮想マシン構成を、主要クラウド（**Azure / AWS / OCI**）の Terraform で実装し、設計やリソースの違いを比較するための検証リポジトリです。

---

## 1. 概要と基本方針

クラウドごとのリソース定義や構築手順の違いを整理するため、以下の共通条件をベースにコードを作成しています。

* **VM へのパブリック IP 非付与**: 仮想マシンにはパブリック IP を割り当てず、プライベートサブネット内に配置しています。
* **踏み台サービス経由での接続**: 外部からの SSH 接続は、各クラウドが提供する管理接続機能（Bastion / SSM）経由で行う前提の構成です。
* **OS の統一 (Red Hat Enterprise Linux 9)**: クラウド間の環境差異を減らすため、OS は RHEL 9 に揃えています。
* **SSH 公開鍵認証**: パスワード認証は無効化し、RSA 4096bit の公開鍵認証を使用しています。
* **ファイル分割と変数化**: ネットワーク・セキュリティ・コンピュートなどの役割ごとに `.tf` ファイルを分割し、リージョンや VM サイズなどの環境依存値は `variables.tf` にまとめています。

---

## 2. クラウド別実装一覧・コンポーネント比較

各ディレクトリ内の `README.md` に、構成図や `terraform plan` の確認ログを記載しています。

| 対象クラウド | ディレクトリ | ステータス | 仮想ネットワーク | 管理接続（踏み台） | アウトバウンド | 仮想マシン (RHEL 9) |
| :--- | :--- | :---: | :--- | :--- | :--- | :--- |
| **Microsoft Azure** | [`./azure-terraform`](./azure-terraform) | ✅ 完了 | VNet (`10.0.0.0/16`) | Azure Bastion | NAT Gateway | Linux VM (`Standard_B1s`) |
| **Amazon Web Services** | `./aws-terraform` | 🚧 作成予定 | VPC (`10.0.0.0/16`) | AWS Systems Manager | NAT Gateway | EC2 (`t3.micro`) |
| **Oracle Cloud (OCI)** | `./oci-terraform` | 🚧 作成予定 | VCN (`10.0.0.0/16`) | OCI Bastion | NAT Gateway | Compute (`VM.Standard.E2.1.Micro`) |

---

## 3. リポジトリ構成

```text
Portfolio/
├── README.md                  # 本ドキュメント（全体概要・比較）
├── .gitignore                 # .terraform/ や *.tfstate 等の除外設定
├── azure-terraform/           # 【完了】Azure 構築コード
│   ├── README.md              # Azure の構成詳細・plan ログ
│   ├── versions.tf
│   ├── variables.tf
│   ├── resource_group.tf
│   ├── network.tf
│   ├── security.tf
│   ├── compute.tf
│   ├── bastion.tf
│   └── terraform_plan.log
├── aws-terraform/             # 【予定】AWS 構築コード
└── oci-terraform/             # 【予定】OCI 構築コード
```

---

## 4. 使用技術

* **IaC**: Terraform (`>= 1.1.0`)
* **Cloud**: Microsoft Azure / AWS / OCI
* **OS**: Red Hat Enterprise Linux 9