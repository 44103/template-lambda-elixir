# Terraform環境構築

# 使い方
## 環境変数設定（AWSアクセスキー）
.env.exampleファイルを.envにリネームし、内容を変更する。

## 環境変数設定（APIキー）
terraform.tfvars.exampleファイルをterraform.tfvarsにリネームし、使用するAPIのキーなどを入力し、variables.tfファイルに変数定義をする。

## コンテナ起動
コマンド毎に使い切りのコンテナを建てる。  
```bash
docker-compose run --rm terraform fmt
docker-compose run --rm terraform validate
docker-compose run --rm terraform init
docker-compose run --rm terraform plan
docker-compose run --rm terraform apply -auto-approve
docker-compose run --rm terraform destroy -auto-approve
```

# Dev, Stg環境切り替え
```bash
docker-compose run --rm terraform workspace select dev
docker-compose run --rm terraform workspace select stg
```

# 参考文献
- [Docker-ComposeでTerraformを使う](https://qiita.com/m0559reen/items/1e433ff9e6f6229c3291)
- [AWSでTerraformに入門](https://dev.classmethod.jp/articles/terraform-getting-started-with-aws/)
