FROM rustlang/rust:nightly

WORKDIR /app

RUN rustup target add wasm32-unknown-unknown --toolchain nightly
RUN cargo install cargo-leptos
RUN npm install

RUN cargo leptos build --release

ENV LEPTOS_OUTPUT_NAME=teachers_aide
ENV LEPTOS_SITE_ROOT=site
ENV LEPTOS_SITE_PKG_DIR=pkg
ENV LEPTOS_SITE_ADDR="0.0.0.0:3000"
ENV LEPTOS_RELOAD_PORT=3001
ENV LEPTOS_TAILWIND_VERSION="v3.4.3"

EXPOSE 3000:3000

CMD ["cp", "app/target/release/teachers_aide", "app/target/"]
CMD ["./app/target/teachers_aide"]
