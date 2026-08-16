#!/bin/bash

# Script para criar as pastas que não podem ser rastreadas vazias no git
# Isso permite que as pastas sejam criadas automaticamente mas continuem vazias
mkdir -p volumes
mkdir -p volumes/logs
mkdir -p volumes/postgres-data
mkdir -p volumes/solr-data

# Criar arquivo de dados se não existir
mkdir -p data

echo "✓ Pastas inicializadas com sucesso!"
echo "  - volumes/logs"
echo "  - volumes/postgres-data"
echo "  - volumes/solr-data"
echo "  - data"
