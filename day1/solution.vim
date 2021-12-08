"Each line must be yanked and executed on the input file with @"
"step 1
:normal mQ | :find ./day1/input.txt | :normal mW | :normal 'Q
"step 2
:normal mQ'Wgg0A (N/A - no previous measurement) | :normal 'Q
"step 3
:function! F(var1,var2)
:  if (a:var2+0)>(a:var1+0)
":   :exec "normal! A (increased) ". a:var1 ." ". a:var2. " \e"
:   :exec "normal! A (increased) \e"
:  else 
:   :exec "normal! A (decreased) \e"
":   :exec "normal! A (decreased) ". a:var1 ." ". a:var2. " \e"
:  endif
:endfunction
"step 4
:normal! mQ'Wgg0 | :let @e="" | :let @q="" | :let @w="" | :let @e="0\"qyej0\"wye0@=F(@q,@w)\n@e" | :normal! @e | :normal `Q
"step 5
:normal! mQ'W | :let r = execute("%s/increased//gn") | :%s/ \(.*\)//g | :norm! uu'Q
"step 6
:echo r


