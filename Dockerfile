ARG PYTHON_VERSION=3.12
FROM python:${PYTHON_VERSION}-slim AS build
ARG REVISION=7e9ee2ba5578ea40140c7db60aa67a95c3f50b52
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

FROM python:${PYTHON_VERSION}-slim
LABEL maintainer="naoigcat <17925623+naoigcat@users.noreply.github.com>"
ARG PYTHON_VERSION
COPY --from=build /root/.local/lib/python${PYTHON_VERSION}/site-packages /usr/local/lib/python${PYTHON_VERSION}/site-packages
COPY --from=build /opt/s3s /opt/s3s
RUN addgroup --system --gid 1000 s3s && \
    adduser --system --gid 1000 --uid 1000 s3s && \
    chown -R s3s.s3s /opt/s3s
WORKDIR /opt/s3s
USER s3s
ENTRYPOINT ["python3", "/opt/s3s/s3s.py"]
