FROM ubuntu:22.04

WORKDIR /app

# انسخ الملف التنفيذي (linux_amd64) و config.json
COPY linux_amd64 /app/spark
COPY config.json /app/config.json

# منح صلاحية التنفيذ
RUN chmod +x /app/spark

# المنفذ المطلوب من Render
EXPOSE 10000

# تشغيل الخادم على المنفذ 10000
CMD ["/app/spark", "--listen", ":10000"]
