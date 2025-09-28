# Ambiente de Compilação LaTeX com Docker e VSCode DevContainer

Este repositório fornece um ambiente completo para compilação de documentos LaTeX usando **MiKTeX** em **Ubuntu 24.04**, encapsulado em **Docker**. Ele é integrado ao **VSCode** via **DevContainer**, permitindo uma experiência de IDE pronta para uso.

---

## Estrutura do Projeto

```

.
├── .devcontainer
│   └── devcontainer.json        # Configuração do VSCode DevContainer
├── .env                        # Variáveis de ambiente usadas no Dockerfile e Compose
├── Docker-compose.yml           # Define o serviço LaTeX com MiKTeX
├── Dockerfile                   # Imagem base Ubuntu + MiKTeX
└── TCC                          # Projeto LaTeX
├── main.tex                 # Arquivo principal
├── compiletex.sh            # Script de compilação
└── ...                      # Outras pastas e arquivos do projeto

````

---

## Requisitos

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [VSCode](https://code.visualstudio.com/)
- Extensão **Dev Containers** no VSCode

---

## Configuração Inicial

1. Clone o repositório:

```bash
git clone <URL_DO_REPOSITORIO>
cd <NOME_DO_REPOSITORIO>
````

2. Crie um arquivo `.env` se ainda não existir, com as variáveis necessárias:

```env
USERNAME=devuser
UBUNTU_CODENAME=noble
```

> ⚠️ `USERNAME` deve coincidir com o `ARG USERNAME` no Dockerfile.

---

## Usando o Docker Compose

Para construir a imagem e iniciar o container:

```bash
docker-compose up --build -d
```

* O serviço será chamado `miktex-container`.
* O diretório do projeto será montado dentro do container em `/workdir`.
* O cache do MiKTeX será persistido no volume `miktex-cache`.

Para entrar no container:

```bash
docker exec -it miktex-container bash
```

Para parar o container:

```bash
docker-compose down
```

---

## Usando o VSCode DevContainer

1. Abra o projeto no VSCode.
2. Clique no canto inferior esquerdo em **"Reabrir em Container"** (ou `Ctrl+Shift+P` → `Dev Containers: Reopen in Container`).
3. O VSCode irá construir o container e abrir o ambiente com acesso total ao projeto e à MiKTeX.

> Todos os comandos LaTeX podem ser executados no terminal integrado do VSCode dentro do DevContainer.

---

## Compilação do Documento LaTeX

Dentro do container ou do DevContainer, você pode compilar seu TCC com o script:

```bash
cd TCC
./compiletex.sh
```

O script gera arquivos auxiliares (`.aux`, `.log`, `.toc`, etc.) e o PDF final `main.pdf`.

---

## Recursos Adicionais

* MiKTeX está configurado com **AutoInstall** para pacotes faltantes.
* O cache do MiKTeX é persistido, evitando reinstalação de pacotes entre execuções.
* O container roda como usuário não-root `devuser` para maior segurança.

---



