# Image volontairement extrêmement ancienne et vulnérable
FROM ubuntu:14.04

ENV DEBIAN_FRONTEND=noninteractive

# On installe plusieurs paquets classiques connus pour accumuler des CVE :
# - openssl (crypto, plein de CVE)
# - curl, wget (réseau)
# - apache2 (serveur web)
# - php5 (vieux PHP blindé de failles)
RUN apt-get update && \
    apt-get install -y \
      openssl \
      curl \
      wget \
      apache2 \
      php5 && \
    rm -rf /var/lib/apt/lists/*

# Petit fichier de repère pédagogique
RUN echo "Lab pédagogique TRÈS vulnérable - Ubuntu 14.04 + Apache2 + PHP5" > /lab.txt

# On lance juste apache pour faire joli (pas important pour le scan)
CMD ["bash", "-c", "echo 'Vulnerable lab running'; sleep 3600"]
