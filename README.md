# AWS LambdaでElixirをGAS並みにお手軽構築

## 取扱説明
1. GitHubからClone
    ```bash
    git clone <URL>
    ```
1. Elixirプロジェクトの作成
    ```bash
    docker-compose run --rm projex mix new lambda_ex
    ```
1. プロジェクトの編集
    1. 依存ライブラリの編集
        - `mix.exs`を編集
    1. 依存ライブラリの取得
        ```bash
        docker-compose run --rm buildex mix deps.get
        docker-compose run --rm buildex mix distillery.init
        ```
1. Lambdaで実行する処理を記述
    - `src/lambda_ex/lib`内にコードを記述
1. ビルド
    ```bash
    docker-compose run --rm buildex mix erllambda.release
    ```
1. AWSに環境構築
    - Terraformの[README](infrastructure/README.md)を基に実行