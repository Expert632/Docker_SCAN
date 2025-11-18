# Image volontairement ancienne et vulnérable
FROM ubuntu:16.04

# Éviter les prompts interactifs
ENV DEBIAN_FRONTEND=noninteractive

# Mettre à jour et installer quelques paquets classiques
RUN apt-get update && \
    apt-get install -y \
      openssl \
      curl \
      wget \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Juste un fichier pour marquer le lab
RUN echo "Lab pédagogique vulnérable - Ubuntu 16.04" > /lab.txt

CMD ["bash", "-c", "echo 'Hello from vulnerable Docker image'"]
