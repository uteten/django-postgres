# django+gunicorn+nginx+postgresひな形

以下で構成されるDjango開発環境を生成します
1. postgresのコンテナ
2. django+gunicorn+nginxのコンテナ

## ファイル構成
docker-compose.yml
db/        ...dbコンテナの/var/lib/pgsql配下でマウント
web/
 +Dockerfile
 +setting/ ...webコンテナのイメージ生成に必要なファイル達
 +src/     ...webコンテナの/codeでマウント(djangoのコード)

## Setup
```
docker-compose up
```
http://localhost:10080/ でnginx経由
http://localhost:18000/ でdjango直接
何を起動しているかはsetting/run.shを参照

## 開発時にsetting配下を修正した場合
イメージを生成し直す
```
docker-compose build
docker-compose up
```

## web/src/配下を修正した場合
gunicornにSIGHUPを送る
```
docker ps
docker exec -it xxx /bin/bash
killall -1 gunicorn
```




