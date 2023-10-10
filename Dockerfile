FROM ubuntu:22.04

ARG RUNNER=local

ENV DEBIAN_FRONTEND=noninteractive

# 修正中文显示
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /db

RUN if [ "${RUNNER}" != "github" ]; then \
        sed -i -E 's/(archive|security|ports).ubuntu.(org|com)/mirrors.aliyun.com/g' /etc/apt/sources.list; \
    fi \   
    && apt-get update \
    && apt-get install -y ca-certificates locales tzdata mysql-client \
    && locale-gen en_US.UTF-8  \
    && rm -rf /var/lib/apt/lists/*