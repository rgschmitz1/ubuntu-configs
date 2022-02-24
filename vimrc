" Set tab indent to two spaces for all files unless override takes place
autocmd FileType * set tabstop=2|set shiftwidth=2|set noexpandtab
autocmd FileType sh set tabstop=4|set shiftwidth=4|set noexpandtab
" Make paste work without auto-indent
set paste
" Highlight search
set hlsearch
" status bar colors
au InsertEnter * hi statusline guifg=black guibg=magenta ctermfg=black ctermbg=magenta
au InsertLeave * hi statusline guifg=black guibg=cyan ctermfg=black ctermbg=cyan
hi statusline guifg=black guibg=cyan ctermfg=black ctermbg=cyan

" Status line
" default: set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

" Status Line Custom
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ "\<C-V>" : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ "\<C-S" : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

set laststatus=2
set noshowmode
set statusline=
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}\  " The current mode
set statusline+=%1*\ col:\ %2v\                          " Colomn number
set statusline+=%2*│                                     " Separator
set statusline+=%1*\ ln:\ %2l\                           " Line number, percentage of document
set statusline+=%2*│                                     " Separator
set statusline+=%1*\ %<%F%m%r%h%w\                       " File path, modified, readonly, helpfile, preview

hi User1 ctermfg=black ctermbg=white guibg=white guifg=black
hi User2 ctermfg=black ctermbg=white guibg=white guifg=black
filetype plugin indent on
set background=dark
