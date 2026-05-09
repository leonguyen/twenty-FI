#!/usr/bin/env bash
set -e

echo "Running migrations..."
yarn database:migrate:prod || true

echo "Starting Twenty..."
yarn start:prod