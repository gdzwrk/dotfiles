" .vimrc file by garrett deZeeuw {{{1
set nocompatible                 "Don't try to be vi.  This should be on the first line in the file.

"File/filesystem stuff
scriptencoding utf-8
set encoding=utf-8
set runtimepath+=~/.vim/         "Share plugin directory between terminal vim and gVim
let g:netrw_home="~/.vim/"       "Put .netrwhist with everything else
"set directory^=$HOME/.vim/swapfiles//
set directory=$HOME/.vim/swapfiles//,.
set undodir=~/.vim/undodir
set undofile
set viewdir=~/.vim/view
set path+=**

"Display/terminal stuff
"set t_Co=256                     "Set terminal color mode to 256
set t_Co=xterm-256color           "Set terminal color mode to xterm-256
set listchars=tab:»·,trail:·,space:·,eol:¬                           "Set tab, space, and trailing characters as whitespace characters
"}}}1

"Mix well, add salt to preference {{{1
filetype indent plugin on
colorscheme desert
syntax on

set formatoptions=qj                "Define how text is wrapped/formatted. See 'fo-table'
set hidden                          "Allow unsaved buffers to reside in the background
set confirm                         "Ask to close unsaved buffer rather than block
set nowrap                          "Don't wrap long lines
set ruler                           "Show cursor position
set hlsearch                        "Highlight current search matches
set incsearch                       "Incremental search as it's typed
set autoindent                      "Maintain indentation when opening a new line
set ignorecase                      "Set case-insensitive search as the default
set smartcase                       "Only do case-sensitive search when a capital letter is typed
set visualbell                      "Blink instead of ding...
set showcmd                         "Show partial commands in the last line of the screen
set nostartofline                   "Don't move cursor to beginning of line for some commands
set mouse=a                         "Enable the mouse
set timeout timeoutlen=500          "Default timeout setting of 500ms
set ttimeoutlen=1                   "Amount of time to wait for next keystroke in multi-key mappings
set virtualedit=all                 "Allow cursor to move into empty space
set laststatus=2                    "Always display status line, even if only one window is displayed
set backspace=indent,eol,start      "Allow backspacing across lines, indentations
set cmdheight=1                     "Show command window across 2 lines
set expandtab                       "Use spaces instead of tabs
set shiftwidth=4                    "Set distance to shift to 4 spaces
set softtabstop=4                   "Backspace over a 'tab' to delete 4 spaces at once ('virtual tab')
set textwidth=120                   "Use 120 characters when formatting lines
set wrapmargin=0                    "Stop automatically wrapping lines (unless formatting is called!)
set clipboard=unnamed               "Use system clipboard when yanking
set switchbuf+=useopen              "If a buffer is in an open window already, switch to it
set wildmenu                        "Use wildcard menu
set wildmode=list:longest,full      "Set completion mode
set foldmethod=marker               "Use markers to define folds (three curly braces)
set relativenumber                  "Use relative line numbering
set number                          "Show line number
set nomodeline                      "Security vulnerability. Fixed in version 8.1.1365

