# Teacher's <strong><em>Ai</em></strong>de

## Running project

```bash
cargo leptos watch
```

## Compiling for Release

```bash
cargo leptos build --release
```

## Executing a Server on a Remote Machine Without the Toolchain

After running a `cargo leptos build --release` the minimum files needed are:

1. The server binary located in `target/release`
2. The `site` directory and all files within located in `target/site`

Copy these files to your remote server. The directory structure should be:

```text
teachers_aide
site/
```

Set the following environment variables (updating for your project as needed):

```text
LEPTOS_OUTPUT_NAME="teachers_aide"
LEPTOS_SITE_ROOT="site"
LEPTOS_SITE_PKG_DIR="pkg"
LEPTOS_SITE_ADDR="0.0.0.0:3000"
LEPTOS_RELOAD_PORT="3001"
LEPTOS_TAILWIND_VERSION="v3.4.3"
```

Finally, run the server binary.
