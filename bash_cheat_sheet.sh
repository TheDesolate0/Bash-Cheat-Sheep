#!/usr/bin/env bash

## SOURCE ME! I'M NEAT!
## source ./bash_cheat_sheet.sh

echo <<'EOF'> $bcs_sh
#!/usr/bin/env bash

#variables
name="John"
echo $name
echo "$name"
echo "${name}!"
printf "Your name is: $name\n"
printf "Your name is also: %s\n" "$name"
echo '$name'

#math
echo $((1+2))
$((a + 200)) # add 200 to $a
echo $((RANDOM%=200)) #return a random number from 0..200

#shell exec 
echo "Current Folder: $(pwd)" #posix
echo "Current Folder: `pwd`" #bashism

#redirection 

cat foo.txt > bar.txt #overwrite
cat foo.txt >> bar.txt #append
cat foo.txt 2> err.log #stderr to err.log
cat foo.txt 1> out.log #stdout to out.log
cat foo.txt 2>&1 #stderr to stdout
cat foo.txt 2>&1 > out.log #stderr & stdout to logfile
cat foo.txt 2> /dev/null #mute stderr (send to dev null)
cat foo.txt &> /dev/null #mute stderr & stdout 
cat foo.txt < bar.txt # send bar.txt to stdin

#PIPE!
cat foo.txt | grep bar # pipe stdout of cat to stdin of grep


#conditional exection
echo "this"; echo "then that" #both run, no matter what
echo "this" && echo "and that" #second runs if first returns 0
echo "this" || echo "or that" #second runs if first returns not 0

# if then else
if [[ -z "$name" ]]; then
    echo '$name var is empty'
elif [[ -n "$name" ]]; then
    echo "\$name var contains = \"$name\""
else
    echo "Yarr!"
fi

#case statement 
case "$1" in
    start | up)
        echo "starting..."
        ;;
    end | down | stop)
        echo "stopping..."
        ;;
    reboot)
        echo "rebooting..."
        ;;
    *)
        echo "Unrecognized command; beginning self-destruct..."
        echo "Usage: $0 {start|up|end|down|stop|reboot}"
        ;;
esac

#function
print_name() {
    echo "Bender Bending Rodregiuz"
}

function echo_name {
    echo "Fry"
}
echo "Name: $(print_name)"
echo "Name: $(echo_name)"

function arguments {
    echo $# # number of arguments
    echo $* # all arguments, separated by $IFS variable
    echo $@ # all arguments, separated by space
    echo $? # return code
    echo $$ # pid of command 
    
    echo $0 # name of command
    echo $1 # first argument
    echo $2 # second argument
    echo $3 # etc...
}

#braces 
echo {A,B}.txt #no spaces
echo {A,B} # echo "A B"
ls {A,B}.js #ls A.js B.js
echo {1..5} # echo "1 2 3 4 5"

echo ${name}
echo ${name/J/j} # substitution "john"
echo ${name:0:2} # slicing "Jo"
echo ${name::2}  # "Jo"
echo ${name::-1} # "Joh"
echo ${name:(-1)} # slice from end "n"
echo ${name:(-2):1} # "h"

#default values
food="banana"
echo ${food:-Cake} # $food or "Cake"
unset food
echo ${food:-"The cake is a lie"} # $food or ...
echo ${taco:=42} #set value of $taco
echo ${taco:+42} # return 42 if $taco is set
echo ${taco:?message} # show error message if $taco is not set

length=2
echo ${name:0:$length} #slice "Jo"
echo ${name:0:length}  # this too, fucking bashism