" Change cursor when in insert mode
"let &t_SI.="\<Esc>[6 q"
"let &t_SI.="\<Esc>[2 q"
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
"}}}1

"##### Ground level key mapping. Essentials ##### {{{1
"Spacebar as Leader key
let mapleader=" "

"Re-source current buffer
noremap <F7> :w<CR>:source %<CR>

"Just kidding, escape
inoremap jk      <Esc>`^
inoremap <Esc>   <Esc>`^

"Make semi-colon useful
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" ##### Movement and hjkl- related ##### {{{2
"Remap alt+hjkl keys to scroll window without moving cursor
nnoremap <A-j> <C-e>
nnoremap <A-k> <C-y>
nnoremap <A-h> 8zh
nnoremap <A-l> 8zl
vnoremap <A-j> <C-e>
vnoremap <A-k> <C-y>
vnoremap <A-h> 8zh
vnoremap <A-l> 8zl

"Remap move keys to faciliate moving up/down on wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

"Move current line(s) up or down
"vnoremap J :m '>+1<CR>gv
"vnoremap K :m '<-2<CR>gv

"Make insert mode arrow keys great again
inoremap OA <Up>
inoremap OB <Down>
inoremap OD <Left>
inoremap OC <Right>

"Swap redo and 'reset line'
nnoremap U <C-r>
nnoremap <C-r> U

"Enter visual block mode
nnoremap vv <C-v>

"Windows habits die hard
"nnoremap <Leader>a <C-a>
"nnoremap <Leader>x <C-x>
"nnoremap \a <C-a>
"nnoremap \x <C-x>
"nnoremap <C-a> ggVG
nnoremap <silent> <C-v> :set paste<CR>P:set nopaste<CR>

vnoremap <C-c> ygv
vnoremap <silent> <C-v> :<C-u>set paste<CR>gv"_x"*P:set nopaste<CR>

inoremap <silent> <C-v> <Esc>:set paste<CR>p:set nopaste<CR>a
inoremap <silent> <C-b> <C-v>
inoremap <C-BS> <C-w>

"Paste to end of line with Alt+P
nnoremap <A-p> $p

"When in visual mode, delete/paste without yanking the overwritten selection (use 'x' for that)
vnoremap p "_dP
vnoremap d "dd
vnoremap m <Esc>

"Return to original position after yanking
vnoremap y <Esc>mzgvy`z

"Use <leader>j/k to go forward/back in jump list
nnoremap <silent> <Leader>k <c-o>
nnoremap <silent> <Leader>j <c-i>


"}}}2
"
" ##### Whitespace, spelling & formatting ##### {{{2
"Show/hide/trim trailing whitespace
inoremap <silent> \ws <Esc>:set list!<CR>li

nnoremap <silent> \ws :set list!<CR>
nnoremap <silent> \sw :call Sw()<CR>

vnoremap <silent> \ws <Esc>:set list!<CR>gv
vnoremap <silent> \sw :call Sw()<CR>gv

"Toggle spell-checking
nnoremap \sp :set spell!<CR>
vnoremap \sp <Esc>:set spell!gv<CR>

"Set local wrap on/off
nnoremap \wr :setlocal wrap! wrap?<CR>
inoremap \wr <Esc>:setlocal wrap! wrap?<CR>li

"Maintain visual selection when indenting/unindenting
vnoremap >> >gv
vnoremap << <gv

"Function key mappings
nnoremap <silent>   <F4> :NERDTreeToggle<CR>
nnoremap <silent>   <F5> :MRU<CR>
nnoremap <silent>   <F8> :call ToggleNotes()<CR>

"Dude, where's my cursor?
nnoremap <silent>   <F9> :call FlashCursor()<CR>
cnoremap <silent>   <F9> <C-r>=FlashCursor()<CR><Bs>

nnoremap <silent> <C-F9> :set cursorline!<CR>:set cursorcolumn!<CR>
inoremap <silent> <C-F9> <Esc>:set cursorline!<CR>:set cursorcolumn!<CR>i
vnoremap <silent> <C-F9> <Esc>:set cursorline!<CR>:set cursorcolumn!<CR>gv

"Wrap in {noformat} tags
vnoremap <silent> \wnf <Esc>`<O<Home>{noformat}<Esc>`>o<Home>{noformat}<Esc>gv
nnoremap <silent> \wnf m`O<Home>{noformat}<Esc>jo<Home>{noformat}<Esc>``

"}}}2
"}}}1


"##### Window, buffer & tab management ##### {{{1

"Switch among multiple open buffers & windows
nmap     <Leader>, <Plug>AirlineSelectPrevTab
nmap     <Leader>. <Plug>AirlineSelectNextTab

nnoremap <silent> <Leader>t :tabnew<CR>
nnoremap <silent> <Leader>n :enew<CR>
nnoremap <silent> <Leader>m :call HideOrCloseBuffer()<CR>
nnoremap <silent> <Leader>M :bd!<CR>

"Make arrow keys useful for window, buffer & tab management
nnoremap <Left>             <C-w>h
nnoremap <Down>             <C-w>j
nnoremap <Up>               <C-w>k
nnoremap <Right>            <C-w>l

"Keep these for when I decide what alt+arrows should do in normal mode
"nnoremap <silent> <a-Left>
"nnoremap <silent> <a-Down>
"nnoremap <silent> <a-Up>
"nnoremap <silent> <a-Right>

nnoremap <silent> <c-Left>  :tabp<CR>
nnoremap <silent> <c-Down>  :tabclose<CR>
nnoremap <silent> <c-Up>    :tabnew<CR>
nnoremap <silent> <c-Right> :tabn<CR>

"Jump to specific tab numbers with <Leader><#>
nmap <Leader>1 <Plug>AirlineSelectTab1
nmap <Leader>2 <Plug>AirlineSelectTab2
nmap <Leader>3 <Plug>AirlineSelectTab3
nmap <Leader>4 <Plug>AirlineSelectTab4
nmap <Leader>5 <Plug>AirlineSelectTab5
nmap <Leader>6 <Plug>AirlineSelectTab6
nmap <Leader>7 <Plug>AirlineSelectTab7
nmap <Leader>8 <Plug>AirlineSelectTab8
nmap <Leader>9 <Plug>AirlineSelectTab9

"Yank/paste buffer mappings
nnoremap <silent> <Leader>wy :let g:yanked_buffer=bufnr('%')<CR>
nnoremap <silent> <Leader>ww :let g:yanked_buffer=bufnr('%')<CR>:bp<CR>:bd#<CR>
nnoremap <silent> <Leader>wq :let g:yanked_buffer=bufnr('%')<CR>:q<CR>
nnoremap <silent> <Leader>wn :let g:yanked_buffer=bufnr('%')<CR>:enew<CR>
nnoremap <silent> <Leader>wp :call PasteWindow('edit')<CR>
nnoremap <silent> <Leader>ws :call PasteWindow('split')<CR>
nnoremap <silent> <Leader>wv :call PasteWindow('vsplit')<CR>
nnoremap <silent> <Leader>wt :call PasteWindow('tabnew')<CR>

"Yank/paste function
fun! PasteWindow(direction) "{{{
    if exists("g:yanked_buffer")
        if a:direction == 'edit'
            let temp_buffer = bufnr('%')
        endif

        if a:direction == 'edit'
            exec "b" . g:yanked_buffer
        else
            exec a:direction . " +buffer" . g:yanked_buffer
        endif

        if a:direction == 'edit'
            let g:yanked_buffer = temp_buffer
        endif
    endif
endfun "}}}
"}}}1

"##### Folding searching and completion ##### {{{1

"Automatically center find next/prev
nnoremap * *zz
nnoremap # #zz

"Clear search highlighting
nnoremap <silent> <Leader>c :nohl<CR>

"Copy line number into * register
"nnoremap <silent> ,n <Esc>:let @*=line(".")<CR>:echom "Copied line #: " @*<CR>

"Fold all lines that do not match search expression
nnoremap <Leader>z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>

"Fold everything Around the current visual selection (za -> fold around)
vnoremap <Leader>za <Esc>`<kzfgg`>jzfG`<zz
nnoremap <Leader>zs <Esc>zRzz

inoremap <S-Tab> <C-d>
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\t"
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>`^"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "<C-k>"
"}}}1

"##### Autocommands ##### {{{1

" optional reset cursor on start:
augroup myCmds
    au!
    autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

"Set all *.dbg and *.log files unmodifiable, can be toggled with :Mod and :Nomod
augroup unmodifiableLogs
    au!
    "autocmd BufRead *.dbg*,*.log* setlocal modifiable | e ++ff=dos | setlocal syntax=logtalk | setlocal nomodifiable
    autocmd BufRead *.dbg*,*.log* setlocal modifiable | e ++ff=dos | setlocal nomodifiable
augroup END

"Set up gitcommit so that it highlights properly inside IntelliJ and command-line vim.
augroup gitcommit
    au!
    autocmd FileType gitcommit setlocal tw=80 | setlocal fo+=t | let &l:colorcolumn=80 | highlight ColorColumn ctermbg=8 guibg=#000000 | norm 0gg
augroup end

augroup autofoldcolumn
    au!
    au CursorHold,BufWinEnter,WinEnter * AutoOrigamiFoldColumn
augroup END
"}}}1

"##### Plumbing ##### {{{1

"Disable Ex mode (for now)
nnoremap Q <nop>

"Allow for <A-x> alt key bindings to work
let c='a'
while c <= 'z'
exec "set <A-".c.">=\e".c
exec "imap \e".c." <A-".c.">"
let c = nr2char(1+char2nr(c))
endw

let c='0'
while c <= '9'
exec "set <A-".c.">=\e".c
exec "imap \e".c." <A-".c.">"
let c = nr2char(1+char2nr(c))
endw

if has("gui_running") "Define everything for gVim
    set guioptions=g!c
    set shell=cmd.exe
    set shellcmdflag=/c
    set shellxquote=
    set shellpipe=>
    set guifont=DejaVu_Sans_Mono_for_Powerline:h12:cANSI:qDRAFT

    "set shell=wsl.exe
    "set shellpipe=|
    "set shellredir=>
    "set shellcmdflag=

    " Start fullscreen
    autocmd VIMEnter * simalt ~r | simalt ~x
    
    " Automatically save/restore session
    "autocmd VIMEnter * :source ~/.vim/session.vim | simalt ~r | simalt ~x
    "autocmd VIMEnter * :source ~/.vim/session.vim | simalt ~r | simalt ~x
    "autocmd VIMLeave * :mksession! ~/.vim/session.vim

    "Change font sizes
    nnoremap <leader>= :let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)+1 > 24 ? 24 : submatch(0)+1)', 'g')<CR>:redraw<CR>:echom "Font:"&gfn<CR>
    nnoremap <leader>- :let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)-1 < 6 ? 6 : submatch(0)-1)', 'g')<CR>:redraw<CR>:echom "Font:"&gfn<CR>

