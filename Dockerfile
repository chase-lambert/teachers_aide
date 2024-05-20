FROM rustlang/rust:nightly

RUN apk update && \
    apk add --no-cache bash binaryen gcc git g++ libc-dev make npm openssl-dev protobuf-dev protoc

ENV OPENSSL_DIR=/usr

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
ENV LEPTOS_TAILIND_VERSION="v3.4.3"

CMD ["cp", "app/target/release/teachers_aide", "target/"]
CMD ["./app/target/teachers_aide"]

EXPOSE 3000:3000

ENTRYPOINT [ "/app/teachers_aide" ]
