; highlights.scm

; TODO: can this be under one thing/name?
(text name: (IDENT) @constructor)
(mart name: (IDENT) @constructor)
(movement name: (IDENT) @constructor)
(script name: (IDENT) @constructor)

; const highlighting
(const (IDENT) @constant)
(const (TOKEN_P_PLUS) @operator)

; movement highlighting
(movement_value (TOKEN_P_ASTER) @operator)
(movement_values (TOKEN_P_ASTER) @operator)

; poryswitch highlighting

(poryswitch_case case: (IDENT) @property)
; (poryswitch switch: (IDENT) @number)



(TOKEN_BI_FORMAT) @function.builtin

(TOKEN_KW_BREAK) @keyword
(TOKEN_KW_CASE) @keyword
(TOKEN_KW_CONST) @keyword
(TOKEN_KW_CONTINUE) @keyword
(TOKEN_KW_DEFAULT) @keyword
(TOKEN_KW_DO) @keyword
(TOKEN_KW_ELIF) @keyword
(TOKEN_KW_ELSE) @keyword
(TOKEN_KW_END) @keyword
(TOKEN_KW_IF) @keyword
(TOKEN_KW_LOCAL) @keyword
(TOKEN_KW_GLOBAL) @keyword
(TOKEN_KW_RETURN) @keyword
(TOKEN_KW_SWITCH) @keyword
(TOKEN_KW_WHILE) @keyword

(TOKEN_KW_PORYSWITCH) @keyword

(TOKEN_KW_MART) @keyword
(TOKEN_KW_MOVEMENT) @keyword
(TOKEN_KW_RAW) @keyword
(TOKEN_KW_SCRIPT) @keyword
(TOKEN_KW_TEXT) @keyword

(HASH_COMMENT) @comment
(SLASH_COMMENT) @comment

(RAW_LIT) @string.special
(STRING_LIT) @string
(STRING_INTER_START) @string
(STRING_INTER_MID) @string
(STRING_INTER_END) @string

(INT_LIT) @number
(HEX_LIT) @number
(BIN_LIT) @number

(MOVEMENT_LIT) @function.builtin
(SCRIPT_0_LIT) @function.builtin
(SCRIPT_FN_LIT) @function.builtin

(IDENT) @variable
