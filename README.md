# django+gunicorn+nginx+postgresひな形

以下で構成されるDjango開発環境を生成します
1. postgresのコンテナ
2. django+gunicorn+nginxのコンテナ

## ファイル構成
```
docker-compose.yml
db/        ...dbコンテナの/var/lib/postgres/data配下でマウント
web/
 +Dockerfile
 +setting/    ...webコンテナのイメージ生成に必要なファイル達
 +src/        ...webコンテナの/codeでマウント(djangoのコード)
 +src/static/ ...djangoを通さずにnginxで直接表示するパス(詳細はnginx設定ファイルsetting/conf.d/web.conf参照)
```

## Setup
```
docker-compose up
```
### 画面確認
1. http://localhost:10080/ でnginx->gunicorn->django経由の画面  
2. http://localhost:18000/ でdjango直接表示  
何を起動しているかはsetting/run.shを参照

## 開発時にsetting配下を修正した場合
イメージを生成し直す
```
docker-compose up --build 
```

## 開発時にweb/src/配下を修正した場合
gunicornにSIGHUPを送る
```
docker exec -it django-web killall -1 gunicorn
```




