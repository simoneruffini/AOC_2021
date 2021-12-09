"Each line must be yanked and executed on the input file with @"
" :help expr-quote
"
" Yank this paragraph and press @"
:function! MakeScratch()
:   vnew
:   wincmd L
:   setlocal buftype=nofile
:   setlocal bufhidden=hide
:   setlocal noswapfile
:   let @s = bufnr("")
:   mark S
:endfunction
:function! DeleteScratch()
: exe "bdelete ".@s
:endfunction
:function! StartStep()
:   exe "norm!mQ\'S\e" 
:endfunction
:function! EndStep()
:   exe "norm!\'Q0zz\e"
:endfunction


"Part 1"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"step 1
:exe "norm!mQ\e" | :call MakeScratch() | :r ./day2/input.txt | :exe "norm!ggdd" | :wincmd p

"step 2
:call StartStep() | :sort | :call EndStep()

"step 3
:call StartStep() | :exe "%s/up /-/g" | :exe "%s/down /+/g" | :exe "norm!/forw\nVN\"fd" | :cal EndStep()

"step 4
:function! CalcLine()
:   exe "norm!gg0Di\<C-r>=\<C-r>\"\n"
:endfunction
:call StartStep() | :let @t="J@t" | :exe "norm!gg@t" | :exe "%s/ //g" | :call CalcLine() | :call EndStep()

"step 5
:call StartStep() | :exe "norm!\"rD\"fP\e" | :exe "%s/forward /+/g\n" | :exe "norm!gg0@t\e" | :exe "%s/ //g\n" | :call CalcLine() | :exe "norm!0\"pye" | :call EndStep()

"step 6
:call StartStep() | :exe "norm!0I*\e\"rP" | :call CalcLine() | :exe "norm!\"tyy\e" | :call EndStep() | :call DeleteScratch()

"step 7
:echo "The answer is: ".getreg("t")

"Part 2"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"step 1
:exe "norm!mQ\e" | :call MakeScratch() | :r ./day2/input.txt | :exe "norm!ggdd" | :wincmd p

"step 2
:call StartStep() | :exe "%s/up /-/g" | :exe "%s/down /+/g" | :exe "%s/forward /*/g" | :cal EndStep()

"step 3
:function! ComputeStep()
:   let i = 0
:   let f = line('$')
:   let aim = 0
:   let depth = 0
:   while i < f
:     exe "norm!gg0dd\e"
:     if @1[0] == "*" 
:       let depth += (aim * str2nr(@1[1:]))
:     else
:       let aim += str2nr(@1)
:     endif
:     let i+=1
:   endwhile 
:   echo "final aim: ".aim
:   echo "final depth: ".depth
:   return depth
:endfunction
:call StartStep() | :let @r = ComputeStep() | :call EndStep()

"step 4
:let @r = @r * @p | :call DeleteScratch()

"step 5
:echo "The answer to the second step is: ".@r

