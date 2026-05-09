FROM node:20-bookworm-slim

RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    git \
    openssl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN corepack enable

COPY . .

ENV NODE_ENV=production
ENV PORT=3000
ENV NODE_OPTIONS=--max-old-space-size=4096
ENV YARN_ENABLE_IMMUTABLE_INSTALLS=false

RUN yarn install

RUN yarn nx run twenty-server:build
RUN yarn nx run twenty-front:build

EXPOSE 3000

CMD ["yarn", "start:prod"]