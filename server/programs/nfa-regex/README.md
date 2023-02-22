# NFA-Regex

### Goal
All regular expressions can be converted to a non-deterministic finite automata (NFA). The
goal is of this project is to take in some regular expression and generate a NFA to run
strings on. Running a string on the NFA will leave it in either an accept or reject state, then
we may determine whether the string belongs to the language specified by the regular expression
or not. 

NFA's can have an exponential running time due its parallel executions, which is makes in order to search for accepting strings along all alternative pathways. I'm looking into options for making the NFA exectuion fast. 

### Grammar
```
regex: union;
union: concat (UNION concat)*;
concat: star (CONCAT star)*;
star: paren (STAR)*;
paren: leaf | '('union ')';
leaf: (LETTER | EPSILON | EMPTY_SET);

UNION = 'U';
CONCAT = '&';
STAR = '*';
LETTER = [a-zA-Z];
EPSILON = '\e';
EMPTY_SET = '\0';
```
### Operator Precedence
```
0. parentheses '(' ')'
1. kleen star '*'
2. concatenation '&'
3. union 'U'
```

### State of Progress

- Grammar and tokenization
- Recursive Descent parser to recognize valid regular expressions
- Respect operator precedence. 
- Parse Tree generation 

### Todo
- Automatically reduce Parse tree into AST (currently ~70% redundant nodes due to the
  grammar and parsing strategy)  
- Generate NFA by walking the AST
- use threads to execute strings on NFA
- set up command line interface to be user friendly, intuitive and with more options 
