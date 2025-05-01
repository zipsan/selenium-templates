FROM ubuntu:24.04

RUN apt update -y && \
    apt upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    locales curl ca-certificates gnupg2 tzdata \
    git busybox unzip jq \
    build-essential libreadline-dev libncursesw5-dev libssl-dev libsqlite3-dev libgdbm-dev libbz2-dev liblzma-dev zlib1g-dev uuid-dev libffi-dev libdb-dev && \
    SUPERCRONIC_VERSION=v0.2.33 && \
    TARGETARCH=$(dpkg --print-architecture) && \
    curl -L "https://github.com/aptible/supercronic/releases/download/${SUPERCRONIC_VERSION}/supercronic-linux-${TARGETARCH}" -o /usr/local/bin/supercronic && \
    chmod +x /usr/local/bin/supercronic && \
    apt clean all && \
    rm -rf /var/lib/apt/lists/*

ENV TZ=Asia/Tokyo
RUN localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8 && \
    sh -c 'ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone'

RUN curl -O https://www.python.org/ftp/python/3.9.22/Python-3.9.22.tgz && \
    tar xf Python-3.9.22.tgz && \
    cd Python-3.9.22 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.9.22 Python-3.9.22.tgz

RUN ln -s /usr/local/bin/python3.9 /usr/bin/python3.9 && \
    ln -s /usr/local/bin/pip3.9 /usr/bin/pip3.9

WORKDIR /tmp/

COPY requirements.txt /tmp

RUN pip3.9 install --upgrade pip --no-cache-dir && \
    pip3.9 install -r /tmp/requirements.txt --no-cache-dir && \
    rm /tmp/requirements.txt

WORKDIR /app/

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

CMD ["/usr/local/bin/supercronic", "/app/cron/job.cron"]
