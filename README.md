# DSpace Structure

Ambiente Docker do backend DSpace 9, PostgreSQL e Solr. A configuracao DSpace versionada fica em `config/` e e montada em `/dspace/config` nos containers.

## Pre-requisitos

- Docker Engine e o plugin Docker Compose
- Git
- Node.js e PM2 somente para executar o frontend Angular fora do Docker

## Instalacao do backend

### 1. Obter o projeto

```bash
git clone <seu-repositorio>
cd dspace-structure
```

### 2. Criar os diretorios persistentes

```bash
chmod +x init-dirs.sh
./init-dirs.sh
```

O script cria o `assetstore`, os dados do PostgreSQL e os indices Solr. O conteudo desses diretorios nao e versionado pelo Git.

### 3. Definir a configuracao local

Crie o arquivo de ambiente e ajuste os valores para esta implantacao:

```bash
cp .env.example .env
```

No `.env`, defina uma senha forte em `DSPACE_DB_PASSWORD` e informe caminhos absolutos existentes para:

```dotenv
DSPACE_ASSETSTORE_DIR=/srv/dspace/assetstore
DSPACE_CONFIG_DIR=/srv/dspace/dspace-structure/config
POSTGRES_DATA_DIR=/srv/dspace/postgres-data
SOLR_DATA_DIR=/srv/dspace/solr-data
```

Os caminhos podem variar por servidor. O Compose le o `.env` ao lado de `docker-compose.yml`; ele nao deve ser enviado ao Git.

`DSPACE_CONFIG_DIR` deve apontar para a pasta `config/` deste repositorio. Nao copie configuracoes do container depois de iniciar: esse bind mount ja substitui `/dspace/config` e deve conter a configuracao completa antes do primeiro boot.

### 4. Permissoes dos diretorios

O usuario Linux que executa o Docker deve conseguir ler os diretorios configurados. Se a instalacao e administrada pelo usuario `dspace`, ele pode ser o dono da pasta do projeto e do assetstore:

```bash
sudo chown -R dspace:dspace /srv/dspace/dspace-structure /srv/dspace/assetstore
```

Nao aplique `chown -R dspace:dspace` em `POSTGRES_DATA_DIR` ou `SOLR_DATA_DIR`: esses volumes sao gravados pelos usuarios dos respectivos containers. O servico Solr ajusta seu proprio volume na inicializacao.

### 5. Iniciar os containers

```bash
docker compose -p d9 up -d
docker compose -p d9 ps
docker compose -p d9 logs -f dspace
```

O backend aguarda PostgreSQL e Solr, executa as migracoes do banco e responde em `http://localhost:8080/server` por padrao. Ajuste `dspace.server.url` e `dspace.ui.url` em `config/local.cfg` para os enderecos publicos da implantacao.

### 6. Criar o administrador inicial

Quando o backend estiver em execucao, crie a conta administradora:

```bash
docker compose -p d9 run --rm dspace-cli /dspace/bin/dspace create-administrator
```

### 7. Parar o ambiente

```bash
docker compose -p d9 down
```

Esse comando preserva assetstore, PostgreSQL e Solr. Use `down -v` apenas se desejar remover volumes nomeados; os bind mounts definidos no `.env` continuam no host.

## Frontend Angular com PM2

O frontend nao faz parte do `docker-compose.yml`. O arquivo `ecosystem.config.js` espera um projeto Angular separado e deve receber o caminho real desse checkout no campo `cwd` antes de executar:

```bash
pm2 start ecosystem.config.js
pm2 save
```

Configure o frontend para usar o endpoint publico definido em `dspace.server.url`.

## Diretorios importantes

- `config/`: configuracao DSpace montada nos containers.
- `assetstore/`: arquivos depositados no repositorio.
- `volumes/postgres-data/`: dados persistentes do PostgreSQL.
- `volumes/solr-data/`: indices persistentes do Solr.
- `data/`: dados locais auxiliares.

## Diagnostico

```bash
docker compose -p d9 ps
docker compose -p d9 logs --tail=200 dspace
docker compose -p d9 logs --tail=200 dspacedb dspacesolr
```
