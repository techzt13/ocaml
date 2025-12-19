#!/usr/bin/env python3
"""
OCaml Calculator - Python Implementation
A fully-featured calculator with proper operator precedence and parentheses support.
This Python version works when OCaml is not available in the environment.
"""

import re
from typing import List, Tuple, Union

class Token:
    def __init__(self, type: str, value: Union[float, str]):
        self.type = type
        self.value = value
    
    def __repr__(self):
        return f"Token({self.type}, {self.value})"

class Lexer:
    def __init__(self, expr: str):
        self.expr = expr
        self.pos = 0
    
    def tokenize(self) -> List[Token]:
        tokens = []
        while self.pos < len(self.expr):
            char = self.expr[self.pos]
            
            # Skip whitespace
            if char.isspace():
                self.pos += 1
                continue
            
            # Numbers (including floats and negatives)
            if char.isdigit() or (char == '.' and self.pos + 1 < len(self.expr) and self.expr[self.pos + 1].isdigit()):
                tokens.append(self._read_number())
            
            # Operators and parentheses
            elif char in '+-*/%^':
                tokens.append(Token('OP', char))
                self.pos += 1
            elif char == '(':
                tokens.append(Token('LPAREN', '('))
                self.pos += 1
            elif char == ')':
                tokens.append(Token('RPAREN', ')'))
                self.pos += 1
            else:
                raise ValueError(f"Unknown character: {char}")
        
        tokens.append(Token('EOF', None))
        return tokens
    
    def _read_number(self) -> Token:
        start = self.pos
        while self.pos < len(self.expr) and (self.expr[self.pos].isdigit() or self.expr[self.pos] == '.'):
            self.pos += 1
        
        num_str = self.expr[start:self.pos]
        return Token('NUMBER', float(num_str))

class Parser:
    def __init__(self, tokens: List[Token]):
        self.tokens = tokens
        self.pos = 0
    
    def parse(self):
        result = self.parse_expression(0)
        if self.current().type != 'EOF':
            raise ValueError("Unexpected tokens after expression")
        return result
    
    def current(self) -> Token:
        if self.pos < len(self.tokens):
            return self.tokens[self.pos]
        return Token('EOF', None)
    
    def advance(self):
        self.pos += 1
    
    def parse_expression(self, min_prec):
        left = self.parse_primary()
        return self.parse_binary_op(left, min_prec)
    
    def parse_primary(self):
        token = self.current()
        
        if token.type == 'NUMBER':
            self.advance()
            return ('num', token.value)
        
        elif token.type == 'LPAREN':
            self.advance()
            expr = self.parse_expression(0)
            if self.current().type != 'RPAREN':
                raise ValueError("Expected ')'")
            self.advance()
            return expr
        
        elif token.type == 'OP' and token.value == '-':
            # Unary minus
            self.advance()
            operand = self.parse_primary()
            return ('unary', '-', operand)
        
        elif token.type == 'OP' and token.value == '+':
            # Unary plus
            self.advance()
            return self.parse_primary()
        
        else:
            raise ValueError(f"Unexpected token: {token}")
    
    def parse_binary_op(self, left, min_prec):
        while True:
            token = self.current()
            
            if token.type != 'OP' or token.value not in '+-*/%^':
                break
            
            op = token.value
            prec = self.precedence(op)
            
            if prec < min_prec:
                break
            
            self.advance()
            
            # Right-associative for power
            if op == '^':
                right = self.parse_expression(prec)
            else:
                right = self.parse_expression(prec + 1)
            
            left = ('binop', op, left, right)
        
        return left
    
    @staticmethod
    def precedence(op: str) -> int:
        if op in '+-':
            return 1
        elif op in '*/%':
            return 2
        elif op == '^':
            return 3
        else:
            raise ValueError(f"Unknown operator: {op}")

class Evaluator:
    @staticmethod
    def evaluate(expr):
        if expr[0] == 'num':
            return expr[1]
        
        elif expr[0] == 'unary':
            op = expr[1]
            operand = Evaluator.evaluate(expr[2])
            if op == '-':
                return -operand
            elif op == '+':
                return operand
        
        elif expr[0] == 'binop':
            op = expr[1]
            left = Evaluator.evaluate(expr[2])
            right = Evaluator.evaluate(expr[3])
            
            if op == '+':
                return left + right
            elif op == '-':
                return left - right
            elif op == '*':
                return left * right
            elif op == '/':
                if right == 0:
                    raise ValueError("Division by zero")
                return left / right
            elif op == '%':
                if right == 0:
                    raise ValueError("Modulo by zero")
                return left % right
            elif op == '^':
                return left ** right
        
        raise ValueError(f"Unknown expression: {expr}")

def calculate(expression: str) -> float:
    """Parse and evaluate a mathematical expression"""
    lexer = Lexer(expression)
    tokens = lexer.tokenize()
    parser = Parser(tokens)
    ast = parser.parse()
    return Evaluator.evaluate(ast)

def print_menu():
    print("\n=== OCaml Calculator (Python Version) ===")
    print("Supported operators:")
    print("  + : Addition")
    print("  - : Subtraction")
    print("  * : Multiplication")
    print("  / : Division")
    print("  % : Modulo")
    print("  ^ : Power")
    print("  ( ) : Parentheses for grouping")
    print("Type 'quit' to exit\n")

def main():
    print_menu()
    
    while True:
        try:
            user_input = input("Enter expression: ").strip()
            
            if user_input.lower() == 'quit':
                print("Goodbye!")
                break
            
            if not user_input:
                continue
            
            result = calculate(user_input)
            # Format output nicely
            if result == int(result):
                print(f"Result: {int(result)}")
            else:
                print(f"Result: {result}")
        
        except ValueError as e:
            print(f"Error: {e}")
        except Exception as e:
            print(f"Error: Invalid expression")

if __name__ == "__main__":
    main()
