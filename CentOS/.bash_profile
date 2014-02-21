# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
PATH=$PATH:$HOME/bin
export PATH
PROMPT="\[\e[1;35m\]\u\[\e[1;31m\]@\[\e[0;35m\]\h \[\e[1;34m\]\w\n\[\e[1;37m\]\$ \[\e[0m\]"
function exitstatus {
    if [ $? -eq 0 ];
    then
        PS1="\n\[\e[1;32m\]\! ${PROMPT}";
    else
        PS1="\n\[\e[1;31m\]\! ${PROMPT}";
    fi
}
PROMPT_COMMAND=exitstatus
