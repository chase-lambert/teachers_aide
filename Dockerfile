FROM rustlang/rust:nightly

WORKDIR /app

RUN cargo install cargo-leptos
RUN rustup target add wasm32-unknown-unknown

COPY Cargo.toml Cargo.lock ./

COPY src ./src
COPY public ./public

RUN cargo leptos build --release

EXPOSE 10000

CMD ["cp", "target/release/teachers_aide", "target/"]
CMD ["./target/teachers_aide"]

