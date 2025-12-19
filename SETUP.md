# OCaml Calculator - Setup Guide

## Prerequisites

You need OCaml installed on your system. 

### Installation Instructions

#### Ubuntu/Debian
```bash
sudo apt-get update
sudo apt-get install -y ocaml
```

#### macOS (with Homebrew)
```bash
brew install ocaml
```

#### Using OPAM (Package Manager)
```bash
# Install OPAM
curl https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh -L | bash

# Install OCaml
opam init
opam install ocaml
```

## Verifying Installation

```bash
ocaml --version
```

You should see version 4.14 or later.

## Building the Calculator

### Option 1: Using the Build Script (Recommended)
```bash
chmod +x build.sh
./build.sh
```

### Option 2: Using Make
```bash
make build
```

### Option 3: Using Dune (if installed)
```bash
dune build
dune exec ./bin/main.exe
```

### Option 4: Manual Compilation
```bash
mkdir -p _build
ocamlopt -I lib -I bin -o _build/calculator lib/calculator.ml bin/main.ml
./_build/calculator
```

## Running the Calculator

### After Building with build.sh
```bash
./_build/calculator
```

### Using Make
```bash
make run
```

### Using Dune
```bash
dune exec ./bin/main.exe
```

## Troubleshooting

### Error: "ocaml: command not found"
**Solution**: OCaml is not installed. Follow the installation instructions above.

### Error: "dune: command not found"
**Solution**: Dune is optional. Use `build.sh` or `make build` instead.

### Compilation Errors
If you get compilation errors, try:
1. Delete the `_build` directory: `rm -rf _build`
2. Run the build command again: `./build.sh` or `make build`

## File Organization

- `lib/calculator.ml` - Main calculator logic
- `lib/calculator.mli` - Module interface
- `bin/main.ml` - Interactive interface
- `build.sh` - Simple build script
- `Makefile` - Build targets
- `dune-project`, `lib/dune`, `bin/dune` - Dune configuration

## Interactive Usage

```
=== OCaml Calculator ===
Supported operators:
  + : Addition
  - : Subtraction
  * : Multiplication
  / : Division
  % : Modulo
  ^ : Power
  ( ) : Parentheses for grouping
Type 'quit' to exit

Enter expression: 2 + 3 * 4
Result: 14
Enter expression: (2 + 3) * 4
Result: 20
Enter expression: quit
Goodbye!
```

## Next Steps

- Try various mathematical expressions
- Experiment with operator precedence
- Use parentheses for complex calculations
- Type 'quit' to exit the calculator
