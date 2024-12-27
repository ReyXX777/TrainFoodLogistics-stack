# Use the official Elixir image as the base image
FROM elixir:1.12-alpine

# Install build tools and dependencies
RUN apk add --no-cache \
    build-base \
    git \
    nodejs \
    npm \
    postgresql-client \
    bash \
    inotify-tools

# Set environment variables
ENV MIX_ENV=prod \
    LANG=C.UTF-8

# Set the working directory in the container
WORKDIR /app

# Install Hex and Rebar (build tools for Elixir projects)
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy the mix files and install dependencies
COPY mix.exs mix.lock ./
COPY config ./config
RUN mix deps.get --only prod && \
    mix deps.compile

# Install Node.js dependencies for asset compilation
COPY assets/package.json assets/package-lock.json ./assets/
RUN npm --prefix ./assets install && \
    npm --prefix ./assets run deploy

# Compile the application
COPY . .
RUN mix compile

# Prepare the release
RUN mix release

# Final stage for the runtime container
FROM alpine:latest

# Install runtime dependencies
RUN apk add --no-cache \
    libstdc++ \
    openssl \
    ncurses \
    postgresql-client \
    bash

# Set environment variables
ENV MIX_ENV=prod \
    REPLACE_OS_VARS=true \
    LANG=C.UTF-8

# Set the working directory
WORKDIR /app

# Copy the release from the build stage
COPY --from=0 /app/_build/prod/rel/train_food_delivery ./

# Set default entrypoint
CMD ["bin/train_food_delivery", "start"]
