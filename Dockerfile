FROM ubuntu:22.04

RUN apt-get update && apt-get install -y file unzip curl ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# نسخ الملفات المحلية
COPY linux_amd64 /app/linux_amd64
COPY windows_amd64 /app/windows_amd64
COPY config.json /app/config.json

RUN chmod +x /app/linux_amd64 /app/windows_amd64

# تحميل frontend_assets - الإصدار الصحيح v0.2.1
RUN curl -fsSL -o /tmp/frontend.zip "https://github.com/XZB-1248/Spark/releases/download/v0.2.1/frontend_assets.zip" && \
    unzip -q /tmp/frontend.zip -d /app/frontend_assets && \
    rm /tmp/frontend.zip && \
    ls -la /app/frontend_assets

RUN file /app/linux_amd64

EXPOSE 10000

CMD ["/app/linux_amd64"]