file="/path/to/foo/bar/foo.cpp"
echo ${file%.cpp} # "/path/to/foo/bar/foo"
echo ${file%.cpp}.o  # "/path/to/foo/bar/foo.o"
echo ${file%foo*} # "/path/to/foo/bar/"
echo ${file%%foo*} # "/path/to/"
echo ${file#*/} # "path/to/foo/bar/foo.cpp"
echo ${file##*/} # "foo.cpp"
echo ${file/foo/taco} #replace first foo "/path/to/taco/bar/foo.cpp"
echo ${file//foo/taco} #replace all foo "/path/to/taco/bar/taco.cpp"

echo ${file##*.} # ".cpp"
file_name=${file##*/} # "foo.cpp"
file_path=${file%$file_name} # "/path/to/foo/bar/" 

echo ${#file} # return length of variable "24"

scream="HELLO"
whisper="hello"
echo ${scream,} #lowercase first char
echo ${scream,,} #lowercase all chars
echo ${whisper^} # Hello
echo ${whisper^^} # HELLO

#loops
for file in /usr/bin/*; do 
    echo "${file}"
done

for ((i=0;i<100;i++)); do #c-style
    printf "$i "
done

for i in {1..5}; do #range
    echo $i
done

for i in {5..50..5}; do #step size
    echo $i
done


# test conditionals 

#Strings
[[ -z $string ]] # is empty
[[ -n $string ]] # not empty
[[ $str == $string ]] 
[[ $str != $string ]]

#numbers        # C equivilant    
[[ $a -eq $b ]] # ==
[[ $a -ne $b ]] # !=
[[ $a -lt $b ]] # <
[[ $a -le $b ]] # <=
[[ $a -gt $b ]] # >
[[ $a -ge $b ]] # >=

#binary
[[ ! EXPR ]] # NOT
[[ X ]] && [[ Y ]] # AND
[[ X ]] || [[ Y ]] # OR

#file
[[ -e $file ]] # exists
[[ -r $file ]] # readable
[[ -h $file ]] # symlink
[[ -d $file ]] # directory
[[ -w $file ]] # writeable
[[ -s $file ]] # size > 0 bytes
[[ -f $file ]] # regular file
[[ -x $file ]] # is executable
[[ $a -nt $b ]] # newer than 
[[ $a -ot $b ]] # older than
[[ $a -ef $b ]] # equal files

# arrays

fruit=('apple', 'grape', 'orange')

fruits[0]="apple"
fruits[1]="grape"
fruits[2]="orange"

Fruits=("${Fruits[@]}" "Watermelon")    # Push
Fruits+=('Watermelon')                  # Also Push
Fruits=( ${Fruits[@]/Ap*/} )            # Remove by regex match
unset Fruits[2]                         # Remove one item
Fruits=("${Fruits[@]}")                 # Duplicate
Fruits=("${Fruits[@]}" "${Veggies[@]}") # Concatenate
lines=(`cat "logfile"`)                 # Read from file


#iteration
for i in "${arrayName[@]}"; do
  echo $i
done

#brackets & arrays
echo ${Fruits[0]}           # Element #0
echo ${Fruits[@]}           # All elements, space-separated
echo ${#Fruits[@]}          # Number of elements
echo ${#Fruits}             # String length of the 1st element
echo ${#Fruits[3]}          # String length of the Nth element
echo ${Fruits[@]:3:2}       # Range (from position 3, length 2)

#dictionaries (hash table)
declare -A sounds

sounds[dog]="bark"
sounds[cow]="moo"
sounds[bird]="tweet"
sounds[wolf]="howl"

echo ${sounds[dog]} # Dog's sound
echo ${sounds[@]}   # All values
echo ${!sounds[@]}  # All keys
echo ${#sounds[@]}  # Number of elements
unset sounds[dog]   # Delete dog

#iterate over value
for val in "${sounds[@]}"; do
  echo $val
done

#iterate over key
for key in "${!sounds[@]}"; do
  echo $key
done

#parse command line options
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -V | --version )
    echo $version
    exit
    ;;
  -s | --string )
    shift; string=$1
    ;;
  -f | --flag )
    flag=1
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi

#get user input
echo -n "Would you like to play a game? [yes/no]: "
read ans
echo $ans

echo -n "How about a nice game of global thermo nuclear war? [yes/no]: "
read -n 1 ans # just one char (no enter)
echo $ans

EOF 
## END $bcs_sh

echo <<'EOF' > $bcs_html
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Generator" content="Kate, the KDE Advanced Text Editor" />
<title>bash_cheat_sheet.sh</title>
<style>
    * {
        background-color: black;
        font-family: monospace;
    }
    
    body {
        margin-left: 20px;
        font-size: 150%;
    }
</style>
</head>
<!-- Highlighting: "Bash" -->
<body>
<pre style='color:#d0d0d0;background-color:#000000;'>
<i><span style='color:#f67400;'>#!/usr/bin/env bash</span></i>

<i><span style='color:#f67400;'>#variables</span></i>
<span style='color:#2980b9;'>name=</span><span style='color:#00ff7f;'>&quot;John&quot;</span>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$name</span>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>$name</span><span style='color:#00ff7f;'>&quot;</span>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>${name}</span><span style='color:#00ff7f;'>!&quot;</span>
<i><span style='color:#aa557f;'>printf</span></i> <span style='color:#00ff7f;'>&quot;Your name is: </span><span style='color:#2980b9;'>$name</span><span style='color:#00ff7f;'>\n&quot;</span>
<i><span style='color:#aa557f;'>printf</span></i> <span style='color:#00ff7f;'>&quot;Your name is also: %s\n&quot;</span> <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>$name</span><span style='color:#00ff7f;'>&quot;</span>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>'$name'</span>

<i><span style='color:#f67400;'>#math</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$((</span>1+2<span style='color:#2980b9;'>))</span>
<span style='color:#2980b9;'>$((</span>a + 200<span style='color:#2980b9;'>))</span> <i><span style='color:#f67400;'># add 200 to $a</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$((</span>RANDOM%=200<span style='color:#2980b9;'>))</span> <i><span style='color:#f67400;'>#return a random number from 0..200</span></i>

<i><span style='color:#f67400;'>#shell exec </span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;Current Folder: </span><span style='color:#2980b9;'>$(</span><i><span style='color:#aa557f;'>pwd</span></i><span style='color:#2980b9;'>)</span><span style='color:#00ff7f;'>&quot;</span> <i><span style='color:#f67400;'>#posix</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;Current Folder: </span><span style='color:#00ffff;'>`</span><i><span style='color:#aa557f;'>pwd</span></i><span style='color:#00ffff;'>`</span><span style='color:#00ff7f;'>&quot;</span> <i><span style='color:#f67400;'>#bashism</span></i>

<i><span style='color:#f67400;'>#redirection </span></i>

<b><span style='color:#aa557f;'>cat</span></b> foo.txt <span style='color:#ffffff;'>&gt;</span> bar.txt <i><span style='color:#f67400;'>#overwrite</span></i>
<b><span style='color:#aa557f;'>cat</span></b> foo.txt <span style='color:#ffffff;'>&gt;&gt;</span> bar.txt <i><span style='color:#f67400;'>#append</span></i>
<b><span style='color:#aa557f;'>cat</span></b> foo.txt <span style='color:#ffffff;'>2&gt;</span> err.log <i><span style='color:#f67400;'>#stderr to err.log</span></i>
<b><span style='color:#aa557f;'>cat</span></b> foo.txt <span style='color:#ffffff;'>1&gt;</span> out.log <i><span style='color:#f67400;'>#stdout to out.log</span></i>
<b><span style='color:#aa557f;'>cat</span></b> foo.txt <span style='color:#ffffff;'>2&gt;&amp;1</span> <i><span style='color:#f67400;'>#stderr to stdout</span></i>
<b><span style='color:#aa557f;'>cat</span></b> foo.txt <span style='color:#ffffff;'>2&gt;&amp;1</span> <span style='color:#ffffff;'>&gt;</span> out.log <i><span style='color:#f67400;'>#stderr &amp; stdout to logfile</span></i>
<b><span style='color:#aa557f;'>cat</span></b> foo.txt <span style='color:#ffffff;'>2&gt;</span> /dev/null <i><span style='color:#f67400;'>#mute stderr (send to dev null)</span></i>
<b><span style='color:#aa557f;'>cat</span></b> foo.txt <span style='color:#ffffff;'>&amp;&gt;</span> /dev/null <i><span style='color:#f67400;'>#mute stderr &amp; stdout </span></i>
<b><span style='color:#aa557f;'>cat</span></b> foo.txt <span style='color:#ffffff;'>&lt;</span> bar.txt <i><span style='color:#f67400;'># send bar.txt to stdin</span></i>

<i><span style='color:#f67400;'>#PIPE!</span></i>
<b><span style='color:#aa557f;'>cat</span></b> foo.txt <span style='color:#00ffff;'>|</span> <b><span style='color:#aa557f;'>grep</span></b> bar <i><span style='color:#f67400;'># pipe stdout of cat to stdin of grep</span></i>


<i><span style='color:#f67400;'>#conditional exection</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;this&quot;</span><span style='color:#00ffff;'>;</span> <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;then that&quot;</span> <i><span style='color:#f67400;'>#both run, no matter what</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;this&quot;</span> <span style='color:#00ffff;'>&amp;&amp;</span> <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;and that&quot;</span> <i><span style='color:#f67400;'>#second runs if first returns 0</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;this&quot;</span> <span style='color:#00ffff;'>||</span> <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;or that&quot;</span> <i><span style='color:#f67400;'>#second runs if first returns not 0</span></i>

<i><span style='color:#f67400;'># if then else</span></i>
<span style='color:#00ffff;'>if</span><span style='color:#00ffff;'> [[</span> <b><span style='color:#aaff00;'>-z</span></b> <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>$name</span><span style='color:#00ff7f;'>&quot;</span><span style='color:#00ffff;'> ]]</span>; <span style='color:#00ffff;'>then</span>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>'$name var is empty'</span>
<span style='color:#00ffff;'>elif [[</span> <b><span style='color:#aaff00;'>-n</span></b> <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>$name</span><span style='color:#00ff7f;'>&quot;</span><span style='color:#00ffff;'> ]]</span>; <span style='color:#00ffff;'>then</span>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;</span><i><span style='color:#ff00ff;'>\$</span></i><span style='color:#00ff7f;'>name var contains = </span><i><span style='color:#ff00ff;'>\&quot;</span></i><span style='color:#2980b9;'>$name</span><i><span style='color:#ff00ff;'>\&quot;</span></i><span style='color:#00ff7f;'>&quot;</span>
<span style='color:#00ffff;'>fi</span>

<i><span style='color:#f67400;'>#case statement </span></i>
<span style='color:#00ffff;'>case</span> <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>$1</span><span style='color:#00ff7f;'>&quot;</span><span style='color:#00ffff;'> in</span>
    start <span style='color:#00ffff;'>|</span> up<span style='color:#00ffff;'>)</span>
        <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;starting...&quot;</span>
        <span style='color:#00ffff;'>;;</span>
    end <span style='color:#00ffff;'>|</span> down <span style='color:#00ffff;'>|</span> stop<span style='color:#00ffff;'>)</span>
        <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;stopping...&quot;</span>
        <span style='color:#00ffff;'>;;</span>
    reboot<span style='color:#00ffff;'>)</span>
        <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;rebooting...&quot;</span>
        <span style='color:#00ffff;'>;;</span>
    *<span style='color:#00ffff;'>)</span>
        <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;Unrecognized command; beginning self-destruct...&quot;</span>
        <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;Usage: </span><span style='color:#2980b9;'>$0</span><span style='color:#00ff7f;'> {start|up|end|down|stop|reboot}&quot;</span>
        <span style='color:#00ffff;'>;;</span>
<span style='color:#00ffff;'>esac</span>

<i><span style='color:#f67400;'>#function</span></i>
<b><span style='color:#aa557f;'>print_name()</span></b> <span style='color:#00ffff;'>{</span>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;Bender Bending Rodregiuz&quot;</span>
<span style='color:#00ffff;'>}</span>

<span style='color:#00ffff;'>function</span><b><span style='color:#aa557f;'> echo_name</span></b> <span style='color:#00ffff;'>{</span>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;Fry&quot;</span>
<span style='color:#00ffff;'>}</span>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;Name: </span><span style='color:#2980b9;'>$(</span><b><span style='color:#0095ff;'>print_name</span></b><span style='color:#2980b9;'>)</span><span style='color:#00ff7f;'>&quot;</span>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;Name: </span><span style='color:#2980b9;'>$(</span><b><span style='color:#0095ff;'>echo_name</span></b><span style='color:#2980b9;'>)</span><span style='color:#00ff7f;'>&quot;</span>

<span style='color:#00ffff;'>function</span><b><span style='color:#aa557f;'> arguments</span></b> <span style='color:#00ffff;'>{</span>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$#</span> <i><span style='color:#f67400;'># number of arguments</span></i>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$*</span> <i><span style='color:#f67400;'># all arguments, separated by $IFS variable</span></i>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$@</span> <i><span style='color:#f67400;'># all arguments, separated by space</span></i>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$?</span> <i><span style='color:#f67400;'># return code</span></i>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$$</span> <i><span style='color:#f67400;'># pid of command </span></i>
    
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$0</span> <i><span style='color:#f67400;'># name of command</span></i>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$1</span> <i><span style='color:#f67400;'># first argument</span></i>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$2</span> <i><span style='color:#f67400;'># second argument</span></i>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$3</span> <i><span style='color:#f67400;'># etc...</span></i>
<span style='color:#00ffff;'>}</span>

<i><span style='color:#f67400;'>#braces </span></i>
<i><span style='color:#aa557f;'>echo</span></i> <i><span style='color:#ff00ff;'>{A,B}</span></i>.txt <i><span style='color:#f67400;'>#no spaces</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <i><span style='color:#ff00ff;'>{A,B}</span></i> <i><span style='color:#f67400;'># echo &quot;A B&quot;</span></i>
<b><span style='color:#aa557f;'>ls</span></b> <i><span style='color:#ff00ff;'>{A,B}</span></i>.js <i><span style='color:#f67400;'>#ls A.js B.js</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <i><span style='color:#ff00ff;'>{1..5}</span></i> <i><span style='color:#f67400;'># echo &quot;1 2 3 4 5&quot;</span></i>

<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${name}</span>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${name/</span>J<span style='color:#2980b9;'>/</span>j<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># substitution &quot;john&quot;</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${name:0:2}</span> <i><span style='color:#f67400;'># slicing &quot;Jo&quot;</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${name::2}</span>  <i><span style='color:#f67400;'># &quot;Jo&quot;</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${name::</span><span style='color:#da4453;'>-</span><span style='color:#2980b9;'>1}</span> <i><span style='color:#f67400;'># &quot;Joh&quot;</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${name:</span><span style='color:#da4453;'>(-1)</span><span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># slice from end &quot;n&quot;</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${name:</span><span style='color:#da4453;'>(-2)</span><span style='color:#2980b9;'>:1}</span> <i><span style='color:#f67400;'># &quot;h&quot;</span></i>

<i><span style='color:#f67400;'>#default values</span></i>
<span style='color:#2980b9;'>food=</span><span style='color:#00ff7f;'>&quot;banana&quot;</span>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${food:-</span>Cake<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># $food or &quot;Cake&quot;</span></i>
<i><span style='color:#aa557f;'>unset</span></i> <span style='color:#2980b9;'>food</span>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${food:-</span><span style='color:#00ff7f;'>&quot;The cake is a lie&quot;</span><span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># $food or ...</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${taco:=</span>42<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'>#set value of $taco</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${taco:+</span>42<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># return 42 if $taco is set</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${taco:?</span>message<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># show error message if $taco is not set</span></i>

<span style='color:#2980b9;'>length=</span>2
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${name:0:$length}</span> <i><span style='color:#f67400;'>#slice &quot;Jo&quot;</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${name:0:length}</span>  <i><span style='color:#f67400;'># this too, fucking bashism</span></i>

<span style='color:#2980b9;'>file=</span><span style='color:#00ff7f;'>&quot;/path/to/foo/bar/foo.cpp&quot;</span>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${file%</span>.cpp<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># &quot;/path/to/foo/bar/foo&quot;</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${file%</span>.cpp<span style='color:#2980b9;'>}</span>.o  <i><span style='color:#f67400;'># &quot;/path/to/foo/bar/foo.o&quot;</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${file%</span>foo*<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># &quot;/path/to/foo/bar/&quot;</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${file%%</span>foo*<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># &quot;/path/to/&quot;</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${file#</span>*/<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># &quot;path/to/foo/bar/foo.cpp&quot;</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${file##</span>*/<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># &quot;foo.cpp&quot;</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${file/</span>foo<span style='color:#2980b9;'>/</span>taco<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'>#replace first foo &quot;/path/to/taco/bar/foo.cpp&quot;</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${file//</span>foo<span style='color:#2980b9;'>/</span>taco<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'>#replace all foo &quot;/path/to/taco/bar/taco.cpp&quot;</span></i>

<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${file##</span>*.<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># &quot;.cpp&quot;</span></i>
<span style='color:#2980b9;'>file_name=${file##</span>*/<span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># &quot;foo.cpp&quot;</span></i>
<span style='color:#2980b9;'>file_path=${file%$file_name}</span> <i><span style='color:#f67400;'># &quot;/path/to/foo/bar/&quot; </span></i>

<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${#file}</span> <i><span style='color:#f67400;'># return length of variable &quot;24&quot;</span></i>

<span style='color:#2980b9;'>scream=</span><span style='color:#00ff7f;'>&quot;HELLO&quot;</span>
<span style='color:#2980b9;'>whisper=</span><span style='color:#00ff7f;'>&quot;hello&quot;</span>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${scream</span><span style='color:#da4453;'>,</span><span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'>#lowercase first char</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${scream</span><span style='color:#da4453;'>,,</span><span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'>#lowercase all chars</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${whisper</span><span style='color:#da4453;'>^</span><span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># Hello</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${whisper</span><span style='color:#da4453;'>^^</span><span style='color:#2980b9;'>}</span> <i><span style='color:#f67400;'># HELLO</span></i>

<i><span style='color:#f67400;'>#loops</span></i>
<span style='color:#00ffff;'>for</span> <b><span style='color:#aa557f;'>file</span></b> in /usr/bin/*<span style='color:#00ffff;'>;</span> <span style='color:#00ffff;'>do</span> 
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>${file}</span><span style='color:#00ff7f;'>&quot;</span>
<span style='color:#00ffff;'>done</span>

<span style='color:#00ffff;'>for</span> <span style='color:#00ffff;'>((</span>i=0;i&lt;100;i++<span style='color:#00ffff;'>))</span>; <span style='color:#00ffff;'>do</span> <i><span style='color:#f67400;'>#c-style</span></i>
    <i><span style='color:#aa557f;'>printf</span></i> <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>$i</span><span style='color:#00ff7f;'> &quot;</span>
<span style='color:#00ffff;'>done</span>

<span style='color:#00ffff;'>for</span> <b><span style='color:#0095ff;'>i</span></b> in <i><span style='color:#ff00ff;'>{1..5}</span></i><span style='color:#00ffff;'>;</span> <span style='color:#00ffff;'>do</span> <i><span style='color:#f67400;'>#range</span></i>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$i</span>
<span style='color:#00ffff;'>done</span>

<span style='color:#00ffff;'>for</span> <b><span style='color:#0095ff;'>i</span></b> in <i><span style='color:#ff00ff;'>{5..50..5}</span></i><span style='color:#00ffff;'>;</span> <span style='color:#00ffff;'>do</span> <i><span style='color:#f67400;'>#step size</span></i>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$i</span>
<span style='color:#00ffff;'>done</span>


<i><span style='color:#f67400;'># test conditionals </span></i>

<i><span style='color:#f67400;'>#Strings</span></i>
<span style='color:#00ffff;'>[[</span> <b><span style='color:#aaff00;'>-z</span></b> <span style='color:#2980b9;'>$string</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># is empty</span></i>
<span style='color:#00ffff;'>[[</span> <b><span style='color:#aaff00;'>-n</span></b> <span style='color:#2980b9;'>$string</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># not empty</span></i>
<span style='color:#00ffff;'>[[</span> <span style='color:#2980b9;'>$str</span> <b><span style='color:#aaff00;'>==</span></b> <span style='color:#2980b9;'>$string</span><span style='color:#00ffff;'> ]]</span> 
<span style='color:#00ffff;'>[[</span> <span style='color:#2980b9;'>$str</span> <b><span style='color:#aaff00;'>!=</span></b> <span style='color:#2980b9;'>$string</span><span style='color:#00ffff;'> ]]</span>

<i><span style='color:#f67400;'>#numbers        # C equivilant    </span></i>
<span style='color:#00ffff;'>[[</span> <span style='color:#2980b9;'>$a</span> <b><span style='color:#aaff00;'>-eq</span></b> <span style='color:#2980b9;'>$b</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># ==</span></i>
<span style='color:#00ffff;'>[[</span> <span style='color:#2980b9;'>$a</span> <b><span style='color:#aaff00;'>-ne</span></b> <span style='color:#2980b9;'>$b</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># !=</span></i>
<span style='color:#00ffff;'>[[</span> <span style='color:#2980b9;'>$a</span> <b><span style='color:#aaff00;'>-lt</span></b> <span style='color:#2980b9;'>$b</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># &lt;</span></i>
<span style='color:#00ffff;'>[[</span> <span style='color:#2980b9;'>$a</span> <b><span style='color:#aaff00;'>-le</span></b> <span style='color:#2980b9;'>$b</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># &lt;=</span></i>
<span style='color:#00ffff;'>[[</span> <span style='color:#2980b9;'>$a</span> <b><span style='color:#aaff00;'>-gt</span></b> <span style='color:#2980b9;'>$b</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># &gt;</span></i>
<span style='color:#00ffff;'>[[</span> <span style='color:#2980b9;'>$a</span> <b><span style='color:#aaff00;'>-ge</span></b> <span style='color:#2980b9;'>$b</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># &gt;=</span></i>

<i><span style='color:#f67400;'>#binary</span></i>
<span style='color:#00ffff;'>[[</span> <b><span style='color:#aaff00;'>!</span></b> EXPR<span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># NOT</span></i>
<span style='color:#00ffff;'>[[</span> X<span style='color:#00ffff;'> ]]</span> <span style='color:#00ffff;'>&amp;&amp;</span><span style='color:#00ffff;'> [[</span> Y<span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># AND</span></i>
<span style='color:#00ffff;'>[[</span> X<span style='color:#00ffff;'> ]]</span> <span style='color:#00ffff;'>||</span><span style='color:#00ffff;'> [[</span> Y<span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># OR</span></i>

<i><span style='color:#f67400;'>#file</span></i>
<span style='color:#00ffff;'>[[</span> <b><span style='color:#aaff00;'>-e</span></b> <span style='color:#2980b9;'>$file</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># exists</span></i>
<span style='color:#00ffff;'>[[</span> <b><span style='color:#aaff00;'>-r</span></b> <span style='color:#2980b9;'>$file</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># readable</span></i>
<span style='color:#00ffff;'>[[</span> <b><span style='color:#aaff00;'>-h</span></b> <span style='color:#2980b9;'>$file</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># symlink</span></i>
<span style='color:#00ffff;'>[[</span> <b><span style='color:#aaff00;'>-d</span></b> <span style='color:#2980b9;'>$file</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># directory</span></i>
<span style='color:#00ffff;'>[[</span> <b><span style='color:#aaff00;'>-w</span></b> <span style='color:#2980b9;'>$file</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># writeable</span></i>
<span style='color:#00ffff;'>[[</span> <b><span style='color:#aaff00;'>-s</span></b> <span style='color:#2980b9;'>$file</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># size &gt; 0 bytes</span></i>
<span style='color:#00ffff;'>[[</span> <b><span style='color:#aaff00;'>-f</span></b> <span style='color:#2980b9;'>$file</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># regular file</span></i>
<span style='color:#00ffff;'>[[</span> <b><span style='color:#aaff00;'>-x</span></b> <span style='color:#2980b9;'>$file</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># is executable</span></i>
<span style='color:#00ffff;'>[[</span> <span style='color:#2980b9;'>$a</span> <b><span style='color:#aaff00;'>-nt</span></b> <span style='color:#2980b9;'>$b</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># newer than </span></i>
<span style='color:#00ffff;'>[[</span> <span style='color:#2980b9;'>$a</span> <b><span style='color:#aaff00;'>-ot</span></b> <span style='color:#2980b9;'>$b</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># older than</span></i>
<span style='color:#00ffff;'>[[</span> <span style='color:#2980b9;'>$a</span> <b><span style='color:#aaff00;'>-ef</span></b> <span style='color:#2980b9;'>$b</span><span style='color:#00ffff;'> ]]</span> <i><span style='color:#f67400;'># equal files</span></i>

<i><span style='color:#f67400;'># arrays</span></i>

<span style='color:#2980b9;'>fruit=(</span><span style='color:#00ff7f;'>'apple'</span>, <span style='color:#00ff7f;'>'grape'</span>, <span style='color:#00ff7f;'>'orange'</span><span style='color:#2980b9;'>)</span>

<span style='color:#2980b9;'>fruits[0]=</span><span style='color:#00ff7f;'>&quot;apple&quot;</span>
<span style='color:#2980b9;'>fruits[1]=</span><span style='color:#00ff7f;'>&quot;grape&quot;</span>
<span style='color:#2980b9;'>fruits[2]=</span><span style='color:#00ff7f;'>&quot;orange&quot;</span>

<span style='color:#2980b9;'>Fruits=(</span><span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>${Fruits[@]}</span><span style='color:#00ff7f;'>&quot;</span> <span style='color:#00ff7f;'>&quot;Watermelon&quot;</span><span style='color:#2980b9;'>)</span>    <i><span style='color:#f67400;'># Push</span></i>
<span style='color:#2980b9;'>Fruits+=(</span><span style='color:#00ff7f;'>'Watermelon'</span><span style='color:#2980b9;'>)</span>                  <i><span style='color:#f67400;'># Also Push</span></i>
<span style='color:#2980b9;'>Fruits=(</span> <span style='color:#2980b9;'>${Fruits[@]/</span>Ap*<span style='color:#2980b9;'>/}</span> <span style='color:#2980b9;'>)</span>            <i><span style='color:#f67400;'># Remove by regex match</span></i>
<i><span style='color:#aa557f;'>unset</span></i> <span style='color:#2980b9;'>Fruits[2]</span>                         <i><span style='color:#f67400;'># Remove one item</span></i>
<span style='color:#2980b9;'>Fruits=(</span><span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>${Fruits[@]}</span><span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>)</span>                 <i><span style='color:#f67400;'># Duplicate</span></i>
<span style='color:#2980b9;'>Fruits=(</span><span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>${Fruits[@]}</span><span style='color:#00ff7f;'>&quot;</span> <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>${Veggies[@]}</span><span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>)</span> <i><span style='color:#f67400;'># Concatenate</span></i>
<span style='color:#2980b9;'>lines=(</span><span style='color:#00ffff;'>`</span><b><span style='color:#aa557f;'>cat</span></b> <span style='color:#00ff7f;'>&quot;logfile&quot;</span><span style='color:#00ffff;'>`</span><span style='color:#2980b9;'>)</span>                 <i><span style='color:#f67400;'># Read from file</span></i>


<i><span style='color:#f67400;'>#iteration</span></i>
<span style='color:#00ffff;'>for</span> <b><span style='color:#0095ff;'>i</span></b> in <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>${arrayName[@]}</span><span style='color:#00ff7f;'>&quot;</span><span style='color:#00ffff;'>;</span> <span style='color:#00ffff;'>do</span>
  <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$i</span>
<span style='color:#00ffff;'>done</span>

<i><span style='color:#f67400;'>#brackets &amp; arrays</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${Fruits[0]}</span>           <i><span style='color:#f67400;'># Element #0</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${Fruits[@]}</span>           <i><span style='color:#f67400;'># All elements, space-separated</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${#Fruits[@]}</span>          <i><span style='color:#f67400;'># Number of elements</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${#Fruits}</span>             <i><span style='color:#f67400;'># String length of the 1st element</span></i>
<i><span style='color:#aa557f;'>echo</span></i> $<i><span style='color:#ff00ff;'>{#Fruits[3]}</span></i>          <i><span style='color:#f67400;'># String length of the Nth element</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${Fruits[@]:3:2}</span>       <i><span style='color:#f67400;'># Range (from position 3, length 2)</span></i>

<i><span style='color:#f67400;'>#dictionaries (hash table)</span></i>
<i><span style='color:#aa557f;'>declare</span></i> -A <span style='color:#2980b9;'>sounds</span>

<span style='color:#2980b9;'>sounds[dog]=</span><span style='color:#00ff7f;'>&quot;bark&quot;</span>
<span style='color:#2980b9;'>sounds[cow]=</span><span style='color:#00ff7f;'>&quot;moo&quot;</span>
<span style='color:#2980b9;'>sounds[bird]=</span><span style='color:#00ff7f;'>&quot;tweet&quot;</span>
<span style='color:#2980b9;'>sounds[wolf]=</span><span style='color:#00ff7f;'>&quot;howl&quot;</span>

<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${sounds[dog]}</span> <i><span style='color:#f67400;'># Dog's sound</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${sounds[@]}</span>   <i><span style='color:#f67400;'># All values</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${!sounds[@]}</span>  <i><span style='color:#f67400;'># All keys</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>${#sounds[@]}</span>  <i><span style='color:#f67400;'># Number of elements</span></i>
<i><span style='color:#aa557f;'>unset</span></i> <span style='color:#2980b9;'>sounds[dog]</span>   <i><span style='color:#f67400;'># Delete dog</span></i>

<i><span style='color:#f67400;'>#iterate over value</span></i>
<span style='color:#00ffff;'>for</span> <b><span style='color:#0095ff;'>val</span></b> in <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>${sounds[@]}</span><span style='color:#00ff7f;'>&quot;</span><span style='color:#00ffff;'>;</span> <span style='color:#00ffff;'>do</span>
  <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$val</span>
<span style='color:#00ffff;'>done</span>

<i><span style='color:#f67400;'>#iterate over key</span></i>
<span style='color:#00ffff;'>for</span> <b><span style='color:#0095ff;'>key</span></b> in <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>${!sounds[@]}</span><span style='color:#00ff7f;'>&quot;</span><span style='color:#00ffff;'>;</span> <span style='color:#00ffff;'>do</span>
  <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$key</span>
<span style='color:#00ffff;'>done</span>

<i><span style='color:#f67400;'>#parse command line options</span></i>
<span style='color:#00ffff;'>while [[</span> <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>$1</span><span style='color:#00ff7f;'>&quot;</span> =~ ^- &amp;&amp; <b><span style='color:#aaff00;'>!</span></b> <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>$1</span><span style='color:#00ff7f;'>&quot;</span> <b><span style='color:#aaff00;'>==</span></b> <span style='color:#00ff7f;'>&quot;--&quot;</span><span style='color:#00ffff;'> ]]</span>; <span style='color:#00ffff;'>do</span> <span style='color:#00ffff;'>case</span> <span style='color:#2980b9;'>$1</span><span style='color:#00ffff;'> in</span>
  -V <span style='color:#00ffff;'>|</span> --version <span style='color:#00ffff;'>)</span>
    <i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$version</span>
    <i><span style='color:#aa557f;'>exit</span></i>
    <span style='color:#00ffff;'>;;</span>
  -s <span style='color:#00ffff;'>|</span> --string <span style='color:#00ffff;'>)</span>
    <i><span style='color:#aa557f;'>shift</span></i><span style='color:#00ffff;'>;</span> <span style='color:#2980b9;'>string=$1</span>
    <span style='color:#00ffff;'>;;</span>
  -f <span style='color:#00ffff;'>|</span> --flag <span style='color:#00ffff;'>)</span>
    <span style='color:#2980b9;'>flag=</span>1
    <span style='color:#00ffff;'>;;</span>
<span style='color:#00ffff;'>esac</span>; <i><span style='color:#aa557f;'>shift</span></i><span style='color:#00ffff;'>;</span> <span style='color:#00ffff;'>done</span>
<span style='color:#00ffff;'>if</span><span style='color:#00ffff;'> [[</span> <span style='color:#00ff7f;'>&quot;</span><span style='color:#2980b9;'>$1</span><span style='color:#00ff7f;'>&quot;</span> <b><span style='color:#aaff00;'>==</span></b> <span style='color:#00ff7f;'>'--'</span><span style='color:#00ffff;'> ]]</span>; <span style='color:#00ffff;'>then</span> <i><span style='color:#aa557f;'>shift</span></i><span style='color:#00ffff;'>;</span> <span style='color:#00ffff;'>fi</span>

<i><span style='color:#f67400;'>#get user input</span></i>
<i><span style='color:#aa557f;'>echo</span></i> -n <span style='color:#00ff7f;'>&quot;Would you like to play a game? [yes/no]: &quot;</span>
<i><span style='color:#aa557f;'>read</span></i> <span style='color:#2980b9;'>ans</span>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$ans</span>

<i><span style='color:#aa557f;'>echo</span></i> -n <span style='color:#00ff7f;'>&quot;How about a nice game of global thermo nuclear war? [yes/no]: &quot;</span>
<i><span style='color:#aa557f;'>read</span></i> -n 1 <span style='color:#2980b9;'>ans</span> <i><span style='color:#f67400;'># just one char (no enter)</span></i>
<i><span style='color:#aa557f;'>echo</span></i> <span style='color:#2980b9;'>$ans</span>
</pre>
</body>
</html>

'EOF'
## END $bcs_html

function show_cheat {
    doc_base="${HOME}/Documents/bash_cheat_sheet" # don't need this 
    bat=$(which bat)
    less=$(which less)
    more=$(which more)
    hd=$(which hd)
    firefox=$(which firefox)
    lynx=$(which lynx)
    links=$(which links)
    w3m=$(which w3m)
    cat=$(which cat)
    netcat=$(which netcat)
    nc=$(which nc)

    #defaults
    viewer=$cat
    doc_file=$bcs_sh
    web_viewer=$cat
    text_viewer=$cat

    if [[ -n $bat ]]; then
        text_viewer=$bat
    elif [[ -n $less ]]; then
        text_viewer=$less
    elif [[ -n $more ]]; then
        text_viewer=$more
    else
        text_viewer=$cat
    fi

    if [[ -n $firefox ]]; then
        web_viewer=$firefox
    elif [[ -n $links2 ]]; then
        web_viewer=$links2
    elif [[ -n $w3m ]]; then
        web_viewer=$w3m
    elif [[ -n $lynx ]]; then
        web_viewer=$lynx
    else
        echo "You poor bastard"
        web_viewer=$text_viewer
    fi

    case "$1" in
        help | --help | -h | h | -\? | wtf)
            echo "Usage $0 [html|lynx|links|links2|grafux|w3m|firefox|bat|cat|hat|rat|less|more|hd]"
        ;;
        lynx)
            doc_file=$bcs_html
            viewer="$lynx"
        ;;
        links)
            doc_file=$bcs_html
            viewer="$links"
        ;;
        links2)
            doc_file=$bcs_html
            viewer="$links2"
        ;;
        -g | -G | grafux | visual)
            doc_file=$bcs_html
            viewer="$links2 -g"
        ;;
        w3m)
            doc_file=$bcs_html
            viewer="$w3m"
        ;;
        -f | -F | firefox)
            doc_file=$bcs_html
            viewer="$firefox"
        ;;
        bat)
            doc_file=$bcs_sh
            viewer="$bat"
        ;;
        cat)
            doc_file=$bcs_sh
            viewer="$cat"
        ;;
        hat | rat)
            echo "HAHA!"
        ;;
        less)
            doc_file=$bcs_sh
            viewer="$less"
        ;;
        more)
            doc_file=$bcs_sh
            viewer="$more"
        ;;
        hd)
            doc_file=$bcs_sh
            viewer="$hd"
            echo "LOL, OK."
        ;;
        html | HTML | "I said web, motherfucker" | web | WEB)
            doc_file=$bcs_html
            viewer=$web_viewer
        ;; # end case statement 
        *)
            doc_file=$bcs_sh
            viewer=$text_viewer
        ;;
    esac

    if [[ -x $viewer ]]; then
        $viewer $doc_file
    else
        echo "Something went wrong, probably your father's pull-out game."
    fi
    
## END FUNCTION show_cheat
}

function gibberish {
    ## this is the actual reference material, probably should awk this 
    ## this function and stuff that into a heredoc instead of the 
    ## big heredoc uptop
    ## also write a function to parse that heredoc into the html form

###### -- BEGIN SNIP HERE -- #####
#variables
name="John"
echo $name
echo "$name"
echo "${name}!"
printf "Your name is: $name\n"
printf "Your name is also: %s\n" "$name"
echo '$name'

#math
echo $((1+2))
$((a + 200)) # add 200 to $a
echo $((RANDOM%=200)) #return a random number from 0..200

#shell exec 
echo "Current Folder: $(pwd)" #posix
echo "Current Folder: `pwd`" #bashism

#redirection 

cat foo.txt > bar.txt #overwrite
cat foo.txt >> bar.txt #append
cat foo.txt 2> err.log #stderr to err.log
cat foo.txt 1> out.log #stdout to out.log
cat foo.txt 2>&1 #stderr to stdout
cat foo.txt 2>&1 > out.log #stderr & stdout to logfile
cat foo.txt 2> /dev/null #mute stderr (send to dev null)
cat foo.txt &> /dev/null #mute stderr & stdout 
cat foo.txt < bar.txt # send bar.txt to stdin

#PIPE!
cat foo.txt | grep bar # pipe stdout of cat to stdin of grep


#conditional exection
echo "this"; echo "then that" #both run, no matter what
echo "this" && echo "and that" #second runs if first returns 0
echo "this" || echo "or that" #second runs if first returns not 0

# if then else
if [[ -z "$name" ]]; then
    echo '$name var is empty'
elif [[ -n "$name" ]]; then
    echo "\$name var contains = \"$name\""
else
    echo "Yarr!"
fi

#case statement 
case "$1" in
    start | up)
        echo "starting..."
        ;;
    end | down | stop)
        echo "stopping..."
        ;;
    reboot)
        echo "rebooting..."
        ;;
    *)
        echo "Unrecognized command; beginning self-destruct..."
        echo "Usage: $0 {start|up|end|down|stop|reboot}"
        ;;
esac

#function
print_name() {
    echo "Bender Bending Rodregiuz"
}

function echo_name {
    echo "Fry"
}
echo "Name: $(print_name)"
echo "Name: $(echo_name)"

function arguments {
    echo $# # number of arguments
    echo $* # all arguments, separated by $IFS variable
    echo $@ # all arguments, separated by space
    echo $? # return code
    echo $$ # pid of command 
    
    echo $0 # name of command
    echo $1 # first argument
    echo $2 # second argument
    echo $3 # etc...
}

#braces 
echo {A,B}.txt #no spaces
echo {A,B} # echo "A B"
ls {A,B}.js #ls A.js B.js
echo {1..5} # echo "1 2 3 4 5"

echo ${name}
echo ${name/J/j} # substitution "john"
echo ${name:0:2} # slicing "Jo"
echo ${name::2}  # "Jo"
echo ${name::-1} # "Joh"
echo ${name:(-1)} # slice from end "n"
echo ${name:(-2):1} # "h"

#default values
food="banana"
echo ${food:-Cake} # $food or "Cake"
unset food
echo ${food:-"The cake is a lie"} # $food or ...
echo ${taco:=42} #set value of $taco
echo ${taco:+42} # return 42 if $taco is set
echo ${taco:?message} # show error message if $taco is not set

length=2
echo ${name:0:$length} #slice "Jo"
echo ${name:0:length}  # this too, fucking bashism

file="/path/to/foo/bar/foo.cpp"
echo ${file%.cpp} # "/path/to/foo/bar/foo"
echo ${file%.cpp}.o  # "/path/to/foo/bar/foo.o"
echo ${file%foo*} # "/path/to/foo/bar/"
echo ${file%%foo*} # "/path/to/"
echo ${file#*/} # "path/to/foo/bar/foo.cpp"
echo ${file##*/} # "foo.cpp"
echo ${file/foo/taco} #replace first foo "/path/to/taco/bar/foo.cpp"
echo ${file//foo/taco} #replace all foo "/path/to/taco/bar/taco.cpp"

echo ${file##*.} # ".cpp"
file_name=${file##*/} # "foo.cpp"
file_path=${file%$file_name} # "/path/to/foo/bar/" 

echo ${#file} # return length of variable "24"

scream="HELLO"
whisper="hello"
echo ${scream,} #lowercase first char
echo ${scream,,} #lowercase all chars
echo ${whisper^} # Hello
echo ${whisper^^} # HELLO

#loops
for file in /usr/bin/*; do 
    echo "${file}"
done

for ((i=0;i<100;i++)); do #c-style
    printf "$i "
done

for i in {1..5}; do #range
    echo $i
done

for i in {5..50..5}; do #step size
    echo $i
done


# test conditionals 

#Strings
[[ -z $string ]] # is empty
[[ -n $string ]] # not empty
[[ $str == $string ]] 
[[ $str != $string ]]

#numbers        # C equivilant    
[[ $a -eq $b ]] # ==
[[ $a -ne $b ]] # !=
[[ $a -lt $b ]] # <
[[ $a -le $b ]] # <=
[[ $a -gt $b ]] # >
[[ $a -ge $b ]] # >=

#binary
[[ ! EXPR ]] # NOT
[[ X ]] && [[ Y ]] # AND
[[ X ]] || [[ Y ]] # OR

#file
[[ -e $file ]] # exists
[[ -r $file ]] # readable
[[ -h $file ]] # symlink
[[ -d $file ]] # directory
[[ -w $file ]] # writeable
[[ -s $file ]] # size > 0 bytes
[[ -f $file ]] # regular file
[[ -x $file ]] # is executable
[[ $a -nt $b ]] # newer than 
[[ $a -ot $b ]] # older than
[[ $a -ef $b ]] # equal files

# arrays

fruit=('apple', 'grape', 'orange')

fruits[0]="apple"
fruits[1]="grape"
fruits[2]="orange"

Fruits=("${Fruits[@]}" "Watermelon")    # Push
Fruits+=('Watermelon')                  # Also Push
Fruits=( ${Fruits[@]/Ap*/} )            # Remove by regex match
unset Fruits[2]                         # Remove one item
Fruits=("${Fruits[@]}")                 # Duplicate
Fruits=("${Fruits[@]}" "${Veggies[@]}") # Concatenate
lines=(`cat "logfile"`)                 # Read from file


#iteration
for i in "${arrayName[@]}"; do
  echo $i
done

#brackets & arrays
echo ${Fruits[0]}           # Element #0
echo ${Fruits[@]}           # All elements, space-separated
echo ${#Fruits[@]}          # Number of elements
echo ${#Fruits}             # String length of the 1st element
echo ${#Fruits[3]}          # String length of the Nth element
echo ${Fruits[@]:3:2}       # Range (from position 3, length 2)

#dictionaries (hash table)
declare -A sounds

sounds[dog]="bark"
sounds[cow]="moo"
sounds[bird]="tweet"
sounds[wolf]="howl"

echo ${sounds[dog]} # Dog's sound
echo ${sounds[@]}   # All values
echo ${!sounds[@]}  # All keys
echo ${#sounds[@]}  # Number of elements
unset sounds[dog]   # Delete dog

#iterate over value
for val in "${sounds[@]}"; do
  echo $val
done

#iterate over key
for key in "${!sounds[@]}"; do
  echo $key
done

#parse command line options
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -V | --version )
    echo $version
    exit
    ;;
  -s | --string )
    shift; string=$1
    ;;
  -f | --flag )
    flag=1
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi

#get user input
echo -n "Would you like to play a game? [yes/no]: "
read ans
echo $ans

echo -n "How about a nice game of global thermo nuclear war? [yes/no]: "
read -n 1 ans # just one char (no enter)
echo $ans
##### -- END SNIP HERE -- #####
}
