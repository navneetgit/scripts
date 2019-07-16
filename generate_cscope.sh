#!/bin/bash
# This script/function generates cscope and tags in target directories
#
# Usage: . generate_cscope.sh <dir1> <dir2> ...
# NOTE: using ". <space>" for invocation is necessary since the script also
#      exports the CSCOPE_DB environment variable at the end.
#      If the script is not sourced into the shell, CSCOPE_DB will not be exported.
#      One can edit the vimrc to do "cs add $CSCOPE_DB"
#
# create /tmp/cscope.files                                                      
# check dir exists                                                               
# if exists, run the command to append to cscope.files                           
# create sha1 of cscope.files and mv the file into /tmp/sha/                     
                                                                                
if [ "$1" == "" ]; then                                                         
        echo "provide directories as argument"                                  
        return
fi                                                                              
                                                                                
if [ -f "/tmp/cscope.files.tmp" ]; then                                         
        tm /tmp/cscope.files.tmp                                                
fi                                                                              
                                                                                
for i in "$@"; do                                                               
        echo "processing directory ${i}"                                        
        if [ ! -d ${i} ]; then                                                  
                echo "dir ${i} doesn't exist, skipping"                         
                continue                                                        
        fi                                                                      
        find ${i} -name "*.c" -o -name "*.h" -o -name "*.cpp" -o -name "*.m" | awk '{printf "\"%s\"\n", $0}' >> /tmp/cscope.files.tmp           
        echo "Building tags in ${i}"                                            
        cd ${i}                                                                 
		ctags -R .                                                              
        cd -                                                                    
        echo "Done!"                                                            
        echo "Succesfully processed ${i}"                                       
done;                                                                           
                                                                                
cscope -kqbv -i /tmp/cscope.files.tmp -f /tmp/cscope.out.tmp                    
sha=$(shasum /tmp/cscope.out.tmp | awk {'print $1'})                            
echo $sha                                                                       
if [ -d "/tmp/${sha}" ]; then                                                   
        echo "/tmp/${sha} already exists, deleting..."                          
        rm -rf /tmp/${sha}                                                      
fi                                                                              
                                                                                
mkdir /tmp/${sha}                                                               
mv /tmp/cscope.files.tmp /tmp/${sha}/cscope.files                               
mv /tmp/cscope.out.tmp /tmp/${sha}/cscope.out                                   
mv /tmp/cscope.out.tmp.po /tmp/${sha}/cscope.out.po                             
mv /tmp/cscope.out.tmp.in /tmp/${sha}/cscope.out.in                             
export CSCOPE_DB="/tmp/${sha}/cscope.out"                                       
echo "CSCOPE_DB->${CSCOPE_DB}"
