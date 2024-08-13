ARG VARIANT=1-1.22-bookworm
FROM mcr.microsoft.com/devcontainers/go:${VARIANT}

RUN apt-get update && apt-get -y install telnet postgresql-client
RUN go install github.com/jackc/tern/v2@latest
RUN go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest

# Defina variáveis de ambiente para UID, GID e USERNAME
ARG USERNAME
ARG USER_UID
ARG USER_GID

# Remover o usuário vscode se existir
RUN if id -u vscode > /dev/null 2>&1; then \
    userdel vscode; \
    fi

# Crie um grupo e usuário com os mesmos UID e GID do host
RUN getent group $USER_GID || groupadd -g $USER_GID $USERNAME && \
    useradd -m -u $USER_UID -g $USER_GID -s /bin/bash $USERNAME

RUN chown -R $USERNAME:$USER_GID /go
# Defina o usuário padrão para o container
USER $USERNAME