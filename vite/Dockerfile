# --- Base Stage (共通設定) ---
FROM node:24-slim AS base

WORKDIR /app

# パッケージ定義をコピー
COPY package.json yarn.lock ./

RUN corepack enable

# Yarnのパス設定
ENV PATH=/node_modules/.bin:$PATH

# --- Dev Stage (開発用) ---
FROM base AS dev

# 依存関係をインストール (devDependencies含む)
RUN yarn install --modules-folder=/node_modules

# 開発用ポート
EXPOSE 4000

# 開発サーバー起動 (ホスト0.0.0.0で待ち受け)
CMD ["yarn", "dev", "--host", "0.0.0.0"]

# --- Builder Stage (ビルド用) ---
FROM base AS builder

# 依存関係をインストール
RUN yarn install --modules-folder=/node_modules

# ソースコード全体をコピー
COPY . .

# ビルド実行 (distディレクトリが生成される想定)
RUN yarn build

# --- Prod Stage (本番用) ---
FROM nginx:alpine AS prod

# Builderステージからビルド成果物(dist)をNginxの公開ディレクトリにコピー
COPY --from=builder /app/dist /usr/share/nginx/html

# Nginx設定ファイルをコピー
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]