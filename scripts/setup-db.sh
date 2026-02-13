#!/bin/bash

set -e

DB_TYPE=${DB_TYPE:-mysql}
PRISMA_DIR="$(dirname "$0")/../prisma"

if [[ "$DB_TYPE" != "mysql" && "$DB_TYPE" != "postgresql" ]]; then
    echo "Error: DB_TYPE must be 'mysql' or 'postgresql'"
    exit 1
fi

echo "Setting up database for: $DB_TYPE"

cp "$PRISMA_DIR/schema.${DB_TYPE}.prisma.example" "$PRISMA_DIR/schema.prisma"
echo "✓ Copied schema.${DB_TYPE}.prisma.example to schema.prisma"

MIGRATION_NAME="20250618204012_init_janus"
TARGET_DIR="$PRISMA_DIR/migrations/$MIGRATION_NAME"
SOURCE_DIR="$PRISMA_DIR/migrations/${DB_TYPE}/$MIGRATION_NAME"

mkdir -p "$TARGET_DIR"
cp "$SOURCE_DIR/migration.sql" "$TARGET_DIR/migration.sql"
echo "✓ Copied ${DB_TYPE} migrations"

echo ""
echo "Database setup complete for $DB_TYPE!"
echo ""
echo "Next steps:"
echo "  1. Configure your .env file with database credentials"
echo "  2. Run: npx prisma generate"
echo "  3. Run: npx prisma migrate resolve --applied 0_init"
echo "  4. Run: npx prisma migrate deploy"
