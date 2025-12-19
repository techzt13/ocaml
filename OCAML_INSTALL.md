# OCaml Installation Guide - All Methods

You want to use OCaml! Here are all available methods to get it working:

## Method 1: Automated Installation Script (Try First)

```bash
chmod +x install-ocaml.sh
./install-ocaml.sh
```

This script tries 5 different installation methods in order:
1. Standard apt-get
2. OPAM (OCaml Package Manager)
3. Snap
4. Compile from source
5. Docker (if all else fails)

---

## Method 2: Docker (Most Reliable)

### Option A: Using docker-compose (Easiest)

```bash
docker-compose up --build
```

Or if you just want to build and run:

```bash
docker-compose up --build calculator
```

### Option B: Using docker directly

```bash
# Build the image
docker build -t ocaml-calculator .

# Run the calculator
docker run -it ocaml-calculator
```

### Option C: Use pre-built OCaml image with manual build

```bash
docker run -it -v $(pwd):/app -w /app ocaml/ocaml:ubuntu-22.04 bash
```

Then inside the container:
```bash
apt-get update
apt-get install -y dune
dune build
dune exec ./bin/main.exe
```

---

## Method 3: Manual Installation (Different OS)

### Ubuntu / Debian

```bash
sudo apt-get update
sudo apt-get install -y ocaml dune
cd /workspaces/ocaml
dune build
dune exec ./bin/main.exe
```

### macOS (Homebrew)

```bash
brew install ocaml dune
cd /workspaces/ocaml
dune build
dune exec ./bin/main.exe
```

### macOS (MacPorts)

```bash
sudo port install ocaml +universal
sudo port install dune
cd /workspaces/ocaml
dune build
dune exec ./bin/main.exe
```

### Windows (with WSL2)

```bash
# In WSL2 Ubuntu:
sudo apt-get update
sudo apt-get install -y ocaml dune
cd /workspaces/ocaml
dune build
dune exec ./bin/main.exe
```

### Using OPAM (Universal for any Linux)

```bash
# Install OPAM
bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"

# Initialize OPAM
opam init

# Install OCaml and Dune
opam install -y ocaml dune

# Evaluate OPAM environment
eval $(opam env)

# Build and run
cd /workspaces/ocaml
dune build
dune exec ./bin/main.exe
```

---

## Method 4: Online (No Installation Required)

Visit one of these online OCaml environments:

### Try OCaml Online
https://try.ocamlpro.com/

Copy-paste this into the editor:

```ocaml
(* Copy lib/calculator.ml content here *)
(* Copy bin/main.ml content here *)
```

### Replit OCaml
https://replit.com/ → Create new project → Select OCaml

Upload `lib/calculator.ml` and `bin/main.ml`, then run.

---

## Method 5: GitHub Codespaces

If you have access to GitHub Codespaces:

1. Open in Codespaces
2. Codespaces usually has OCaml pre-installed
3. Run:
   ```bash
   dune build
   dune exec ./bin/main.exe
   ```

---

## Troubleshooting

### "Command not found" for ocaml/dune

- Check installation: `which ocaml` and `which dune`
- If using OPAM, run: `eval $(opam env)`
- Restart your terminal/shell

### Permission denied on .sh scripts

```bash
chmod +x install-ocaml.sh
./install-ocaml.sh
```

### Docker build fails

```bash
docker build --no-cache -t ocaml-calculator .
```

### Port conflicts with docker-compose

```bash
docker-compose down
docker-compose up --build
```

---

## Quickest Path (Recommended)

### If you have Docker installed:
```bash
docker build -t ocaml-calc . && docker run -it ocaml-calc
```

### If you have a Mac with Homebrew:
```bash
brew install ocaml dune && dune build && dune exec ./bin/main.exe
```

### If you have Linux with apt:
```bash
sudo apt-get update && sudo apt-get install -y ocaml dune && dune build && dune exec ./bin/main.exe
```

### If nothing else works:
```bash
./install-ocaml.sh
```

---

## Project Files for Reference

- **lib/calculator.ml** - Core calculator logic
- **lib/calculator.mli** - Module interface
- **bin/main.ml** - Interactive interface
- **dune-project** - Project config
- **lib/dune** - Library build config
- **bin/dune** - Binary build config
- **Dockerfile** - Docker image definition
- **docker-compose.yml** - Docker Compose config
- **install-ocaml.sh** - Automated installer

---

## Need Help?

If you're still having issues:

1. Check your OS and try the specific method for your OS
2. Try the Docker method - it works on any system with Docker
3. Try an online OCaml environment (links above)
4. Check the SETUP.md file for additional context
