if !exists(':Neomake')
    finish
endif

" Neomake plugin settings

function! PluggedIn()
  return filereadable('/sys/class/power_supply/AC/online')
endfunction

if PluggedIn()
    " Run this line when on AC
    call neomake#configure#automake('w')
else
    " Run this line when on battery
    call neomake#configure#automake('nw', 750)
endif
let g:neomake_open_list = 2 " automatically open neomake list


let g:neomake_cpp_enabled_makers = ['clang']

let g:neomake_vim_enabled_makers = ['vint']
