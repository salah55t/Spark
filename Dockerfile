FROM ubuntu:22.04

RUN apt-get update && apt-get install -y file unzip curl ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# الملف الرئيسي
COPY linux_amd64 /app/spark
COPY server_windows_amd64 /app/server_windows_amd64
COPY config.json /app/config.json

RUN chmod +x /app/spark /app/server_windows_amd64

# تحميل frontend_assets
RUN curl -fsSL -o /tmp/frontend.zip "https://github.com/XZB-1248/Spark/releases/download/v0.2.1/frontend_assets.zip" && \
    unzip -q /tmp/frontend.zip -d /app/frontend_assets && \
    rm /tmp/frontend.zip

# عرض الملفات للتأكد
RUN echo "=== الملفات ===" && ls -la /app/

EXPOSE 10000

CMD ["/app/spark"]
