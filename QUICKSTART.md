# 🎯 OCaml Calculator - WORKING VERSION

## ✅ Quick Start (3 Steps)

### Step 1: Make the script executable
```bash
chmod +x run.sh
```

### Step 2: Run the build and execute
```bash
./run.sh
```

### Step 3: Use the calculator!
```
Enter expression: 2 + 3 * 4
Result: 14
```

## 🚀 Or Build Directly

If you prefer to build manually:

```bash
mkdir -p _build
ocamlopt -I lib -I bin -o _build/calculator lib/calculator.ml bin/main.ml
./_build/calculator
```

## 📋 What's Included

- ✅ **lib/calculator.ml** - Complete calculator engine
- ✅ **bin/main.ml** - Interactive interface
- ✅ **run.sh** - One-command build and run
- ✅ **OCaml 4.14.1** - Already installed!

## 🧮 Features

- All basic operators: `+`, `-`, `*`, `/`, `%`, `^`
- Correct operator precedence
- Parentheses support
- Error handling
- Interactive REPL

## 📝 Example Calculations

```
2 + 3 * 4               → 14
(2 + 3) * 4             → 20
2 ^ 10                  → 1024
100 / 4                 → 25
17 % 5                  → 2
(5 + 3) * (10 - 4)      → 48
```

## ✨ That's It!

Your OCaml calculator is ready. Just run:

```bash
chmod +x run.sh && ./run.sh
```

Type `quit` to exit.
