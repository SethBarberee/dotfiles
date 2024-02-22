" Syntax file for V93K .license files
" Created by Seth Barberee
" Date: 05/03/2023

if exists("b:current_syntax")
  finish
endif

syn keyword licenseTodo contained TODO FIXME XXX NOTE
syn match licenseComment "#.*$" contains=licenseTodo

syn region licenseString start='"' end='"' contained

" Regular int like number with - + or nothing in front
syn match licenseNumber '\d\+' contained display
syn match licenseNumber '[-+]\d\+' contained display

" Floating point number with decimal no E or e (+,-)
syn match licenseNumber '\d\+\.\d*' contained display
syn match licenseNumber '[-+]\d\+\.\d*' contained display

" Floating point like number with E and no decimal point (+,-)
syn match licenseNumber '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+' contained display
syn match licenseNumber '\d[[:digit:]]*[eE][\-+]\=\d\+' contained display

" Floating point like number with E and decimal point (+,-)
syn match licenseNumber '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+' contained display
syn match licenseNumber '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+' contained display

syn match licenseEquals '=' skipwhite nextgroup=licenseHW,licenseMem,licenseNumber,licenseSpeed,licenseString

syn match licenseMem '\d\+M'
syn match licenseSpeed '\d\+[Mm]bps'
syn match licenseSpeed '\d\+[Mm]sps'
syn match licenseSpeed 'max-rate'

syn match licenseHW 'PS1600'
syn match licenseHW 'PS9G'
syn match licenseHW 'MCE'
syn match licenseHW 'LPN'
syn match licenseHW 'DCS-DPS128H[CV]'
syn match licenseHW 'DCS-UHC4'
syn match licenseHW 'DCS-UHC4T'
syn match licenseHW 'DCS-DPS32'
syn match licenseHW 'DCS-AVI64'
syn match licenseHW 'DCS-FVI16'
syn match licenseHW 'DPS64'
syn match licenseHW 'SRCE'
syn match licenseHW 'MESE'
syn match licenseHW 'MSDPS'
syn match licenseHW 'HCDPS'
syn match licenseHW 'RF[IF]'
syn match licenseHW 'PureClock'
syn match licenseHW 'WSRF'
syn match licenseHW 'WSRF-8'
syn match licenseHW 'WSMX'
syn match licenseHW 'WSWB'

syn keyword licenseType type mtype speed core HW slot smem diff tmu loopback config channels pogoblocks subtype hcu digio nextgroup=licenseEquals skipwhite

syn keyword licenseKeyword IOCHANNEL GLOBAL ANALOGBOARD BOARDCONF DPS DMM OPENNESSBOARD POGOCABLING

let b:current_syntax = "license"

hi def link licenseKeyword Keyword
hi def link licenseType Keyword
hi def link licenseComment Comment
hi def link licenseTodo Todo
hi def link licenseString String
hi def link licenseNumber Number
hi def link licenseSpeed Number
hi def link licenseMem Number
hi def link licenseHW Special
