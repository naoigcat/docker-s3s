FROM python:3.11-slim-bullseye AS build
ARG REVISION=88929ad072cb04c5d517cd8a5c36236e077ffe75
WORKDIR /tmp
RUN apt-get update -y && \
    apt-get install -y \
        unzip \
        wget \
    && \
    wget "https://github.com/frozenpandaman/s3s/archive/${REVISION}.zip" -O /tmp/s3s.zip && \
    unzip s3s.zip && \
    mv /tmp/s3s-${REVISION} /opt/s3s && \
    sed -i -E "/^\s*check_for_updates/d" /opt/s3s/s3s.py && \
    pip install --user -r /opt/s3s/requirements.txt && \
    rm -rf /opt/s3s/{.github,.gitignore,requirements.txt} && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

FROM python:3.11-slim-bullseye
LABEL maintainer="naoigcat <17925623+naoigcat@users.noreply.github.com>"
COPY --from=build /root/.local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=build /opt/s3s /opt/s3s
RUN addgroup --system --gid 1000 s3s && \
    adduser --system --gid 1000 --uid 1000 s3s && \
    chown -R s3s.s3s /opt/s3s
WORKDIR /opt/s3s
USER s3s
ENTRYPOINT ["python3", "/opt/s3s/s3s.py"]
