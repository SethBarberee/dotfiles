if !exists('g:loaded_vim_which_key')
    finish
endif

let g:which_key_use_floating_win = 1
let g:which_key_timeout = 300
let g:which_key_fallback_to_native_key=1 " use native vim commands if key isn't used


let g:which_key_map = {}

let g:which_key_map.b = { 'name' : '+buffers'}
let g:which_key_map.b.l = ['ls', 'list-buffers']
let g:which_key_map.b.q = ['bd', 'quit-buffer']

let g:which_key_map.d = { 'name' : '+denite'}

let g:which_key_map.g = { 'name' : '+Git'}

call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :WhichKey ','<CR>
