# GraphQL Autocomplete Setup for Neovim

This guide configures GraphQL LSP autocomplete in Neovim for `.graphql` files and embedded GraphQL in TypeScript/JavaScript files.

## Prerequisites

- Neovim with LazyVim
- Node.js and npm installed
- A GraphQL API endpoint

## Installation Steps

### 1. Install GraphQL Language Server

```bash
npm install -g graphql-language-service-cli
```

This provides the `graphql-lsp` binary that Neovim will use.

### 2. Configure Mason (Neovim)

Edit `~/.config/nvim/lua/plugins/mason.lua`:

```lua
return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "graphql-language-service-cli",
    },
  },
}
```

### 3. Configure LSP (Neovim)

Create or edit `~/.config/nvim/lua/plugins/lsp.lua`:

```lua
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      graphql = {
        filetypes = { "graphql", "typescriptreact", "javascriptreact" },
      },
    },
  },
}
```

### 4. Create GraphQL Config File

In your project root, create `.graphqlrc.yml`:

```yaml
schema: ./generated/schema.graphql
documents: src/**/*.graphql
```

### 5. Create Schema Update Script

Create `scripts/update-graphql-schema.sh`:

```bash
#!/bin/bash

set -e

cd "$(dirname "$0")/.."

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

SCHEMA_URL="${NEXT_PUBLIC_TEST_API_URL:-https://api.test.s-kaupat.dev}"

echo "Downloading GraphQL schema from $SCHEMA_URL..."

mkdir -p generated

npx get-graphql-schema "$SCHEMA_URL" \
  --header "x-client-name=skaupat-web" \
  --header "x-client-version=local-dev" \
  >generated/schema.graphql

sed -i.bak '/^[[:space:]]*┌/,/^[[:space:]]*└/d' generated/schema.graphql
rm -f generated/schema.graphql.bak

if [ ! -f .graphqlrc.yml ]; then
  echo "Creating .graphqlrc.yml..."
  cat > .graphqlrc.yml << EOF
schema: ./generated/schema.graphql
documents: src/**/*.graphql
EOF
fi

echo "GraphQL schema updated and cleaned"
```

Make it executable:

```bash
chmod +x scripts/update-graphql-schema.sh
```

### 6. Download Schema

Run the script to download your GraphQL schema:

```bash
./scripts/update-graphql-schema.sh
```

### 7. Add to .gitignore

Add the generated folder to `.gitignore`:

```
generated/
```

### 8. Restart Neovim

Close and reopen Neovim in your project directory.

## Verification

1. Open a `.graphql` file
2. Run `:LspInfo` in Neovim
3. Verify `graphql` LSP is attached
4. Start typing GraphQL queries - autocomplete should work

## Troubleshooting

### No autocomplete

- Check LSP is running: `:LspInfo`
- Check LSP logs: `tail -50 ~/.local/state/nvim/lsp.log`
- Verify schema file exists: `ls generated/schema.graphql`
- Ensure schema has no banner/header (should start with `schema {` or type definitions)

### Schema has banner

The script removes banners automatically. If you see errors about unexpected characters, manually check:

```bash
head -20 generated/schema.graphql
```

Should show GraphQL SDL, not ASCII art or HTML.

### Environment variable not loaded

Ensure `.env` file exists and contains:

```
NEXT_PUBLIC_TEST_API_URL=https://your-api-endpoint.com
```

## Script Explanation

- `set -e`: Exit on any error
- `${VAR:-default}`: Use environment variable or fallback to default
- `npx get-graphql-schema`: Downloads schema via introspection query
- `sed` command: Removes ASCII banner lines (like from Rover)
- Creates `.graphqlrc.yml` if missing

## Customization

### Different API endpoint

Set in `.env`:

```
NEXT_PUBLIC_TEST_API_URL=https://your-endpoint.com
```

Or pass directly:

```bash
NEXT_PUBLIC_TEST_API_URL=https://your-endpoint.com ./scripts/update-graphql-schema.sh
```

### Custom headers

Edit the script's `--header` flags:

```bash
npx get-graphql-schema "$SCHEMA_URL" \
  --header "Authorization=Bearer $TOKEN" \
  --header "x-custom-header=value" \
  >generated/schema.graphql
```

### Different schema location

Update both the script output path and `.graphqlrc.yml` schema path to match.
