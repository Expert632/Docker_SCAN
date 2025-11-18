# Dockerfile minimal pour image volontairement vulnérable
FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

# On installe quelques paquets souvent vulnérables
RUN apt-get update && \
    apt-get install -y \
      openssl \
      curl \
      wget \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Marqueur pédagogique
RUN echo "Lab pédagogique vulnérable - Ubuntu 16.04" > /lab.txt

CMD ["bash", "-c", "echo 'Hello from vulnerable Docker image'; sleep 60"]
