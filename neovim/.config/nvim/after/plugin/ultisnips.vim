" Load guard the file just in case
if !exists(':UltiSnipsEdit')
    finish
endif

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.

let g:UltiSnipsSnippetsDir = g:vimpath . "/my_snippets"
let g:UltiSnipsSnippetDirectories=["my_snippets", "Ultisnips"]
let g:UltiSnipsExpandTrigger= '<tab>'
let g:UltiSnipsJumpForwardTrigger= '<tab>'
let g:UltiSnipsJumpBackwardTrigger= '<s-tab>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit= 'vertical'
