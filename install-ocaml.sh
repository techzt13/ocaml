#!/bin/bash
# Complete OCaml Installation Script
# Tries multiple installation methods

set -e

echo "=================================================="
echo "     OCaml Calculator - Complete Setup"
echo "=================================================="
echo ""

# Method 1: Try standard apt-get
echo "[1/5] Attempting standard package installation..."
if sudo apt-get update 2>/dev/null && sudo apt-get install -y ocaml dune 2>/dev/null; then
    echo "✓ Successfully installed via apt-get"
    goto verify
fi

# Method 2: Try opam
echo "[2/5] Attempting to install via OPAM (OCaml Package Manager)..."
if ! command -v opam &> /dev/null; then
    echo "  Installing OPAM..."
    if curl https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh -L 2>/dev/null | bash 2>/dev/null; then
        opam init -y 2>/dev/null
        eval $(opam env)
        opam install -y ocaml dune 2>/dev/null
        echo "✓ Successfully installed via OPAM"
        goto verify
    fi
fi

# Method 3: Try snap
echo "[3/5] Attempting to install via snap..."
if command -v snap &> /dev/null; then
    if sudo snap install ocaml --classic 2>/dev/null; then
        echo "✓ Successfully installed via snap"
        goto verify
    fi
fi

# Method 4: Try manual download and compile
echo "[4/5] Attempting manual compilation from source..."
if [ ! -d /tmp/ocaml-build ]; then
    mkdir -p /tmp/ocaml-build
    cd /tmp/ocaml-build
    
    # Try to download the latest stable OCaml
    if curl -L "https://github.com/ocaml/ocaml/releases/download/4.14.1/ocaml-4.14.1.tar.gz" -o ocaml.tar.gz 2>/dev/null; then
        tar xzf ocaml.tar.gz
        cd ocaml-*
        ./configure 2>/dev/null && make world.opt 2>/dev/null && sudo make install 2>/dev/null
        echo "✓ Successfully compiled and installed OCaml from source"
        goto verify
    fi
fi

# Method 5: Docker
echo "[5/5] All local methods failed. Suggesting Docker..."
echo ""
echo "Would you like to use Docker to run OCaml?"
echo "Run this command:"
echo ""
echo "  docker run -it -v \$(pwd):/app -w /app ocaml/ocaml:ubuntu-22.04"
echo ""
echo "Then inside the container:"
echo "  apt-get update && apt-get install -y dune"
echo "  dune build"
echo "  dune exec ./bin/main.exe"
echo ""
exit 0

: <<'label'
verify:
label

echo ""
echo "=================================================="
echo "              Verification"
echo "=================================================="
echo ""

# Verify OCaml
if command -v ocaml &> /dev/null; then
    echo "✓ OCaml version:"
    ocaml -version
else
    echo "✗ OCaml not found"
fi

# Verify Dune
if command -v dune &> /dev/null; then
    echo "✓ Dune version:"
    dune --version
else
    echo "! Dune not found (will try to install)"
fi

echo ""
echo "=================================================="
echo "              Building Calculator"
echo "=================================================="
echo ""

cd /workspaces/ocaml

# Try building
if dune build 2>/dev/null; then
    echo "✓ Build successful!"
    echo ""
    echo "Run the calculator with:"
    echo "  dune exec ./bin/main.exe"
else
    echo "Build may have issues. Trying alternative..."
    if dune clean && dune build; then
        echo "✓ Build successful after clean!"
        echo ""
        echo "Run the calculator with:"
        echo "  dune exec ./bin/main.exe"
    fi
fi
