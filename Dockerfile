FROM rust:1.46.0 AS build

RUN cargo install diesel_cli --no-default-features --features postgres

FROM gleamlang/gleam:0.11.2

COPY --from=build /usr/local/cargo/bin/diesel /bin
RUN diesel --version

# NOTE the WORKDIR should not be the users home dir as the will copy container cookie into host machine
WORKDIR /opt/app
RUN mix local.hex --force && mix local.rebar --force
