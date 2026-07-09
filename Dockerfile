FROM ubuntu:22.04

RUN apt-get update && apt-get install -y file unzip && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# نسخ ملفات التنفيذ
COPY linux_amd64 /app/linux_amd64
COPY windows_amd64 /app/windows_amd64

# نسخ ملفات الواجهة (مهم جداً!)
COPY frontend_assets /app/frontend_assets

# نسخ الإعدادات
COPY config.json /app/config.json

# منح الصلاحيات
RUN chmod +x /app/linux_amd64 /app/windows_amd64

# التحقق
RUN file /app/linux_amd64 && ls -la /app/frontend_assets

EXPOSE 10000

CMD ["/app/linux_amd64"]
