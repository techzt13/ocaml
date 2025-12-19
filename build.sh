#!/bin/bash

# Simple build script for OCaml calculator
# This script compiles the calculator using OCaml's native compiler

set -e

OUTDIR="_build"
mkdir -p "$OUTDIR"

echo "Compiling OCaml calculator..."

# Try native compilation first, fall back to bytecode
if command -v ocamlopt &> /dev/null; then
    echo "Using ocamlopt (native compiler)..."
    ocamlopt -I lib -I bin -o "$OUTDIR/calculator" lib/calculator.ml bin/main.ml
elif command -v ocamlc &> /dev/null; then
    echo "Using ocamlc (bytecode compiler)..."
    ocamlc -I lib -I bin -o "$OUTDIR/calculator.byte" lib/calculator.ml bin/main.ml
else
    echo "Error: OCaml is not installed."
    echo "Please install OCaml first:"
    echo "  Ubuntu/Debian: apt-get install -y ocaml"
    echo "  macOS: brew install ocaml"
    exit 1
fi

echo "✓ Build successful!"
echo ""
echo "Run the calculator with:"
if [ -f "$OUTDIR/calculator" ]; then
    echo "  ./$OUTDIR/calculator"
else
    echo "  ocaml ./$OUTDIR/calculator.byte"
fi
