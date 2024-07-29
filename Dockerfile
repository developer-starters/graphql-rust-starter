FROM rust AS builder
WORKDIR /opt/app

RUN apt-get update -qq && apt-get install -yqq musl-tools
COPY src/ src/
COPY Cargo.toml .
COPY Cargo.lock .
RUN rustup target add x86_64-unknown-linux-musl 
RUN cargo build --target x86_64-unknown-linux-musl --release

FROM alpine

COPY --from=builder /opt/app/target/x86_64-unknown-linux-musl/release/graphql-rust-starter /usr/local/bin

ENTRYPOINT ["/usr/local/bin/graphql-rust-starter"]
