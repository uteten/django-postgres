FROM centos
RUN dnf -y update 
RUN dnf -y upgrade
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial && \
    dnf -y upgrade && \
    dnf -y install glibc-locale-source && \
    dnf clean all && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
ENV LANG="ja_JP UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8" \
    TZ="Asia/Tokyo"

# killallコマンドのインストール
RUN dnf -y install psmisc

# pythonとpip
RUN dnf -y install python38
RUN ln -s /usr/bin/python3 /usr/local/bin/python
RUN ln -s /usr/bin/pip3 /usr/local/bin/pip

# nginx
RUN dnf -y install nginx
COPY setting/etc-nginx/proxy_params    /etc/nginx/
COPY setting/etc-nginx/conf.d/web.conf /etc/nginx/conf.d/
#RUN mkdir /usr/share/nginx/html/static

# 

WORKDIR /setting
COPY setting/requirements.txt /setting
RUN pip install -r /setting/requirements.txt

COPY setting/run.sh /setting

# codeはdocker-composeでマウントする
WORKDIR /code
RUN ln -s /code/static /usr/share/nginx/html

#CMD ["/bin/bash","/setting/run.sh"]


