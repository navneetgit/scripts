set shell=/bin/bash                                                                                                                                                                                                                                  
set shiftwidth=8                                                                
set tabstop=8                                                                   
set incsearch                                                                   
set hlsearch                                                                    
set ic                                                                          
cscope add $CSCOPE_DB                                                           
nmap <F7> <C-w><C-w>                                                            
nmap <C-@>  :vsplit <CR> <F7>                                                   
map <F6> :execute "vsplit"  :execute "normal <C-w><C-w>"                        
nmap <F8> :vsplit <CR> ^V| <C-w><C-w>                                           
map <F5>  :execute "vsplit" \| execute ""                                       
map <F4> :call Func() <CR>                                                      
map <C-\> :call Func() <CR>                                                     
                                                                                
set colorcolumn=80                                                              
hi ColorColumn ctermbg=darkgrey guibg=darkgrey                                  
set ai                                                                          
set cindent                                                                     
set formatoptions+=r                                                            
set tags=./tags;                                                                
                                                                                
set wildmenu                                                                    
set cursorline                                                                  
set cursorcolumn                                                                
hi CursorLine ctermbg=darkgrey guibg=darkgrey                                   
hi CursorColumn ctermbg=darkgrey guibg=darkgrey                                 
set showmatch                                                                   
                                                                                
call pathogen#infect()                                                          
                                                                                
highlight clear SignColumn                                                      
                                                                                
function Func()                                                                 
        vsplit                                                                  
        execute "normal \<C-w>w"                                                
        execute "cs find 0 <cword>"                                             
        normal zz                                                               
endfunction 
