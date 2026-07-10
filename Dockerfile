FROM ubuntu:22.04

RUN apt-get update && apt-get install -y file unzip curl ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# نسخ الملف المحلي فقط
COPY linux_amd64 /app/linux_amd64
COPY config.json /app/config.json

RUN chmod +x /app/linux_amd64

# تحميل windows_amd64 من GitHub
RUN curl -fsSL -o /tmp/windows.zip "https://github.com/XZB-1248/Spark/releases/download/v0.2.1/server_windows_amd64.zip" && \
    unzip -q -o /tmp/windows.zip -d /app/ && \
    mv /app/server_windows_amd64 /app/windows_amd64 2>/dev/null || true && \
    chmod +x /app/windows_amd64 && \
    rm /tmp/windows.zip

# تحميل frontend_assets من GitHub
RUN curl -fsSL -o /tmp/frontend.zip "https://github.com/XZB-1248/Spark/releases/download/v0.2.1/frontend_assets.zip" && \
    unzip -q /tmp/frontend.zip -d /app/frontend_assets && \
    rm /tmp/frontend.zip && \
    ls -la /app/frontend_assets

RUN file /app/linux_amd64 && file /app/windows_amd64

EXPOSE 10000

CMD ["/app/linux_amd64"]
