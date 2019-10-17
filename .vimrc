" .vimrc file by garrett deZeeuw {{{1
set nocompatible                 "Don't try to be vi.  This should be on the first line in the file.

"File/filesystem stuff
scriptencoding utf-8
set encoding=utf-8
set runtimepath+=~/.vim/         "Share plugin directory between terminal vim and gVim
let g:netrw_home="~/.vim/"       "Put .netrwhist with everything else
set directory^=$HOME/.vim/swapfiles//
set undodir=~/.vim/undodir
set undofile
set viewdir=~/.vim/view
set path+=**


"Display/terminal stuff
set t_Co=256                     "Set terminal color mode to 256
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
set timeout ttimeoutlen=1           "Amount of time to wait for next keystroke in multi-key mappings
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

"##### General key mapping ##### {{{1
"Spacebar as Leader key
let mapleader=" "

"Re-source file
noremap <F7> :w<CR>:source %<CR>

"So many ways to leave insert mode! and other insert mode fun
inoremap jk      <Esc>`^
inoremap <Esc>   <Esc>`^
inoremap <A-h>   <Left>
inoremap <A-j>   <Down>
inoremap <A-k>   <Up>
inoremap <A-l>   <Right>
vnoremap m       <Esc>

"Make semi-colon useful
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

"Remap ctrl+move keys to scroll window without moving cursor
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

"These four fixes the capital letter problem when running vim inside terminator inside WSL bash - is this still a thing?
inoremap <silent> <ESC>OA <Nop>
inoremap <silent> <ESC>OB <Nop>
inoremap <silent> <ESC>OC <Nop>
inoremap <silent> <ESC>OD <Nop>

"Swap redo and 'reset line'
nnoremap U <C-r>
nnoremap <C-r> U

"Enter visual block mode
nnoremap vv <C-v>

"Windows habits die hard
nnoremap <Leader>a <C-a>
nnoremap <Leader>x <C-x>
nnoremap \a <C-a>
nnoremap \x <C-x>
nnoremap <C-a> ggVG
nnoremap <silent> <C-v> :set paste<CR>P:set nopaste<CR>
vnoremap <C-x> x
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

