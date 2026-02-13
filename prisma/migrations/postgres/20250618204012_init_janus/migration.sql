-- CreateTable
CREATE TABLE "yggc_authorization_codes" (
    "id" VARCHAR(255) NOT NULL,
    "payload" JSONB NOT NULL,
    "uid" VARCHAR(255) NULL,
    "consumed" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "yggc_authorization_codes_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "yggc_authorization_codes_id_key" ON "yggc_authorization_codes"("id");
CREATE UNIQUE INDEX "yggc_authorization_codes_uid_key" ON "yggc_authorization_codes"("uid");

-- CreateTable
CREATE TABLE "yggc_device_codes" (
    "id" VARCHAR(255) NOT NULL,
    "payload" JSONB NOT NULL,
    "userCode" VARCHAR(191) NULL,
    "uid" VARCHAR(255) NULL,
    "consumed" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "yggc_device_codes_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "yggc_device_codes_id_key" ON "yggc_device_codes"("id");
CREATE UNIQUE INDEX "yggc_device_codes_uid_key" ON "yggc_device_codes"("uid");

-- CreateTable
CREATE TABLE "yggc_refresh_tokens" (
    "id" VARCHAR(255) NOT NULL,
    "payload" JSONB NOT NULL,
    "uid" VARCHAR(255) NULL,
    "consumed" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "yggc_refresh_tokens_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "yggc_refresh_tokens_id_key" ON "yggc_refresh_tokens"("id");
CREATE UNIQUE INDEX "yggc_refresh_tokens_uid_key" ON "yggc_refresh_tokens"("uid");

-- CreateTable
CREATE TABLE "yggc_grants" (
    "id" VARCHAR(255) NOT NULL,
    "payload" JSONB NOT NULL,
    "uid" VARCHAR(255) NULL,
    "created_at" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "yggc_grants_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "yggc_grants_id_key" ON "yggc_grants"("id");
CREATE UNIQUE INDEX "yggc_grants_uid_key" ON "yggc_grants"("uid");

-- CreateTable
CREATE TABLE "yggc_interactions" (
    "id" VARCHAR(255) NOT NULL,
    "payload" JSONB NOT NULL,
    "uid" VARCHAR(255) NULL,
    "created_at" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "yggc_interactions_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "yggc_interactions_id_key" ON "yggc_interactions"("id");
CREATE UNIQUE INDEX "yggc_interactions_uid_key" ON "yggc_interactions"("uid");

-- CreateTable
CREATE TABLE "yggc_sessions" (
    "id" VARCHAR(255) NOT NULL,
    "payload" JSONB NOT NULL,
    "uid" VARCHAR(255) NULL,
    "created_at" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "yggc_sessions_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "yggc_sessions_id_key" ON "yggc_sessions"("id");
CREATE UNIQUE INDEX "yggc_sessions_uid_key" ON "yggc_sessions"("uid");
