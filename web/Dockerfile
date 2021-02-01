FROM ubuntu
ENV DEBCONF_NOWARNINGS yes
RUN apt-get -y update 
RUN apt-get -y upgrade
RUN apt-get -y install language-pack-ja
ENV LANG="ja_JP UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8" \
    TZ="Asia/Tokyo"

# killallコマンドのインストール
RUN apt-get -y install psmisc

# pythonとpip
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN ln -s /usr/bin/python3 /usr/local/bin/python
RUN ln -s /usr/bin/pip3 /usr/local/bin/pip

# nginx
RUN apt-get -y install nginx
COPY setting/etc-nginx/proxy_params    /etc/nginx/
COPY setting/etc-nginx/conf.d/web.conf /etc/nginx/conf.d/

# 

WORKDIR /setting
COPY setting/requirements.txt /setting
COPY setting/wait-for-postgres.sh /setting
RUN pip install -r /setting/requirements.txt

COPY setting/run.sh /setting

# codeはdocker-composeでマウントする
WORKDIR /code
RUN ln -s /code/static /usr/share/nginx/html

###CMD ["/bin/bash","/setting/run.sh"]