"Return to original position after yanking
vnoremap y <Esc>mzgvy`z

"Use Ctrl+Alt+J / Ctrl+Alt+K in normal, insert, visual mode to move lines
nnoremap <silent> <Leader>j :m .+1<CR>==
nnoremap <silent> <Leader>k :m .-2<CR>==
"inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
"inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
"vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
"vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

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

"}}}1

"##### FZF bindings be here ##### {{{1

nnoremap <silent> <Leader>0 :Buffers<CR>
nnoremap <silent> <Leader>f :Files<CR>

" Better command history with q:
command! CmdHist call fzf#vim#command_history({'right': '40'})
"nnoremap <silent> q; :CmdHist<CR>
nnoremap <silent> <leader>; :CmdHist<CR>

" Better search history
command! QHist call fzf#vim#search_history({'right': '40'})
"nnoremap <silent> q/ :QHist<CR>
nnoremap <silent> <leader>/ :QHist<CR>

"}}}1

"##### Window, buffer & tab management ##### {{{1

"Switch among multiple open buffers & windows
nnoremap <Leader>h :bp<CR>
"nnoremap <Leader>j <C-w>j
"nnoremap <Leader>k <C-w>k
nnoremap <Leader>l :bn<CR>
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l
nmap     <Leader>, <Plug>AirlineSelectPrevTab
nmap     <Leader>. <Plug>AirlineSelectNextTab
nnoremap <silent> <Leader>t :tabnew<CR>
nnoremap <silent> <Leader>n :enew<CR>
nnoremap <silent> <Leader>m :call HideOrCloseBuffer()<CR>
nnoremap <silent> <Leader>M :bd!<CR>
nnoremap <silent> <Leader>b :call HideOrCloseBuffer()<CR>
nnoremap <silent> <Leader>b :Bd<CR>

"Make arrow keys useful for window, buffer & tab management
nnoremap <Left>             <C-w>h
nnoremap <Down>             <C-w>j
nnoremap <Up>               <C-w>k
nnoremap <Right>            <C-w>l

nnoremap <silent> <a-Left>  :bp<CR>
nnoremap <silent> <a-Down>  :hid<CR>
nnoremap <silent> <a-Up>    :vsp<CR><C-w>l
nnoremap <silent> <a-Right> :bn<CR>
nnoremap <silent> <a-Home>  :enew<CR>
nnoremap <silent> <a-End>   :bp<CR>:bd#<CR>

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
nmap <Leader>- <Plug>AirlineSelectPrevTab
nmap <Leader>= <Plug>AirlineSelectNextTab

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
nnoremap <silent> ,n <Esc>:let @*=line(".")<CR>:echom "Copied line #: " @*<CR>

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

"##### Custom Commands and Functions ##### {{{1

"Mappings to invoke commands below
nnoremap \dfms :DateFromMs<CR>
nnoremap \mstd :DateFromMs<CR>

"Change working directory to current file
command! Cd :cd %:p:h

"Edit some common files
command! Eahk :vsp c:\dev\_scripts\dev_keys.ahk
command! Eiv  :vsp ~/.ideavimrc
command! Eb   :vsp ~/.bashrc
command! Ev   :vsp $MYVIMRC
command! Sv   :so $MYVIMRC
nnoremap <silent> <F12> :Sv<CR>:echom "Reloaded ~/.vimrc"<CR>

"Random assorted miscellaneous commands
command! Wsession mksession! ~/.vim/session.vim | echom "Wrote  ~/.vim/session.vim"
command! Rsession source     ~/.vim/session.vim | echom "Restored ~/.vim/session.vim"

command! Csva     :%CSVArrange
command! Nom      e ++ff=dos
command! Mod      :setlocal modifiable
command! Nomod    :setlocal nomodifiable
command! Notes    vert topleft sp | vertical resize 50 | setlocal nonumber | edit ~/notes.txt | norm <C-w><C-p>
command! Logview  vert topleft sp | vertical resize 37 | setlocal nuw=7 | setlocal norelativenumber | setlocal scrollbind | exe ':norm 0<C-w><C-p>' | setlocal scrollbind | exe ':norm 029zl'
command! Curcolor :echom "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") ."> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
command! DateFromMs %s/\v<(\d{10})\d{3}>/\="'".strftime('%c', str2nr(submatch(1)))."'"/g


"Bump the statusline up rather than scroll the tabline off the screen
command! Q        exe 'set cmdheight=3<Bar>redraw<Bar>echo ":q"'    | q   | set cmdheight=1
command! W        exe 'set cmdheight=3<Bar>redraw<Bar>echo ":w"'    | w   | set cmdheight=1
command! Bd       exe 'set cmdheight=3<Bar>redraw<Bar>echo ":bd"'   | bd  | set cmdheight=1
command! Bdp      exe 'set cmdheight=3<Bar>redraw<Bar>echo ":bd#"'  | bd# | set cmdheight=1
command! Clo      exe 'set cmdheight=3<Bar>redraw<Bar>echo ":clo"'  | clo | set cmdheight=1

"Keep current view and last search intact when invoking a command
function! Preserve(command)
  " Preparation: save window state & search
  let l:saved_winview = winsaveview()
  let l:saved_search = @/

  " Run the command:
  execute "silent!" . a:command

  " Clean up: restore previous window position & search
  call winrestview(l:saved_winview)
  let @/=l:saved_search
endfunction

"Strip White Space from line, range, or visual selection with 'sws'
command! -range Sw <line1>,<line2>call Sw()
function! Sw()
    if exists(a:firstline) && exists(a:lastline)
        call Preserve(a:firstline . "," . a:lastline . "s/\\s\\+$//g")
    elseif exists(a:firstline) && !exists(a:lastline)
        call Preserve(a:firstline . ",s/\\s\\+$//g")
    elseif !exists(a:firstline) && exists(a:lastline)
        call Preserve("," . a:lastline . "s/\\s\\+$//g")
    else
        call Preserve("s/\\s\\+$//g")
    endif
endfun

"Grab issue number from branch name and put it on the first line
command! Fcm      :call FormatCommitMessage()
function! FormatCommitMessage()
    g/^# On branch.*\%[\/]\([A-Z]*-[0-9]*\)/exe "co0"
    1s/^.*\s.\{-}\%[\/]\([a-zA-Z]\+-[0-9]\+\).*$/#\1 /
endfun

"Show custom notes pane on the left side
if !exists("g:showNotes")
    function! ToggleNotes()
        if @% == 'notes.txt'
            call HideOrCloseBuffer()
        else
            exe 'vert topleft sp <bar> vertical resize 50 <bar> setlocal nonumber <bar> edit ~/notes.txt <bar> norm <C-w><C-p>'
        endif
    endfun
endif

"nnoremap <F12> :call DebugHideOrClose()<CR>
"fun! DebugHideOrClose()
"    let buffer_count  = len(getbufinfo({'buflisted':1}))
"    let tabpage_count = tabpagenr('$')
"    let window_count  = winnr('$')
"    echom "tab count: " . l:tabpage_count . "  window count: " . l:window_count . "  buffer count: " . l:buffer_count
"endfun

fun! HideOrCloseBuffer()
    let buffer_count  = len(getbufinfo({'buflisted':1}))
    let tabpage_count = tabpagenr('$')
    let window_count  = winnr('$')

    "      If there is only one buffer and one window and one tab then close
    if     l:buffer_count == '1' && l:window_count == '1' && l:tabpage_count == '1'
        exe 'Bd'
    "      If there are multiple buffers and only one window and only one tab, then bp|bd#
    elseif l:buffer_count >= '1' && l:window_count == '1' && l:tabpage_count == '1'
        exe 'bp|Bdp'
    else
        "If there are multiple buffers or multiple windows or multiple tabs, then hide
        exe 'hide'
    endif
    "Special case for closing the [No Name] buffer from an empty tab?
endfun

fun! FlashCursor()
    set cursorline cursorcolumn
    redraw
    sleep 500m
    set nocursorline nocursorcolumn
endfun

fun! FixKeyMappingCase()
    %s/<\(\a\)-\(\a\)>/<\U\1-\L\2>/g
    %s/<Leader>/<Leader>/gi
    %s/<CR>/\<CR\>/gi
    %s/<Esc>/<Esc>/gi
endfun

command! Uwk    :call UnwrapKibana()
fun! UnwrapKibana()
    "g!/"rawline": "/d
    "%s/\s\+"rawline": "\(.*\)"/\1/
    g!/"message": "/d
    %s/\s\+"message": "\(.*\)"/\1/
    %s/,$//
    g/^/m0
    "sort u
endfun

command! Jira   :call FormatJiraThread()
fun! FormatJiraThread()
    g/Permalink/d
    g/From SFDC user/d
    %s/^/    /
    g/added a comment/norm [ <<
    norm ggdd
endfun

nnoremap \d2h :Dec2hex<CR>
command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range
    if empty(a:arg)
        if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
            let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
        else
            let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
        endif
        try
            execute a:line1 . ',' . a:line2 . cmd
        catch
            echo 'Error: No decimal number found'
        endtry
    else
        echo printf('%x', a:arg + 0)
    endif
endfunction

nnoremap \fps :call FormatPreparedStatement()<CR>
vnoremap \fps :call FormatPreparedStatement()<CR>
"command! -range Fps     <line1>,<line2>call FormatPreparedStatement()
fun! FormatPreparedStatement() range
    " New approach to try: do a while loop, looping from the last line to the first. 
    " 'put' and format each as we go along.
    " This way each successive statement does not push the next one farther down,  
    " as the line number of the next-higher statement will not move.

    let sqlPattern = '^.*Prepared SQL: \[\(.\{-}\)\] with parameters \[\(.\{-}\)\]$'

    "echom "firstline: ".a:firstline.", lastline: ".a:lastline

    let curLineNr = a:lastline
    
    while curLineNr >= a:firstline
        let line=getline(curLineNr)

        " Go to the current line number by simply :ex commanding it
        exe curLineNr

       " Skip line if pattern does not match
        if match(line, sqlPattern) == -1
           let curLineNr = curLineNr - 1
           continue
            "return
        endif

        let sqlString=""
        let paramString=""
        let sqlString   = matchlist(line, sqlPattern)[1]
        let paramString = matchlist(line, sqlPattern)[2]

        let params = split(paramString, ",")

        "Substitute each parameter into the string.  null or numeric parameters are not wrapped.
        "All others (string, date) are wrapped in single quotes.
        for param in params
            let param = trim(param)
            if param =~# '\v^\d+$'
                let sqlString = substitute(sqlString, '?', param, "")
            elseif param =~# '\v^null$'
                let sqlString = substitute(sqlString, '?', param, "")
            else
                let sqlString = substitute(sqlString, '?', "'" . param . "'", "")
            endif
        endfor

        "Comment out the log line and create an empty line below
        norm! I--ok

        "Place the contents of the variable into the buffer
        put =sqlString

        "Format the SQL as best we can
        call SQLUtilities#SQLU_Formatter(getline('.'))

        let curLineNr = curLineNr - 1
    endwhile
endfun

nnoremap \h2d :Hex2dec<CR>
command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
function! s:Hex2dec(line1, line2, arg) range
    if empty(a:arg)
        if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
            let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
        else
            let cmd = 's/0x\x\+/\=submatch(0)+0/g'
        endif
        try
            execute a:line1 . ',' . a:line2 . cmd
        catch
            echo 'Error: No hex number starting "0x" found'
        endtry
    else
        echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
    endif
endfunction

nnoremap \csb :call CopySearchToNewBuffer()<CR>
function! CopySearchToNewBuffer()
    let @n = ''
    g//yank N
    enew
    normal "nPggdd
    nohl
endfun

nnoremap <leader>r :call Repl()<cr>
function! Repl()
  while 1
    let expr = input('> ', '', 'expression')
    if expr == 'q' | break | endif
    if expr != ''
      echo "\n"
      if expr =~ '='
        execute 'let ' . expr
      else
        let ans = eval(expr)
        echo string(ans)
      endif
    endif
  endwhile
endfunction

"vnoremap \cb :y<CR> | execute "enew"
"vnoremap \cb :y | normal enew | P
"}}}1

"##### Autocommands ##### {{{1

"Persist marks between vim sessions
"augroup persistmarks
"    au!
"    autocmd BufWinLeave  *.* mkview!
"    autocmd BufWinEnter  *.* silent loadview
"    autocmd BufWritePost *   mkview!
"augroup END

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

if has("gui_running")
    set guioptions=g!c
    set shell=cmd.exe
    set shellcmdflag=/c
    set shellxquote=
    set shellpipe=>
    "set shell=wsl.exe
    "set shellpipe=|
    "set shellredir=>
    "set shellcmdflag=

    " Automatically save/restore session
    autocmd VIMEnter * :source ~/.vim/session.vim | simalt ~r | simalt ~x
    autocmd VIMLeave * :mksession! ~/.vim/session.vim

    "Change font sizes
    "nnoremap + :silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)+1 > 24 ? 24 : submatch(0)+1)', 'g')<CR>:call MaintainFullscreen()<CR>:redraw<CR>:echom "Font:"&gfn<CR>
    "nnoremap _ :silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)-1 < 6 ? 6 : submatch(0)-1)', 'g')<CR>:call MaintainFullscreen()<CR>:redraw<CR>:echom "Font:"&gfn<CR>
    nnoremap <c-=> :silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)+1 > 24 ? 24 : submatch(0)+1)', 'g')<CR>:call MaintainFullscreen()<CR>:redraw<CR>:echom "Font:"&gfn<CR>
    nnoremap <c--> :silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)-1 < 6 ? 6 : submatch(0)-1)', 'g')<CR>:call MaintainFullscreen()<CR>:redraw<CR>:echom "Font:"&gfn<CR>
else
    "Define anything that should only execute when not using gVim
    set shell=bash
    set shellpipe=|
    set shellredir=>

    "Format JSON via python
    nnoremap =j :%!python -m json.tool<CR>
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
    Plug 'junegunn/vim-peekaboo'

    Plug 'tpope/vim-characterize'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-abolish'
 "   Plug 'tpope/vim-dadbod'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-jdaddy'

    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-airline/vim-airline'

    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-line'
    Plug 'saihoooooooo/vim-textobj-space'

    Plug 'vim-scripts/SQLUtilities'
    Plug 'vim-scripts/Align'

    Plug 'yaroot/vissort'
    Plug 'chrisbra/csv.vim'
    Plug 'google/vim-searchindex'
    Plug 'benknoble/vim-auto-origami'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'cosminadrianpopescu/vim-tail'
call plug#end()

" Airline Configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#fnamemod = ':~:.'
"let g:airline#extensions#tabline#fnamemod = ':p:~'
let g:airline#extensions#tabline#fnamecollapse = 1

" Remove the 'bold' escape code for certain status line elements to fix rendering of vim-airline in tmux
"call airline#parts#define_accent('mode', 'none')
"call airline#parts#define_accent('linenr', 'none')
"call airline#parts#define_accent('maxlinenr', 'none')

"auto-origami - display foldcolumn only when folds are present
let g:auto_origami_foldcolumn = 3

"Netrw fixer-uppers
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"}}}1

" ##### highlights key mapping ##### {{{1
" highlights.vim mappings:

    "for i in range(1, 9)
    "  execute 'vnoremap <silent> \'.i.' :<C-U>call <SID>DoHighlight('.i.', 1, v:count)<CR>'
    "  execute 'nnoremap <silent> \'.i.' :<C-U>call <SID>DoHighlight('.i.', 2, v:count)<CR>'
    "endfor

    "vnoremap <silent> \0 :<C-U>call <SID>UndoHighlight(1)<CR>
    "nnoremap <silent> \0 :<C-U>call <SID>UndoHighlight(2)<CR>
    "nnoremap <silent> \- :call <SID>WindowMatches(0)<CR>
    "nnoremap <silent> \+ :call <SID>WindowMatches(1)<CR>
    "nnoremap <silent> \* :call <SID>WindowMatches(2)<CR>
    "nnoremap <silent> <c-n> :call <SID>Search(0)<CR>
    "nnoremap <silent> <c-p> :call <SID>Search(1)<CR>
    "nnoremap <silent> \n :let @/=<SID>Search(0)<CR>
    "nnoremap <silent> \N :let @/=<SID>Search(1)<CR>

    "nnoremap <silent> \\ :call <SID>MatchToggle()<CR>
    "vnoremap <silent> \\ <Esc>:call <SID>MatchToggle()<CR>gv
