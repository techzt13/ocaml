.PHONY: build run clean test help

help:
	@echo "OCaml Calculator - Available targets:"
	@echo "  make build    - Build the calculator"
	@echo "  make run      - Run the interactive calculator"
	@echo "  make clean    - Clean build artifacts"
	@echo "  make test     - Run tests"

build:
	@echo "Building OCaml calculator..."
	mkdir -p _build
	ocamlc -o _build/calculator.byte lib/calculator.ml bin/main.ml 2>/dev/null || \
	ocamlopt -o _build/calculator lib/calculator.ml bin/main.ml || \
	(echo "Error: OCaml is not installed. Please install OCaml and try again." && exit 1)
	@echo "Build successful! Run with: make run"

run: build
	./_build/calculator

test:
	@echo "Testing calculator..."
	@ocaml -I +str -init tests/test.ml

clean:
	rm -rf _build
	find . -name "*.cmo" -o -name "*.cmx" -o -name "*.o" -o -name "*.cmi" | xargs rm -f

.DEFAULT_GOAL := help
