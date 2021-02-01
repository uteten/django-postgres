#!/bin/bash
# 概要
# - projectフォルダがない場合、テンプレートとしてprojectフォルダを作成する
# - projectフォルダがある場合は、migrateして起動

# 開発時によくやるコマンド例
# docker exec -it xxx /bin/bash
#  ./manage.py startapp abc..
# 



# djangoのプロジェクトフォルダがない場合作成
cd /code
if [[ ! -d project ]]; then
  # プロジェクト作成
  django-admin startproject config
  mv config project

  # 静的フォルダ作成 http://.../static/index.htmlとなる
  mkdir /code/static
  touch /code/static/index.html

  # -- 設定をsqlite3 -> posetgres接続に変更 --
  cd /code/project/config
  cp -p settings.py settings.py.org 
  sed -e 's/DATABASES/DATABASES_ORG/' settings.py.org > settings.py
  echo "DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'HOST': 'db',
        'PORT': '',
        'NAME': '$POSTGRES_DB',
        'USER': '$POSTGRES_USER',
        'PASSWORD': '$POSTGRES_PASSWORD',
    }
} " >> settings.py
  echo postgres接続するひな形を生成しました。
  echo あとは、project/config/settings.pyのALLOWED_HOSTS=[]を設定するとサンプルページが見れます。
fi

# postgresの起動を待つ(待たなくてもなんとかなるようだ)
#/bin/bash /setting/wait-for-postgres.sh db:5432

# gunicorn起動 ( config.wsgiはproject配下のconfig/wsgi.pyという意味)
#  (概念的にはgunicorn.socketに接続があるとdjangoの機能を呼び出す感じ)
cd /code/project
gunicorn --pid /run/gunicorn.pid --bind unix:/run/gunicorn.socket config.wsgi &


/usr/sbin/nginx

# django起動(通常起動する必要なし)
cd /code/project
python3 ./manage.py makemigrations
python3 ./manage.py migrate
python3 ./manage.py runserver 0.0.0.0:8000 &


/bin/sh -c "while :; do sleep 10; done"
