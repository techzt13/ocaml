#!/bin/bash
# Quick install script for dev container

set -e

echo "Setting up OCaml Calculator in dev container..."
echo ""

# Update package lists
echo "1. Updating package manager..."
apt-get update > /dev/null 2>&1 || true

# Install OCaml
if ! command -v ocaml &> /dev/null; then
    echo "2. Installing OCaml..."
    apt-get install -y ocaml > /dev/null 2>&1 || true
    if ! command -v ocaml &> /dev/null; then
        echo "   ⚠ OCaml installation may have failed. Trying alternative method..."
        apt-get install -y ocaml-nox > /dev/null 2>&1 || true
    fi
else
    echo "2. OCaml already installed"
fi

# Install Dune
if ! command -v dune &> /dev/null; then
    echo "3. Installing Dune..."
    apt-get install -y dune > /dev/null 2>&1 || true
else
    echo "3. Dune already installed"
fi

# Verify installations
echo ""
echo "Verification:"
if command -v ocaml &> /dev/null; then
    echo "✓ OCaml: $(ocaml --version)"
else
    echo "✗ OCaml not found"
fi

if command -v dune &> /dev/null; then
    echo "✓ Dune: $(dune --version)"
else
    echo "! Dune not found (optional - can build with build.sh instead)"
fi

echo ""
echo "Setup complete! Build the calculator with one of:"
echo "  dune build && dune exec ./bin/main.exe"
echo "  ./build.sh"
echo "  make run"
