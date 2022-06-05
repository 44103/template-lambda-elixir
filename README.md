# AWS LambdaでElixirをGAS並みにお手軽構築

## 取扱説明
1. GitHubからClone
   ```bash
   git clone <URL>
   ```
1. Elixirプロジェクトの作成
   ```bash
   make create <Lambda関数名>
   ```
2. プロジェクトの編集
   1. 依存ライブラリの編集
      - `mix.exs`を編集
      ```elixir
      def application do
         [
            mod: {FaasBase.Aws.Application, []}
         ]
      end

      # Run "mix help deps" to learn about dependencies.
      defp deps do
         [
            {:faas_base, "~> 1.0.2"}
         ]
      end
      ```
   1. 依存ライブラリの取得
      ```bash
      make deps FUNC=<Lambda関数名>
      ```
3. Lambdaで実行する処理を記述
    - `src/<Lambda関数名>/lib`内にコードを記述
4. ビルド
   ```bash
   make build FUNC=<Lambda関数名>
   ```
5. AWSに環境構築
    - Terraformの[README](infrastructure/README.md)を基に実行
