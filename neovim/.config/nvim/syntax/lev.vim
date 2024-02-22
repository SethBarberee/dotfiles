" Syntax file for V93K .lev files
" Language: V93K Levels
" Created by Seth Barberee
" Date: 05/03/2023

if exists("b:current_syntax")
  finish
endif

syn keyword levTodo contained TODO FIXME XXX NOTE
syn match levComment "#.*$" contains=levTodo

syn region levString start='"' end='"' contained
syn region levDesc start='"' end='"'
syn region levPins start='(' end=')'

" Regular int like number with - + or nothing in front
syn match levNumber '\d\+' contained
syn match levNumber '[-+]\d\+' contained

" Floating point number with decimal no E or e (+,-)
syn match levFloat '\d\+\.\d*' contained
syn match levFloat '[-+]\d\+\.\d*' contained

" keywords to configure DPS and PS1600
syn keyword levKeyword DPSPINS EQNSET SPECS PINS EQSP SPECSET EQNSET NOOP PSLV PSLR PSFI DRLV CLMP LSUX LEVELSET RCLV EQUATIONS TERM

syn keyword levConfig vil vih vol voh vt iol ioh vout ilimit offcurr vout_frc_rng iout_clamp_rng t_ms nextgroup=levEqual skipwhite

syn match levIdentifier '[A-za-z]\+' contained

" float is before Number to highlight them first
syn match levEqual '=' nextgroup=levFloat,levNumber,levIdentifier skipwhite

"syn match levSettings '\w+'

let b:current_syntax = "lev"

hi def link levKeyword Keyword
hi def link levComment Comment
hi def link levTodo Todo
hi def link levString String
hi def link levDesc String
hi def link levNumber Number
hi def link levFloat Number
hi def link levConfig Identifier
hi def link levPins Identifier
hi def link levIdentifier Identifier