else   "Define anything that should only execute when not using gVim
    if &term == "xterm-256color" "This is for git-bash
        set term=builtin_xterm
        echom "In builtin_xterm mode"

        "Change font sizes
        "nnoremap <c-=> :silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)+1 > 24 ? 24 : submatch(0)+1)', 'g')<CR>:call MaintainFullscreen()<CR>:redraw<CR>:echom "Font:"&gfn<CR>
        "nnoremap <c--> :silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)-1 < 6 ? 6 : submatch(0)-1)', 'g')<CR>:call MaintainFullscreen()<CR>:redraw<CR>:echom "Font:"&gfn<CR>

        "Format JSON via python
        "nnoremap =j :%!python -m json.tool<CR>
    else "Set for tmux
        set term=tmux-256color
        echom "In tmux-256color mode"
    endif

    set shell=bash
    set shellpipe=|
    set shellredir=>
endif

"}}}1

" ##### Custom highlighting overrides ##### {{{1
hi Pmenu    ctermfg=0 ctermbg=13 guibg=DarkGrey
hi PmenuSel ctermfg=8 ctermbg=0 guibg=Magenta
hi NonText  guibg=#35363B
hi LineNr   ctermfg=11 ctermbg=236 guibg=#444444
"}}}1

" ##### Plugin configuration ##### {{{1

