#!/bin/sh

alias l='ls -al'
alias rg='rgrep --color=auto'

alias gs='git status'

function pd()                                                                   
{                                                                               
	if [ $# -eq 0 ];then                                                    
		echo -n "This will clear the dirs stack. Continue? [Y/n]"       
		read -n 1 option                                                
		echo $option                                                    
		if [[ "$option" == "y" ]];then                                                                                  
			dirs -c                                                 
		fi                                                              
	else                                                                    
		for i in $@; do                                                 
		echo $i
		pushd $i                                                
		done                                                            
	fi                                                                      
} 

function d()                                                                    
{                                                                               
	if [ $# -eq 0 ];then                                                    
		dirs -v                                                         
	fi                                                                      

	if [ $# -eq 1 ];then                                                    
		cd `dirs -l +$1`                                                   
		echo $1                                                         
	fi                                                                      
					
	if [ $# -gt 1 ];then                                                    
		echo "invalid usage"                                            
	fi                                                                      
}

function f()
{
	dir=$1
	shift
	find $arg1 -type f | xargs grep --color=auto $*
#	grep -n -r -i -e \"$*\" $dir
}

function mcom()
{
	minicom -D /dev/ttyUSB$1
}

# for each directory, go to and checkout a certain branch. faster than repo
#for i in `ls`; do echo $i; cd $i; j=`git branch --remote | grep dev-other | awk '{print $3}'`; echo $j; git checkout $j; cd ../; echo "----"; done;

# for each repo, print git status
#proj=`repo status | grep project | awk {'print $2'}`; for i in $proj; do echo $i; cd $i; git status; cd -; echo "------------------------"; done;

alias gs='p=$PWD; for i in `find . -name ".git"`; do cd ${i}/../; echo ">>>>>>>>>>>>"; echo $i; git status; echo "<<<<<<<<<<<<<"; cd -; done;'
alias gpr='p=$PWD; for i in `find . -name ".git"`; do cd ${i}/../; echo ">>>>>>>>>>>>"; echo $i; git pull --rebase; echo "<<<<<<<<<<<<<"; cd -; done;'

alias gerrit='ssh -p 12001 $my-gerrit-server gerrit'                        
alias gerrit-query='gerrit query'                                               
#pipe gerrit query with -> '| egrep '^  number' | cut -d\  -f4- > CHANGES_NUMBERS' to get change numbers
#Reference - https://www.mediawiki.org/wiki/Gerrit/Advanced_usage#Mass-approving_changes_across_repositories

export SERVER_ADDR=android-build-01
export SERVER_PATH=/home/navneetk/
export PATH=~/bin:$PATH

handy=/media/navneetk/work/handy_scripts

#build server
export SERVER_PATH=/build/$USER

#resize/fix the size of byobu window
function refresh_byobu()
{
	/usr/lib/byobu/include/tmux-detach-all-but-current-client
}
