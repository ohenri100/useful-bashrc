######## ########################################### 
# Include alias file
if [ -f ~/.aliases_bashrc ]; then
	    . ~/.aliases_bashrc 
fi
####################################################
if [ "$PS1" ]; then
  if [ -z "$PROMPT_COMMAND" ]; then
    case $TERM in
	xterm*)
		if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
			PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
		else
            PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
		fi
		;;
	screen)
		if [ -e /etc/sysconfig/bash-prompt-screen ]; then
			PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
		else
            PROMPT_COMMAND='printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
		fi
		;;
	*)
		[ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default
	    ;;
    esac
  fi
fi 
#export PS1="\[\033[38;5;0m\][\[$(tput sgr0)\]\[\033[38;5;124m\]\u\[$(tput sgr0)\]\[\033[38;5;16m\]@\[$(tput sgr0)\]\[\033[38;5;0m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;16m\]\W\[$(tput sgr0)\]\[\033[38;5;0m\]]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;161m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

export HISTFILESIZE=3000 # the bash history should save 3000 commands
export HISTCONTROL=ignoredups #don't put duplicate lines in the history.

# Define a few Color's
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m'              # No Color
# Sample Command using color: echo -e "${CYAN}This is BASH ${RED}${BASH_VERSION%.*}${CYAN} - DISPLAY on ${RED}$DISPLAY${NC}\n"


# SOURCED ALIAS'S AND SCRIPTS
#######################################################

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# SPECIAL FUNCTIONS
#######################################################

netinfo ()
{
echo "--------------- Network Information ---------------"
/sbin/ifconfig | awk /'inet addr/ {print $2}'
echo ""
/sbin/ifconfig | awk /'Bcast/ {print $3}'
echo ""
/sbin/ifconfig | awk /'inet addr/ {print $4}'

# /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
echo "---------------------------------------------------"
}

spin ()
{
echo -ne "${RED}-"
echo -ne "${WHITE}\b|"    
echo -ne "${BLUE}\bx"
sleep .02
echo -ne "${RED}\b+${NC}"
}

scpsend () 
{ 
scp -P PORTNUMBERHERE "$@" USERNAME@YOURWEBSITE.com:/var/www/html/pathtodirectoryonremoteserver/; 
}
######## ###########################################
# Functions
up () {

        COUNTER=$1
        while [[ $COUNTER -gt 0 ]]
        do
           UP="${UP}../"
           COUNTER=$(( $COUNTER -1 ))
        done
	              echo "cd $UP"
	              cd $UP
	              UP=''
	      
}
#cd:
cd ()
{ 	
	clear
	builtin cd $1 	
	#ls -ltr 
	ld
}
######## ########################################### 
function disd(){
	local arr=(./*)
	arr=("${arr[@]/\.\//}")
	for ((k=0; k<${#arr[@]};k++)); do
		if [[ -f "${arr[$k]}" ]];
		then
			arrf+=("${arr[$k]}")
		fi
		if [[ -d "${arr[$k]}" ]];
		then
			arrd+=("${arr[$k]}")
		fi
	done

	######## ########################################### 
	#Diplay directory:
	#printf "\033[32m---> DIR LIST:\033[0m\n"
	if [[ ${#arrd[@]} -gt 0 ]]; then
		printf "${BLUE}---> DIR LIST:\n"
		let "di1=${#arrd[@]}/3"
		let "di11=${#arrd[@]}%3"
		#echo "$di1  ${#arrd[@]} $di11"
		if [[ $di11 -gt 0 ]]; then
			di1=$(( $di1 +1 ))
		fi
		for ((j=0; j<$di1; j++)); do
			let "x1=$j*3+1"
			if [[ ${arrd[$x1-1]} = *[!\ ]* ]]; then
				  ct1="$x1- ${arrd[$x1-1]}/"
			  else
				  ct1=" "
			fi
			if [[ ${arrd[$x1]} = *[!\ ]* ]]; then
				  ct2="$[$x1+1]- ${arrd[$x1]}/"
			  else
				  ct2=" "
			fi
			if [[ ${arrd[$x1+1]} = *[!\ ]* ]]; then
				  ct3="$[$x1+2]- ${arrd[$x1+1]}/"
			  else
				  ct3=" "
			fi
			#printf "%-30s | %-30s | %-30s\n" "$x1- ${arrd[$x1-1]}" "$[$x1+1]- ${arrd[$x1]}" "$[$x1+2]- ${arrd[$x1+1]}"
			printf "%-50s  %-50s  %-50s\n" "$ct1" "$ct2" "$ct3" 
		done
	fi
	#echo -e "Done list dir ${#arrd[@]}"
	######## ########################################### 
	if [[ ${#arrf[@]} -gt 0 ]]; then
		printf "\033[32m---> FILE LIST:\033[0m\n"
		let "index=${#arrd[@]}"
		#echo -e "List file: ${arrf[*]}\n"
		#echo -e "List dir: ${arrd[*]}\n"
		let "di=${#arrf[@]}/10 + 1"
		#echo "$di  ${#arr[@]}"
		for ((j=0; j<$di; j++)); do
			for ((i=0; i<5; i++)); do
				let "x1=$index+$j*10+$i+1"
				let "x2=$index+$j*10+$i+5+1"
				let "y1=$j*10+$i+1"
				let "y2=$j*10+$i+5+1"
				string2=${arrf[$y2-1]}
				if [[ ${arrf[$y1-1]} = *[!\ ]* ]]; then
				  ct1="$x1- ${arrf[$y1-1]}"
				else
				  ct1=" "
				fi
				if [[ ${arrf[$y2-1]} = *[!\ ]* ]]; then
				  ct2="$x2- ${arrf[$y2-1]}"
				else
				  ct2=" "
				fi
				if [[ ("$ct1" == " ") && ("$ct2" == " ") ]]; then
					break
				else
				#printf "$x1-${arr[$x1-1]} \t $x2-${arr[$x2-1]}\n" |expand -t41
				#printf "%-50s | %-50s\n" "$x1- ${arr[$x1-1]}" "$x2- ${arr[$x2-1]}"\
				#printf "%-50s | %-50s\n" "$x1- ${arrf[$y1-1]}" "$x2- $string2"\
				printf "%-50s | %-50s\n" "$ct1" "$ct2"\
				| sed s/run$/`printf "\033[32m\run\033[0m"`/
				fi
			done
			echo -e "----->"
		done
	fi
	echo -e "____________________________________________________________________________________________________________"
	#arrd=()
	unset arrd
	#arrf=()
	unset arrf
}
######## ########################################### 
#Display (vi) the nth file in dir
# Usage: g i
# goto index ith in direectory
alias a="g"
alias m="g"
function g(){
	local arr=(./*)
	arr=("${arr[@]/\.\//}")
	for ((k=0; k<${#arr[@]};k++)); do
		if [[ -f "${arr[$k]}" ]];
		then
			arrf+=("${arr[$k]}")
		fi
		if [[ -d "${arr[$k]}" ]];
		then
			arrd+=("${arr[$k]}")
		fi
	done
	let "lendir=${#arrd[@]}"
	let "lenfile=${#arrf[@]}"
	#echo "lengt dir = $lendir, lengfile = $lenfile arg=$1\n"
	#echo -e "dir=${arrd[$1]}\n"
	if [[ $1 -lt "$lendir+1" ]]; 
	then
		let "index=$1-1"
		cd ${arrd[$index]}
		ld
	else
		let "index=$1-$lendir-1"
		if [ -f "${arrf[$index]}" ]
		then
			vi ${arrf[$index]}
		else
			echo "Out of range. File/Dir not found."
		fi
	fi
	arrd=()
	arrf=()
}
######## ########################################### 
function err_handle {
  #echo "Handle command not found!"
  string=$4
  #echo "Len: ${#string} string=$string"
  if [[ ${#string} -gt 1 ]];
  then
  	cmd=${string:0:1}
  	index=${string:1}
  	if [[ ("$string" == *"a"*) || ("$string" == *"g"*) || ("$string" == *"m"*) ]]; then
		re='^[0-9]+$'
		if [[ $index =~ $re ]] ; then
			  g $index
		fi
  	fi
  fi
  #echo "Te: 1:$1 2:$2 3:$3 4:$4"
unset string
}
trap 'err_handle "$BASH_SOURCE" "$BASH_LINENO" "$FUNCNAME" "$BASH_COMMAND" ' ERR
######## ########################################### 
#sha
function shadir() { find $1 -type f | xargs sha1sum > ./$1_sha.txt; }
#-------------------------------------------------------------
# File & strings related functions:
#-------------------------------------------------------------
# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }
# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'"${1:-}"'*' \
-exec ${2:-file} {} \;  ; }
#  Find a pattern in a set of files and highlight them:
#+ (needs a recent version of egrep).
function fstr()
{
    OPTIND=1
    local mycase=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
           i) mycase="-i " ;;
           *) echo "$usage"; return ;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    find . -type f -name "${2:-*}" -print0 | \
xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more

}
# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }
#
function mydf()         # Pretty-print of 'df' output.
{                       # Inspired by 'dfc' utility.
    for fs ; do

        if [ ! -d $fs ]
        then
          echo -e $fs" :No such file or directory" ; continue
        fi

        local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
        local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
        local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
        local out="["
        for ((j=0;j<20;j++)); do
            if [ ${j} -lt ${nbstars} ]; then
               out=$out"*"
            else
               out=$out"-"
            fi
        done
        out=${info[2]}" "$out"] ("$free" free on "$fs")"
        echo -e $out
    done
}

######## ########################################### 
#Extract:
extract () {
  if [ -f $1 ] ; then
        case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
	  *.tar)       tar xvf $1     ;;
	  *.tbz2)      tar xvjf $1    ;;
	  *.tgz)       tar xvzf $1    ;;
	  *.zip)       unzip $1       ;;
	  *.Z)         uncompress $1  ;;
	  *.7z)        7z x $1        ;;
	  *)           echo "don't know how to extract '$1'..." ;;
	esac
  else
		echo "'$1' is not a valid file!"
	fi
}
######## ########################################### 
#command_not_found_handle () {
#    printf "[*] te command not found\n"
#    return 127
#}
