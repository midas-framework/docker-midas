FROM rust:1.43.0 AS build

RUN cargo install diesel_cli --no-default-features --features postgres

FROM gleamlang/gleam

COPY --from=build /usr/local/cargo/bin/diesel /bin
RUN diesel --version

RUN mkdir -p /opt/app
WORKDIR /opt/app