" vim-plug stuff
call plug#begin('~/.vim/plugged')
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/vim-peekaboo'     "See register contents

    Plug 'tpope/vim-characterize'    "Show more char info with ga
    Plug 'tpope/vim-unimpaired'      "Set a bunch of sane defaults? I think?
    Plug 'tpope/vim-vinegar'         "Make netrw more useable
    Plug 'tpope/vim-fugitive'        "Git plugin
    Plug 'tpope/vim-surround'        "Surround with things
    Plug 'tpope/vim-abolish'         "Fix things, change text? Not being used much
    Plug 'tpope/vim-repeat'          "Allow repeating non-builtin commands
    Plug 'tpope/vim-jdaddy'          "Don't remember?

    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-airline/vim-airline'

    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-line'
    Plug 'saihoooooooo/vim-textobj-space'
    Plug 'easymotion/vim-easymotion'

    Plug 'vim-scripts/SQLUtilities'
    Plug 'vim-scripts/Align'

    Plug 'yaroot/vissort'
    Plug 'chrisbra/csv.vim'
    Plug 'google/vim-searchindex'
    Plug 'benknoble/vim-auto-origami'
    Plug 'christoomey/vim-tmux-navigator'
call plug#end()

" FZF bindings {{{2
command! QHist call fzf#vim#search_history({'right': '40'})
command! CmdHist call fzf#vim#command_history({'right': '40'})

nnoremap <silent> <Leader>0 :Buffers<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <leader>; :CmdHist<CR>
nnoremap <silent> <leader>/ :QHist<CR>

"}}}2
  
" Easymotion configuration  {{{2
map , <Plug>(easymotion-prefix)
" }}}2

" Airline Configuration  {{{2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#fnamemod = ':~:.'
"let g:airline#extensions#tabline#fnamemod = ':p:~'
let g:airline#extensions#tabline#fnamecollapse = 1

" auto-origami - display foldcolumn only when folds are present
let g:auto_origami_foldcolumn = 3

" Netrw fixer-uppers
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"}}}1

" ##### Machine-specific configuration #####
source ~/.localrc
