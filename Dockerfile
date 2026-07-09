FROM ubuntu:22.04

# تثبيت أدوات مساعدة للتشخيص
RUN apt-get update && apt-get install -y file && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# نسخ الملفات
COPY linux_amd64 /app/spark
COPY config.json /app/config.json

# تحقق من نوع الملف ومنح الصلاحيات
RUN file /app/spark && \
    chmod +x /app/spark && \
    ls -la /app

# فحص محتوى config.json
RUN cat /app/config.json

# المنفذ
EXPOSE 10000

# تشغيل الخادم مع عرض أي أخطاء
CMD ["/app/spark", "--listen", ":10000"]
