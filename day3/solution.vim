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
:   let @"=bufnr("")
:   return @"
:endfunction
:function! DeleteScratch(regnumb)
: exe "bdelete ".a:regnumb
:endfunction
:function! StartStep(bufferin)
:   exe "norm!mQ:b".a:bufferin."\n\e" 
:endfunction
:function! EndStep()
:   exe "norm!\'Q0zz\e"
:endfunction


"Part 1"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"step 1
:exe "norm!mQ\e" | :let @s = MakeScratch() | :r ./day3/input.txt | :exe "norm!ggdd" | :wincmd p

"step 2
:function! SelectColumn()
:   exe "norm!\<c-v>Gy"
:   return "".getreg("\"")
:endfunction
:function! ComputeMostFrequent(column)
:   let tmp = MakeScratch()
:   exe "norm!i".a:column."\e"
:   let lines = line('$')
:   let ones = split(trim(execute("%s/1//gn")))[0]
:   echo "lines: ".lines." ones: ".ones
:   call DeleteScratch(tmp)
:   let ret = "0"
:   if ones > lines/2 
:       let ret = "1" 
:   endif
:   return ret
:endfunction
:function! ComputeStep()
:   exe "norm!gg0$\e"
:   let columns = col('.')
:   exe "norm!gg0\e"
:   echo columns
:   let i = 0
:   let res = ""
:   while i < columns
:       echo i
:       let columndata = SelectColumn()
:       let t = ComputeMostFrequent(columndata)
:       let res = "".res."".t
:       exe "norm!ggl\e"
:       let i += 1
:   endwhile
:   return res
:endfunction
:call StartStep(@s) | :let gamma = ComputeStep() | :call EndStep()

:function! Invert(value)
:   let tmp = MakeScratch()
:   exe "norm!i".a:value."\e"
:   execute("%s/0/2/g")
:   execute("%s/1/0/g")
:   execute("%s/2/1/g")
:   exe "norm!gg0y$\e"
:   call DeleteScratch(tmp)
:   return getreg("\"")
:endfunction
"step 3
:call StartStep(@s) | :let epsilon = printf("%d","0b".Invert(gamma)) | : let gamma = printf("%d","0b".ComputeStep())|:call EndStep()

"step 4
:let res = epsilon * gamma | :echo "The answer is: ".res | :call DeleteScratch(@s)

"Part 2"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


