  bash\_cheat\_sheet.sh  \* { background-color: black; font-family: monospace; } body { margin-left: 20px; font-size: 150%; }  

_#!/usr/bin/env bash_

_#variables_
name="John"
_echo_ $name
_echo_ "$name"
_echo_ "${name}!"
_printf_ "Your name is: $name\\n"
_printf_ "Your name is also: %s\\n" "$name"
_echo_ '$name'

_#math_
_echo_ $((1+2))
$((a + 200)) _\# add 200 to $a_
_echo_ $((RANDOM%=200)) _#return a random number from 0..200_

_#shell exec_ 
_echo_ "Current Folder: $(_pwd_)" _#posix_
_echo_ "Current Folder: \`_pwd_\`" _#bashism_

_#redirection_ 

**cat** foo.txt \> bar.txt _#overwrite_
**cat** foo.txt \>> bar.txt _#append_
**cat** foo.txt 2> err.log _#stderr to err.log_
**cat** foo.txt 1> out.log _#stdout to out.log_
**cat** foo.txt 2>&1 _#stderr to stdout_
**cat** foo.txt 2>&1 \> out.log _#stderr & stdout to logfile_
**cat** foo.txt 2> /dev/null _#mute stderr (send to dev null)_
**cat** foo.txt &> /dev/null _#mute stderr & stdout_ 
**cat** foo.txt < bar.txt _\# send bar.txt to stdin_

_#PIPE!_
**cat** foo.txt | **grep** bar _\# pipe stdout of cat to stdin of grep_

_#conditional exection_
_echo_ "this"; _echo_ "then that" _#both run, no matter what_
_echo_ "this" && _echo_ "and that" _#second runs if first returns 0_
_echo_ "this" || _echo_ "or that" _#second runs if first returns not 0_

_\# if then else_
if \[\[ **\-z** "$name" \]\]; then
    _echo_ '$name var is empty'
elif \[\[ **\-n** "$name" \]\]; then
    _echo_ "_\\$_name var contains = _\\"_$name_\\"_"
fi

_#case statement_ 
case "$1" in
    start | up)
        _echo_ "starting..."
        ;;
    end | down | stop)
        _echo_ "stopping..."
        ;;
    reboot)
        _echo_ "rebooting..."
        ;;
    \*)
        _echo_ "Unrecognized command; beginning self-destruct..."
        _echo_ "Usage: $0 {start|up|end|down|stop|reboot}"
        ;;
esac

_#function_
**print\_name()** {
    _echo_ "Bender Bending Rodregiuz"
}

function **echo\_name** {
    _echo_ "Fry"
}
_echo_ "Name: $(**print\_name**)"
_echo_ "Name: $(**echo\_name**)"

function **arguments** {
    _echo_ $# _\# number of arguments_
    _echo_ $\* _\# all arguments, separated by $IFS variable_
    _echo_ $@ _\# all arguments, separated by space_
    _echo_ $? _\# return code_
    _echo_ $$ _\# pid of command_ 
    
    _echo_ $0 _\# name of command_
    _echo_ $1 _\# first argument_
    _echo_ $2 _\# second argument_
    _echo_ $3 _\# etc..._
}

_#braces_ 
_echo_ _{A,B}_.txt _#no spaces_
_echo_ _{A,B}_ _\# echo "A B"_
**ls** _{A,B}_.js _#ls A.js B.js_
_echo_ _{1..5}_ _\# echo "1 2 3 4 5"_

_echo_ ${name}
_echo_ ${name/J/j} _\# substitution "john"_
_echo_ ${name:0:2} _\# slicing "Jo"_
_echo_ ${name::2}  _\# "Jo"_
_echo_ ${name::\-1} _\# "Joh"_
_echo_ ${name:(-1)} _\# slice from end "n"_
_echo_ ${name:(-2):1} _\# "h"_

_#default values_
food="banana"
_echo_ ${food:-Cake} _\# $food or "Cake"_
_unset_ food
_echo_ ${food:-"The cake is a lie"} _\# $food or ..._
_echo_ ${taco:=42} _#set value of $taco_
_echo_ ${taco:+42} _\# return 42 if $taco is set_
_echo_ ${taco:?message} _\# show error message if $taco is not set_

length=2
_echo_ ${name:0:$length} _#slice "Jo"_
_echo_ ${name:0:length}  _\# this too, fucking bashism_

