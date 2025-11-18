# Dockerfile minimal avec vulnérabilités
FROM alpine:3.12

# Installer des packages connus pour avoir des CVEs
RUN apk add --no-cache bash curl openssl=1.1.1g-r0 \
    && echo "Lab pédagogique vulnérable" > /lab.txt

# Commande par défaut
CMD ["echo", "Hello Docker Scan Lab"]
