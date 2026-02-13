# Janus 部署指南

Janus **不是**开箱即用的，需要手动构建。部署 Janus 需要有一定的运维经验。

## 环境需求

- Node.js >= 22.12
- Blessing Skin Server >= 6
  - 需要安装 [Yggdrasil Connect](https://github.com/bs-community/blessing-skin-plugins/blob/master/plugins/yggdrasil-connect) 插件，可在插件市场中下载
  - 该插件不需要也不可以与原版 Yggdrasil API 插件同时启用，但插件数据可以通用
  - 在安装完该插件后，请务必阅读该插件的 README，了解如何配置该插件

## 下载 Janus

直接 Clone 这个仓库到你喜欢的地方：

```bash
git clone https://github.com/bs-community/janus.git
```

## 配置数据库

Janus 支持 **MySQL/MariaDB** 和 **PostgreSQL** 两种数据库。

### 选择数据库类型

在 `.env` 文件中设置 `DB_TYPE`：

```env
DB_TYPE=mysql       # 使用 MySQL/MariaDB
# 或
DB_TYPE=postgresql  # 使用 PostgreSQL
```

### 设置数据表前缀

1. 运行数据库设置脚本：

```bash
npm run db:setup
```

这会根据 `DB_TYPE` 自动复制对应的 schema 文件。

2. 查看你的 Blessing Skin Server 的 `.env` 文件中的 `DB_PREFIX` 配置项。

3. 如有设置数据表前缀，请编辑 `prisma/schema.prisma` 文件，在每一个 Model 的 `@@map()` 中添加前缀：

```prisma
model AuthorizationCode {
    // ...

    @@map("yggc_authorization_codes")
    // 如果你的数据表前缀是 bs_：
    // @@map("bs_yggc_authorization_codes")
}
```

如果没有配置数据表前缀，则无需操作。

## 安装依赖

```bash
npm install
```

## 配置环境变量

将 `.env.example` 复制为 `.env`，然后修改以下配置项：

| 配置项                   | 说明                                                          |
| ------------------------ | ------------------------------------------------------------- |
| `DB_TYPE`                | 数据库类型：`mysql` 或 `postgresql`                           |
| `DB_HOST`                | 数据库 IP                                                     |
| `DB_PORT`                | 数据库端口                                                    |
| `DB_USERNAME`            | 数据库用户名                                                  |
| `DB_PASSWORD`            | 数据库密码                                                    |
| `DB_NAME`                | 数据库名称                                                    |
| `ISSUER`                 | OpenID 提供者标识符，必须以 `https://` 开头（localhost 除外） |
| `BS_SITE_URL`            | Blessing Skin Server 实例的站点地址                           |
| `SHARED_CLIENT_ID`       | 公用应用的应用 ID（可选）                                     |
| `TOKEN_EXPIRES_IN_1`     | Access Token 和 ID Token 的过期时间（秒）                     |
| `TOKEN_EXPIRES_IN_2`     | Refresh Token 的过期时间（秒）                                |
| `DEVICE_CODE_EXPIRES_IN` | 设备代码的过期时间（秒）                                      |
| `GRANT_EXPIRES_IN`       | 单次授权的过期时间（秒）                                      |

### 数据库连接字符串

如果不使用 `DB_HOST` 等单独配置，可以直接设置 `DB_CONNECTION_STRING`：

```env
# MySQL
DB_CONNECTION_STRING="mysql://user:password@host:port/database"

# PostgreSQL
DB_CONNECTION_STRING="postgresql://user:password@host:port/database"
```

## 执行数据库迁移

**在执行这步操作之前，请务必备份你的数据库。**

```bash
npx prisma migrate resolve --applied 0_init
npx prisma migrate deploy
```

## 生成 ORM 客户端

```bash
npm run db:generate
# 或
npx prisma generate
```

## 构建 Janus

```bash
npm run build
```

构建产物将生成在 `dist` 目录下。

## 复制令牌签名密钥

将 Blessing Skin Server 根目录下的 `storage/oauth-private.key` 复制到 Janus 根目录下。

如果私钥是 PKCS#1 格式（以 `-----BEGIN RSA PRIVATE KEY-----` 开头），需要先转换为 PKCS#8 格式：

```bash
openssl pkcs8 -topk8 -inform PEM -outform PEM -in oauth-private.key -out oauth-private-pkcs8.key -nocrypt
mv oauth-private-pkcs8.key oauth-private.key
```

## 启动 Janus

```bash
node dist/main.js
```

建议使用 PM2 等进程管理器：

```bash
pm2 start dist/main.js
```

## 配置反向代理

不建议直接将 Janus 暴露在公网下。推荐使用 Nginx 作为反向代理：

```nginx
server {
    listen 443 ssl;
    server_name your.issuer.com;
    ssl_certificate /path/to/your/certificate.crt;
    ssl_certificate_key /path/to/your/private.key;

    location / {
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_redirect off;

        proxy_pass http://localhost:3000;
    }
}
```

## 快捷命令

| 命令                  | 说明                                  |
| --------------------- | ------------------------------------- |
| `npm run db:setup`    | 根据 DB_TYPE 设置数据库 schema 和迁移 |
| `npm run db:generate` | 生成 Prisma 客户端                    |
| `npm run db:migrate`  | 执行数据库迁移                        |
| `npm run db:studio`   | 启动 Prisma Studio                    |
| `npm run build`       | 构建 Janus                            |
| `npm run start:prod`  | 生产模式运行                          |
