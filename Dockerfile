FROM ubuntu:24.04

ARG USERNAME=devuser
ARG USER_UID=1000
ARG USER_GID=1000



# Evita prompts interativos do apt
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza pacotes essenciais
RUN apt-get update && apt-get install -y \
    curl \
    gpg \
    ca-certificates \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://miktex.org/download/key |  gpg --dearmor -o /usr/share/keyrings/miktex.gpg


RUN echo "deb [signed-by=/usr/share/keyrings/miktex.gpg] https://miktex.org/download/ubuntu noble universe" |  tee /etc/apt/sources.list.d/miktex.list

RUN apt-get update && apt-get install -y miktex && rm -rf /var/lib/apt/lists/*

RUN miktexsetup finish && initexmf --update-fndb && initexmf --mklinks && initexmf --set-config-value [MPM]AutoInstall=1


RUN mkdir -p /etc/sudoers.d && \
    groupadd devuser && \
    useradd -m -g devuser -s /bin/bash devuser && \
    echo "devuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/devuser && \
    chmod 440 /etc/sudoers.d/devuser

USER devuser
WORKDIR /workdir

CMD ["bash"]