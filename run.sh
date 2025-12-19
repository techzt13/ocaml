#!/bin/bash
# Simple build and run script

set -e

echo "=========================================="
echo "  OCaml Calculator - Build and Run"
echo "=========================================="
echo ""

# Create build directory
mkdir -p _build

# Compile the calculator
echo "[1/2] Compiling..."
# First compile the interface
ocamlc -c -I lib lib/calculator.mli
# Then compile the implementation
ocamlopt -I lib -c lib/calculator.ml
# Then compile main
ocamlopt -I lib -c bin/main.ml
# Finally link everything
ocamlopt -o _build/calculator lib/calculator.cmx bin/main.cmx

# Run the calculator
echo "[2/2] Running calculator..."
echo ""
./_build/calculator
