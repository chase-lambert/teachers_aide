FROM rustlang/rust:nightly as builder
WORKDIR /app

RUN cargo install cargo-leptos

COPY Cargo.toml Cargo.lock ./

COPY src ./src
COPY public ./public

RUN rustup target add wasm32-unknown-unknown
RUN cargo leptos build --release

FROM debian:buster-slim
WORKDIR /app

COPY --from=builder /app/target/release/teachers_aide /app/target/
COPY --from=builder /app/target/site /app/target/site

EXPOSE 10000

# Run the binary
CMD ["cp", "target/release/teachers_aide", "target/"]
CMD ["./target/teachers_aide"]

