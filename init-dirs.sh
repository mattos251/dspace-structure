#!/bin/bash

# Diretórios persistentes usados pelos bind mounts definidos no .env.
mkdir -p assetstore
mkdir -p volumes/postgres-data
mkdir -p volumes/solr-data
mkdir -p data

echo "Pastas inicializadas com sucesso:"
echo "  - assetstore"
echo "  - volumes/postgres-data"
echo "  - volumes/solr-data"
echo "  - data"
