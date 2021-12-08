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


"Part 1"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"step 1
:exe "norm!mQ\e" | :call MakeScratch() | :r ./day1/input.txt | :exe "norm!ggdd" | :wincmd p

"step 2
:exe "norm!mQ\'Sgg0A (N/A - no previous measurement)\e\'Q"

"step 3
:function! F(var1,var2)
:  if (a:var2+0)>(a:var1+0)
:     exe "norm!A\t(increased)\e"
:  else 
:     exe "norm!A\t(decreased)\e"
:  endif
:endfunction

"step 4
:exe "norm!mQ\'Sgg0\e" | :let @e="" | :let @q="" | :let @w="" | :let @e="0\"qyej0\"wye0@=F(@q,@w)\n@e" | :exe "norm!@e\e" | :exe "norm!\'Q0zz\e"

"step 5
:exe "norm!mQ\'S\e" | :let r = execute("%s/increased//gn") | :exe "norm!\'Q0zz" | :call DeleteScratch() 

"step 6
:echo r

"Part 2"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"step 1
:exe "norm!mQ\e" | :call MakeScratch() | :r ./day1/input.txt | :exe "norm!ggdd" | :wincmd p

"step 2
:function! Getsum()
:   mark c
:   let @a=0
:   for i in [1,2,3]
:     yank e 
:     let @a=@a+@"
:     exe ":norm!j\e"
:   endfo
:   exe ":norm!\'c\e"
:   return @a
:endfunction

"step 3
:function! ComputeStep()
:   let i = 0
:   while i < (line('$')-2)
:     call Getsum()
:     exe ":norm!A \e\"apA \ej\e"
:     let i+=1
:   endwhile 
:   exe ":norm!Gddddgg\e"   
:endfunction

" step3
:exe ":norm!mQ\'S\e" | :call ComputeStep() | :let @b="0wD0P$xj@b" | :exe ":norm!@b\n" | exe "norm!'Q\e"
" step4
" execute steps from step 2 in part 1

