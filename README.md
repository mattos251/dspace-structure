# DSpace Structure - Setup Guia de Configuração

## 📋 Pré-requisitos

- Docker e Docker Compose instalados
- Git
- Node.js (para PM2 com ecosystem.config.js)

## 🚀 Início Rápido

Siga os passos abaixo para inicializar o projeto:

### 1. Clone do Repositório

```bash
git clone <seu-repositorio>
cd dspace-structure
```

### 2. Inicializar Diretórios

Execute o script de inicialização para criar a estrutura de diretórios necessária:

```bash
bash init-dirs.sh
```

Este script cria automaticamente os diretórios e volumes necessários para o projeto.

## 🐳 Docker Compose

Inicie os containers com:

```bash
docker-compose up -d
```

Verifique o status:

```bash
docker-compose ps
```

Pare os containers:

```bash
docker-compose down
```


### 3. Copiar Configurações do Docker

Após os containers estarem em execução, copie as configurações do DSpace para o diretório raiz do projeto:

```bash
docker cp dspace:/dspace/config/. ~/Dspace/dspace-structure/dspace-config/
```

Isso garante que as configurações estejam sincronizadas com o projeto.

## 📁 Estrutura do Projeto

```
dspace-structure/
├── docker-compose.yml       # Configuração dos containers Docker
├── ecosystem.config.js       # Configuração do PM2
├── init-dirs.sh              # Script de inicialização
├── README.md                 # Este arquivo
├── data/                     # Dados gerais do projeto
├── dspace-config/            # Configurações do DSpace (sincronizadas do container)
│   ├── local.cfg             # Configurações locais
│   ├── item-submission.xml   # Configuração de submissão de itens
│   └── submission-forms.xml  # Configuração de formulários
└── volumes/                  # Volumes Docker persistentes
    ├── logs/                 # Logs dos containers
    ├── postgres-data/        # Dados do PostgreSQL
    └── solr-data/            # Dados do Solr
```


## ⚙️ Configuração

### Arquivos de Configuração

- **local.cfg**: Configure as variáveis específicas do DSpace aqui

- **submission-forms.xml**: Customize os formulários de submissão

- **item-submission.xml**: Customize o fluxo de submissão de itens

### Sincronizar Configurações

Se precisar atualizar as configurações após modificações no container:

```bash
docker cp dspace:/dspace/config/. ~/Dspace/dspace-structure/dspace-config/
```

## 📊 Volumes

Os dados são persistidos nos seguintes diretórios:

- **logs/**: Logs dos containers (facilita debugging)
- **postgres-data/**: Banco de dados PostgreSQL
- **solr-data/**: Índices do Solr

## 🔧 PM2 (Opcional)

Se estiver usando PM2 para gerenciar processos, execute:

```bash
pm2 start ecosystem.config.js
pm2 save
pm2 startup
```

## 📝 Notas

- Certifique-se de que as portas necessárias estão disponíveis antes de iniciar
- Verifique os logs em `volumes/logs/` para troubleshooting
- Sempre execute `init-dirs.sh` antes do primeiro uso

## 💡 Troubleshooting

Se encontrar problemas:

1. Verifique se os diretórios foram criados: `ls -la volumes/`
2. Verifique os logs: `docker-compose logs`
3. Certifique-se de que as permissões estão corretas: `chmod +x init-dirs.sh`