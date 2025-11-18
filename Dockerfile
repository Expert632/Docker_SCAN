# Dockerfile minimal avec vulnérabilités
FROM alpine:3.12

# Installer quelques paquets (époque ancienne = CVE probables)
RUN apk add --no-cache bash curl openssl \
    && echo "Lab pédagogique vulnérable" > /lab.txt

CMD ["echo", "Hello Docker Scan Lab"]
