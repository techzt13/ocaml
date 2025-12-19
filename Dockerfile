FROM ocaml/ocaml:ubuntu-22.04

# Install additional tools
RUN apt-get update && apt-get install -y \
    dune \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy calculator source
COPY . .

# Build the calculator
RUN dune build

# Set the entrypoint
ENTRYPOINT ["dune", "exec", "./bin/main.exe"]
