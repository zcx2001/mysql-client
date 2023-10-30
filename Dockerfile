FROM ubuntu:22.04

ARG RUNNER=local

ENV DEBIAN_FRONTEND=noninteractive

# 修正中文显示
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# 添加mysql apt
ADD deb/. /tmp
# 添加数据库备份脚本
ADD script/. /script

WORKDIR /db

RUN if [ "${RUNNER}" != "github" ]; then \
        sed -i -E 's/(archive|security|ports).ubuntu.(org|com)/mirrors.aliyun.com/g' /etc/apt/sources.list; \
    fi \   
    && apt-get update \
    && apt-get install -y lsb-release ca-certificates locales tzdata wget gnupg cron nano --no-install-recommends\
    && dpkg -i /tmp/mysql-apt-config_0.8.28-1_all.deb \
    && apt-get update \
    && apt-get install -y mysql-client=8.0.35-1ubuntu22.04 --no-install-recommends \
    && locale-gen en_US.UTF-8  \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/cron.*/* \
    && rm -rf /tmp/*