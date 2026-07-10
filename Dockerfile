FROM ubuntu:22.04

RUN apt-get update && apt-get install -y file unzip curl ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY linux_amd64 /app/spark
COPY windows_amd64.exe /app/windows_amd64.exe
COPY config.json /app/config.json

RUN chmod +x /app/spark /app/windows_amd64.exe

# تحميل frontend_assets
RUN curl -fsSL -o /tmp/frontend.zip "https://github.com/XZB-1248/Spark/releases/download/v0.2.1/frontend_assets.zip" && \
    unzip -q /tmp/frontend.zip -d /app/frontend_assets && \
    rm /tmp/frontend.zip

# نسخ بجميع الأسماء المحتملة في جميع المواضع المحتملة
RUN cp /app/windows_amd64.exe /app/windows_amd64 && \
    mkdir -p /app/bin /app/assets && \
    cp /app/windows_amd64.exe /app/bin/windows_amd64 && \
    cp /app/windows_amd64.exe /app/assets/windows_amd64 && \
    chmod +x /app/windows_amd64 /app/bin/windows_amd64 /app/assets/windows_amd64 && \
    echo "=== الملفات في /app ===" && ls -la /app/ && \
    echo "=== الملفات في /app/bin ===" && ls -la /app/bin/

EXPOSE 10000

CMD ["/app/spark"]
