"""""""""""""""""""""""""""""""""""
" Vim Plug Settings
" Check if VimPlug exists. If not, download it

let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

" VimPlug plugins
call plug#begin('~/.local/share/nvim/plugged')

" Check if we have plugins installed and install if we don't
if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
    autocmd VimEnter * PlugInstall | q
endif


" Looks/UI
Plug 'challenger-deep-theme/vim', {'as': 'challenger-deep'}
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'thaerkh/vim-indentguides'

Plug 'bfrg/vim-cpp-modern'

" Tags
Plug 'ludovicchabant/vim-gutentags' "tag management
Plug 'liuchengxu/vista.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sgur/vim-editorconfig' " to honor editorconfig
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " TODO check out nvim-colorizer
Plug 'ryanoasis/vim-devicons'

" Markdown Rendering
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': 'markdown'  }



if has('nvim')
    Plug 'Shougo/denite.nvim' " maybe replace with vim-clap
    " Deoplete and sources
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'} " TODO look at ale
else
    " Allow Denite/Deoplete to run on vim
    Plug 'Shougo/denite.nvim'
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
end

Plug 'Shougo/neoinclude.vim' " completion for include files
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
Plug 'sebastianmarkow/deoplete-rust', {'for': 'rust'} " completion for rust
Plug 'deoplete-plugins/deoplete-clang', { 'for': ['c', 'cpp', 'arduino'] } " completion for c/c++/arduino
Plug 'deoplete-plugins/deoplete-tag'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim', {'for': 'vim'}

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Devicon config
if has_key(plugs, "vim-devicons") && has_key(plugs, "denite.nvim")
    let g:webdevicons_enable_denite = 1
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" Hexokinase settings since a seperate file doesn't work
if has_key(plugs, "vim-hexokinase")
    let g:Hexokinase_ftAutoload = ['*']
    let g:Hexokinase_highlighters = ['backgroundfull']
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""
" These lightline settings can't be moved...
if has_key(plugs, "lightline.vim")
    let g:lightline#bufferline#unnamed = '[No Name]'
    let g:lightline#bufferline#show_number=2
    let g:lightline#bufferline#enable_devicons=1 " until i'm using a decent font
    let g:lightline#bufferline#filename_modifier=':t' " only show basefile and extension
endif

