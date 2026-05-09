FROM node:20-bookworm-slim AS base

RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    git \
    openssl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

ENV NODE_OPTIONS="--max-old-space-size=4096"

RUN corepack enable

RUN yarn install --immutable

RUN yarn nx run twenty-server:build
RUN yarn nx run twenty-front:build

EXPOSE 3000

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]