file="/path/to/foo/bar/foo.cpp"
_echo_ ${file%.cpp} _\# "/path/to/foo/bar/foo"_
_echo_ ${file%.cpp}.o  _\# "/path/to/foo/bar/foo.o"_
_echo_ ${file%foo\*} _\# "/path/to/foo/bar/"_
_echo_ ${file%%foo\*} _\# "/path/to/"_
_echo_ ${file#\*/} _\# "path/to/foo/bar/foo.cpp"_
_echo_ ${file##\*/} _\# "foo.cpp"_
_echo_ ${file/foo/taco} _#replace first foo "/path/to/taco/bar/foo.cpp"_
_echo_ ${file//foo/taco} _#replace all foo "/path/to/taco/bar/taco.cpp"_

_echo_ ${file##\*.} _\# ".cpp"_
file\_name=${file##\*/} _\# "foo.cpp"_
file\_path=${file%$file\_name} _\# "/path/to/foo/bar/"_ 

_echo_ ${#file} _\# return length of variable "24"_

scream="HELLO"
whisper="hello"
_echo_ ${scream,} _#lowercase first char_
_echo_ ${scream,,} _#lowercase all chars_
_echo_ ${whisper^} _\# Hello_
_echo_ ${whisper^^} _\# HELLO_

_#loops_
for **file** in /usr/bin/\*; do 
    _echo_ "${file}"
done

for ((i=0;i<100;i++)); do _#c-style_
    _printf_ "$i "
done

for **i** in _{1..5}_; do _#range_
    _echo_ $i
done

for **i** in _{5..50..5}_; do _#step size_
    _echo_ $i
done

_\# test conditionals_ 

_#Strings_
\[\[ **\-z** $string \]\] _\# is empty_
\[\[ **\-n** $string \]\] _\# not empty_
\[\[ $str **\==** $string \]\] 
\[\[ $str **!=** $string \]\]

_#numbers        # C equivilant_ 
\[\[ $a **\-eq** $b \]\] _\# ==_
\[\[ $a **\-ne** $b \]\] _\# !=_
\[\[ $a **\-lt** $b \]\] _\# <_
\[\[ $a **\-le** $b \]\] _\# <=_
\[\[ $a **\-gt** $b \]\] _\# >_
\[\[ $a **\-ge** $b \]\] _\# >=_

_#binary_
\[\[ **!** EXPR \]\] _\# NOT_
\[\[ X \]\] && \[\[ Y \]\] _\# AND_
\[\[ X \]\] || \[\[ Y \]\] _\# OR_

_#file_
\[\[ **\-e** $file \]\] _\# exists_
\[\[ **\-r** $file \]\] _\# readable_
\[\[ **\-h** $file \]\] _\# symlink_
\[\[ **\-d** $file \]\] _\# directory_
\[\[ **\-w** $file \]\] _\# writeable_
\[\[ **\-s** $file \]\] _\# size > 0 bytes_
\[\[ **\-f** $file \]\] _\# regular file_
\[\[ **\-x** $file \]\] _\# is executable_
\[\[ $a **\-nt** $b \]\] _\# newer than_ 
\[\[ $a **\-ot** $b \]\] _\# older than_
\[\[ $a **\-ef** $b \]\] _\# equal files_

_\# arrays_

fruit=('apple', 'grape', 'orange')

fruits\[0\]="apple"
fruits\[1\]="grape"
fruits\[2\]="orange"

Fruits=("${Fruits\[@\]}" "Watermelon")    _\# Push_
Fruits+=('Watermelon')                  _\# Also Push_
Fruits=( ${Fruits\[@\]/Ap\*/} )            _\# Remove by regex match_
_unset_ Fruits\[2\]                         _\# Remove one item_
Fruits=("${Fruits\[@\]}")                 _\# Duplicate_
Fruits=("${Fruits\[@\]}" "${Veggies\[@\]}") _\# Concatenate_
lines=(\`**cat** "logfile"\`)                 _\# Read from file_

_#iteration_
for **i** in "${arrayName\[@\]}"; do
  _echo_ $i
done

_#brackets & arrays_
_echo_ ${Fruits\[0\]}           _\# Element #0_
_echo_ ${Fruits\[@\]}           _\# All elements, space-separated_
_echo_ ${#Fruits\[@\]}          _\# Number of elements_
_echo_ ${#Fruits}             _\# String length of the 1st element_
_echo_ $_{#Fruits\[3\]}_          _\# String length of the Nth element_
_echo_ ${Fruits\[@\]:3:2}       _\# Range (from position 3, length 2)_

_#dictionaries (hash table)_
_declare_ -A sounds

sounds\[dog\]="bark"
sounds\[cow\]="moo"
sounds\[bird\]="tweet"
sounds\[wolf\]="howl"

_echo_ ${sounds\[dog\]} _\# Dog's sound_
_echo_ ${sounds\[@\]}   _\# All values_
_echo_ ${!sounds\[@\]}  _\# All keys_
_echo_ ${#sounds\[@\]}  _\# Number of elements_
_unset_ sounds\[dog\]   _\# Delete dog_

_#iterate over value_
for **val** in "${sounds\[@\]}"; do
  _echo_ $val
done

_#iterate over key_
for **key** in "${!sounds\[@\]}"; do
  _echo_ $key
done

_#parse command line options_
while \[\[ "$1" =~ ^- && **!** "$1" **\==** "--" \]\]; do case $1 in
  -V | --version )
    _echo_ $version
    _exit_
    ;;
  -s | --string )
    _shift_; string=$1
    ;;
  -f | --flag )
    flag=1
    ;;
esac; _shift_; done
if \[\[ "$1" **\==** '--' \]\]; then _shift_; fi

_#get user input_
_echo_ -n "Would you like to play a game? \[yes/no\]: "
_read_ ans
_echo_ $ans

_echo_ -n "How about a nice game of global thermo nuclear war? \[yes/no\]: "
_read_ -n 1 ans _\# just one char (no enter)_
_echo_ $ans



**Converted to Markdown by Dom Christie's wonderful [Turndown](https://github.com/domchristie/turndown)**
