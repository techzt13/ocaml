#!/bin/bash
# Direct OCaml compilation without dune

set -e

echo "Building OCaml Calculator..."
mkdir -p _build

# Compile with ocamlopt (native code) or ocamlc (bytecode)
if command -v ocamlopt &> /dev/null; then
    echo "Using ocamlopt (native compiler)..."
    # First compile the interface
    ocamlc -c -I lib lib/calculator.mli
    # Then compile the implementation
    ocamlopt -I lib -c lib/calculator.ml
    # Then compile main
    ocamlopt -I lib -c bin/main.ml
    # Finally link everything
    ocamlopt -o _build/calculator lib/calculator.cmx bin/main.cmx
    echo "✓ Build successful!"
    echo ""
    echo "Run with: ./_build/calculator"
else
    echo "Using ocamlc (bytecode compiler)..."
    # First compile the interface
    ocamlc -c -I lib lib/calculator.mli
    # Then compile the implementation
    ocamlc -I lib -c lib/calculator.ml
    # Then compile main
    ocamlc -I lib -c bin/main.ml
    # Finally link everything
    ocamlc -o _build/calculator.byte lib/calculator.cmo bin/main.cmo
    echo "✓ Build successful!"
    echo ""
    echo "Run with: ocaml ./_build/calculator.byte"
fi
