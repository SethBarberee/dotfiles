" Syntax file for V93K .tim files
" Created by Seth Barberee
" Date: 05/03/2023

if exists("b:current_syntax")
  finish
endif

syn keyword timTodo contained TODO FIXME XXX NOTE
syn match timComment "#.*$" contains=timTodo

syn region timString start='"' end='"' contained
syn region timDesc start='"' end='"'
syn region timPins start='(' end=')'

" Regular int like number with - + or nothing in front
syn match timNumber '\d\+' contained display
syn match timNumber '[-+]\d\+' contained display

" Floating point number with decimal no E or e (+,-)
syn match timNumber '\d\+\.\d*' contained display
syn match timNumber '[-+]\d\+\.\d*' contained display

" Floating point like number with E and no decimal point (+,-)
syn match timNumber '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+' contained display
syn match timNumber '\d[[:digit:]]*[eE][\-+]\=\d\+' contained display

" Floating point like number with E and decimal point (+,-)
syn match timNumber '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+' contained display
syn match timNumber '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+' contained display

syn keyword timKeyword PINS WAVETBL TIMINGSET EQNSET SPECS PERIOD CHECK SPECSET SPECIFICATION SYNC NOOP SPST PCLK CLKR BWDS DCDT TSUX EQSP
syn keyword timPorts DEFINES PORT

" Get all pins within the parentheses
"syn match timPins '(.*)'


let b:current_syntax = "tim"

hi def link timKeyword Keyword
hi def link timComment Comment
hi def link timTodo Todo
hi def link timString String
hi def link timDesc String
hi def link timNumber Number
hi def link timPins Identifier 
hi def link timPorts Special
