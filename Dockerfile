FROM rust:latest as builder

RUN USER=root cargo new --bin rust-echo
RUN mkdir /home/rust
WORKDIR /home/rust/

RUN apt-get update \
    && apt-get install -y zstd

# Avoid having to install/build all dependencies by copying
# the Cargo files and making a dummy src/main.rs
COPY Cargo.toml .
RUN mkdir src
RUN echo "fn main() {}" > src/main.rs
RUN cargo test
RUN cargo build --release

COPY . .
RUN touch src/main.rs

RUN cargo test
RUN cargo build --release

# Size optimization
RUN strip target/release/rust-echo

# our final base
FROM debian:stable-slim

ARG APP=/usr/src/app
WORKDIR ${APP}

ENV TZ=Etc/UTC \
    APP_USER=appuser

RUN groupadd $APP_USER \
    && useradd -g $APP_USER $APP_USER \
    && mkdir -p ${APP}

COPY --from=builder /home/rust/target/release/rust-echo ${APP}/rust-echo

# set the startup command to run your binary
CMD ["./rust-echo"]