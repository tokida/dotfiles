#!/usr/bin/zsh
sleep 2

DISPLAY=":0"
HOME=/home/hideaki/
#XAUTHORITY=$HOME/.Xauthority
#export DISPLAY HOME XAUTHORITY
export DISPLAY
CHECKLOG=/tmp/keycheck.log

# iBuffalo keyboard deice
keyid=`xinput -list | grep -e "USB Keyboard" -e "Bluetooth Keyboard  " | awk '{print$4}' | awk -F= '{print$2}'`
echo "start keymap change " `date` >> $CHECKLOG
echo "keyid : " $keyid >> $CHECKLOG
xinput -list >> $CHECKLOG 2>&1

if [ $keyid -gt 0 ]; then
	#xkbcomp -i $keyid -I$HOME/.xkb $HOME/.xkb/keymap/tkfbp02 $DISPLAY
	xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keyboard-rbk $DISPLAY  >> /dev/null 2>&1
	echo "map : tkfbp02" >> $CHECKLOG
else
	xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keyboard-notebook $DISPLAY  >> /dev/null 2>&1
	echo "map : normal" >> $CHECKLOG
fi

#echo $keyid >> /tmp/keycheck.log
