FROM ubuntu:22.04

RUN apt-get update && apt-get install -y file unzip curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# نسخ ملفات التنفيذ فقط (صغيرة)
COPY linux_amd64 /app/linux_amd64
COPY windows_amd64 /app/windows_amd64
COPY config.json /app/config.json

# منح الصلاحيات
RUN chmod +x /app/linux_amd64 /app/windows_amd64

# تحميل frontend_assets مباشرة من GitHub أثناء البناء
RUN curl -L -o /tmp/frontend.zip "https://github.com/XZB-1248/Spark/releases/download/v0.0.1/frontend_assets.zip" && \
    unzip /tmp/frontend.zip -d /app/frontend_assets && \
    rm /tmp/frontend.zip && \
    ls -la /app/frontend_assets

# التحقق من الملف
RUN file /app/linux_amd64

EXPOSE 10000

CMD ["/app/linux_amd64"]
