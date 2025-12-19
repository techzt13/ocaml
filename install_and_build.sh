#!/bin/bash

# Install OCaml and Dune if not already installed
echo "Checking for OCaml installation..."

if ! command -v ocaml &> /dev/null; then
    echo "OCaml not found. Installing..."
    apt-get update
    apt-get install -y ocaml
fi

if ! command -v dune &> /dev/null; then
    echo "Dune not found. Installing..."
    apt-get install -y dune
fi

echo "Building calculator..."
dune build

echo "Build complete! Run with: dune exec ./bin/main.exe"
