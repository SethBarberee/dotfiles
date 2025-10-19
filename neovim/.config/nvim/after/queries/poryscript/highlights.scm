; highlights.scm
; highlight.scm for poryscript

; Basic highlight groups
(comment) @comment
[("const") ("raw")] @modifier
[
 ("if") 
 ("elif")
 ("else")
 ("switch")
 ("case")
 ("default")
 ("poryswitch")
] @keyword.conditional

; This is for stuff in text like `ascii"hello"`
(text_directive) @keyword.directive

[("while") ("do")] @keyword.repeat

; Structure names
[
 ("script")
 ("mart")
 ("text")
 ("movement")
 ("mapscripts")
] @keyword.function

; Match the names
(
 [
  (script)
  (mart)
  (text)
  (movement)
  (mapscripts)
 ] name: (identifier) @function
)

; Highlight constants
(const) @constant
(const
  const_name: (identifier) @constant)

; Scope as well
(scope_marker) @label

(identifier) @variable
(identifier) @constant
((identifier) @constant
 (#match? @constant "^[A-Z][A-Z\\d_0-9]*$")) ; Make uppercase different "type"

; Highlight functions and builtins
(function_call function_name: (identifier) @function)
(builtin_func) @function.builtin
(builtin_control_flow) @keyword.return
(label name: (identifier)) @label

; Basic types
(number) @number
(string) @string
(boolean) @boolean

[
  ("(")
  (")")
  ("{")
  ("}")
  ("[")
  ("]")
] @punctuation.bracket

; String related stuff
(interpolation
  "{" @punctuation.special
  "}" @punctuation.special) @embedded
(escape_sequence) @string.escape
(",") @punctuation.delimiter

; Operators and keywords
[(operator) (additives) (logical_operator)] @operator
(negate) @operator

; Assembly 68k stuff
((raw_inside) @injection.content
  (#set! injection.language "asm"))

; Set poryswitch underscore
(default) @variable.parameter.builtin

