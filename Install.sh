#!/data/data/com.termux/files/usr/bin/bash -e
RUTA="$PREFIX/etc/profile"
read LINE COLS < <(stty size)
RED="\e[0;50;91m"
BLUE="\e[0;50;94m"
AGUA="\e[0;50;36m"
YELOW="\e[1;50;33m"
WHITE="\e[0;50;37m"
GREEN="\e[2;50;32m"
FORT="\e[0m"
printf "\n${AGUA}+ ${WHITE}Installing packages; wait ${AGUA}+${FORT}\n\n" && pkg install ncurses-utils termux-tools -y &>/dev/null
if [[ -d $PREFIX ]]
then
	[[ -f $PREFIX/etc/lockTermux ]] && printf "\n${YELOW}[${BLUE}!${YELOW}] ${WHITE} %s ${YELOW}[${BLUE}!${YELOW}]${FORT}\n\n\t${AGUA}+ ${WHITE}%s $AGUA+${FORT}\n\n\t${AGUA}+ ${WHITE}%s $AGUA+${FORT}\n\n" 'Is already installed!' 'Password: Termux' 'Help Mode: Help'&& exit 0
	if [[ -f $PWD/lockTermux ]]
	then
		sed -i '/lockTermux/d' $PREFIX/etc/profile
		rm -rf $PREFIX/etc/lockTermux 
		cp $PWD/lockTermux $PREFIX/etc
		chmod +x $PREFIX/etc/lockTermux
		FICHERO="$PREFIX/etc/./lockTermux"
		sed -i -e '1i\' -e "$FICHERO" $RUTA
		printf "
${BLUE}	╦  ┌─┐┌─┐┬┌┐┌
	║  │ ││ ┬││││${GREEN}Termux${BLUE}
	╩═╝└─┘└─┘┴┘└┘

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓

${AGUA}[*] ${WHITE}Default password: ${YELOW}Termux

${AGUA}[*] ${WHITE}Enter Menu mode:    ${YELOW}Help${FORT}

${BLUE}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${FORT}
"
		echo -e 
		sleep 0.5
		echo -e "${AGUA}[●] ${BLUE}Close all Termux ${AGUA}[●]\n${FORT}"
		sleep 1
		for i in $(seq 1 $COLS);do echo -n '-';done && echo
		exit 0
	fi
else
	echo -e "\n${RED}[*] ${BLUE}Only for Termux ${RED}[*]${FORT}\n"
fi
