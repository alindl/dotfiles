#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval "$(dircolors -b ~/.dir_colors)"
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval "$(dircolors -b /etc/DIR_COLORS)"
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}


## Standard
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

## Updates
alias pacup="sudo pacman -Syu"
alias yaoup="yaourt -Sau"
alias triup="trizen -Sau"
alias yayup="yay -Sau --combinedupgrade"
alias upall="pacup && yaoup"

## Random Stuff
alias gotosite='firefox "$(head -n 1 ~/.sitechangemd5sum)"'
alias pecops="ps aux | peco"
alias pecohis="history | peco"
alias please='sudo $(fc -ln -1)'
alias cal="cal --monday"
# alias please='sudo "$BASH" -c "$(history -p !!)"'
#alias rtv="rtv --enable-media"
alias myip="wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1"
alias pingy='ping 8.8.8.8 | lolcat -a;'
alias up="cd .."
alias nv="nordvpn"
alias nvs="nordvpn status"
#eval "$(thefuck --alias)"
alias youtube="youtube-viewer --channel-playlists=mine"
# Can be used for piping things to the clipboard
alias tocb="xclip -selection c"

## Random stuff
alias handy="sudo /opt/android-sdk/platform-tools/adb kill-server; sudo /opt/android-sdk/platform-tools/adb start-server; ADB=/opt/android-sdk/platform-tools/adb scrcpy"

git(){
    if [[ $1 == "push" ]]; then
       command mpv -really-quiet ~/bin/push-it-to-the-limit-scarface-mp3cut.mp3 &
       command git "$@";
   else
       command git "$@";
    fi
}


checksite(){
    if [[ $(curl -s "$(head -n 1 ~/.sitechangemd5sum)" | md5sum | awk '{ print $1 }') = $(tail -n 1 ~/.sitechangemd5sum) ]]; 
        then 
            echo "Website is still the same"; 
        else 
            echo "Website changed"; 
    fi
}
resetsite(){
    THIS_SITE=$(head -n 1 ~/.sitechangemd5sum);
    echo "$THIS_SITE" > ~/.sitechangemd5sum;
    curl -s "$THIS_SITE" | md5sum | awk '{ print $1 }' >> ~/.sitechangemd5sum;
    echo "Done"
}

## HDMI Stuff
# Set HDMI same as display
alias sameas='xrandr --output HDMI-1 --mode 1920x1080 --same-as eDP-1; pactl set-card-profile 0 output:hdmi-stereo;'
# Set HDMI next to display
alias nextto='xrandr --output HDMI-1 --mode 1920x1080 --right-of eDP-1; pactl set-card-profile 0 output:hdmi-stereo;'
# Cut off HDMI
alias hdmioff='xrandr --output HDMI-1 --off; pactl set-card-profile 0 output:analog-stereo+input:analog-stereo;'
# Reset Display if needed
alias resetdisplay='xrandr -s 0'
# Send Sound to HDMI
alias soundhdmi='pactl set-card-profile 0 output:hdmi-stereo;'
# Keep sound on Laptop
alias keepsound='pactl set-card-profile 0 output:analog-stereo+input:analog-stereo;'

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# Don't add duplicate commands
# Erase duplicates
#export HISTCONTROL=ignoredups:erasedups
export HISTCONTROL=ignoredups

# Set size of History file in lines
export HISTSIZE=100000

# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

# No more Ctrl+S which would change it so that vim wouldn't take any input anymore until Ctrl+Q is pushed
# DOESN'T WORK LOL
stty -ixon