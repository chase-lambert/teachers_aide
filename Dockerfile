FROM rustlang/rust:nightly

WORKDIR /app
COPY . .

RUN rustup target add wasm32-unknown-unknown --toolchain nightly
RUN cargo install cargo-leptos

ENV NODE_VERSION=19.6.0
RUN apt update && apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

RUN npm install

ENV LEPTOS_TAILWIND_VERSION="v3.4.3"
RUN cargo leptos build --release

RUN cp target/release/teachers_aide target/

ENV LEPTOS_OUTPUT_NAME="teachers_aide"
ENV LEPTOS_SITE_ROOT="site"
ENV LEPTOS_SITE_PKG_DIR="pkg"
ENV LEPTOS_SITE_ADDR="0.0.0.0:3000"
ENV LEPTOS_RELOAD_PORT="3001"

EXPOSE 3000:3000

ENTRYPOINT ["./target/teachers_aide"]

