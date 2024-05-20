FROM rustlang/rust:nightly as builder

WORKDIR /work

COPY . .

RUN rustup target add wasm32-unknown-unknown --toolchain nightly
RUN cargo install cargo-leptos

ENV NODE_VERSION=19.6.0
RUN apt install -y curl 
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

RUN npm install

CMD /bin/bash


FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y extra-runtime-dependencies && rm -rf /var/lib/apt/lists/*

WORKDIR /work

COPY . .

RUN mkdir -p target/site

RUN cargo leptos build --release

from scratch as app

ENV LEPTOS_OUTPUT_NAME=teachers_aide
ENV LEPTOS_SITE_ROOT=site
ENV LEPTOS_SITE_PKG_DIR=pkg
ENV LEPTOS_SITE_ADDR="0.0.0.0:3000"
ENV LEPTOS_RELOAD_PORT=3001
ENV LEPTOS_TAILWIND_VERSION="v3.4.3"

USER 10001

WORKDIR /app

COPY --chown=10001:10001 --from=builder /work/target/site/ ./site/
COPY --chown=10001:10001 --from=builder /work/target/release/teachers_aide .

EXPOSE 3000:3000

ENTRYPOINT [ "/app/teachers_aide" ]
