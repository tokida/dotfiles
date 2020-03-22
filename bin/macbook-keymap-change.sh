#!/usr/bin/zsh
sleep 2

DISPLAY=":0"
HOME=/home/hideaki/
#XAUTHORITY=$HOME/.Xauthority
#export DISPLAY HOME XAUTHORITY
export DISPLAY
CHECKLOG=/tmp/keycheck.log

echo "start keymap change " `date` >> $CHECKLOG
xinput -list >> $CHECKLOG 2>&1
keyid=""

# 内蔵キーボード
keyid=`xinput -list | grep -e "AT Trans" | awk -F= '{print$2}' | awk '{print$1}'`
echo "keyid : " $keyid >> $CHECKLOG
if [ $keyid -gt 0 ]; then
	xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keyboard-notebook $DISPLAY  >> /dev/null 2>&1
	echo "map : normal" >> $CHECKLOG
fi

# キーボードに分けて条件を記載する
# iBuffalo keyboard device
keyid=`xinput -list | grep -e "USB Keyboard" | awk -F= '{print$2}' | awk '{print$1}'`
echo "keyid : " $keyid >> $CHECKLOG
if [ "$keyid" != "" ];then
if [ $keyid -gt 0 ] ; then
	xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keyboard-usbkeyboard $DISPLAY
	echo "map : usb keyboard" >> $CHECKLOG
fi
fi


# 外付け折りたたみキーボード
#echo $keyid >> /tmp/keycheck.log
keyid=`xinput -list | grep -e "Bluetooth Keyboard  " | awk '{print$4}' | awk -F= '{print$2}'`
echo "keyid : " $keyid >> $CHECKLOG
if [ "$keyid" != "" ];then
if [ $keyid -gt 0 ] && [ -n $keyid ]; then
	# xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keyboard-rbk $DISPLAY  >> /dev/null 2>&1
	xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keyboard-atom66 $DISPLAY  >> /dev/null 2>&1
	echo "map : keyboard-rbk" >> $CHECKLOG
fi
fi


# Niz atom66 keyboard
#echo $keyid >> /tmp/keycheck.log
keyid=`xinput -list | grep -e "66EC-S Keyboard  " |  awk -F= '{print$2}' | awk '{print$1}'`
echo "keyid : " $keyid >> $CHECKLOG
if [ "$keyid" != "" ];then
if [ $keyid -gt 0 ] && [ -n $keyid ]; then
	xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keyboard-atom66 $DISPLAY  >> /dev/null 2>&1
	echo "map : keyboard-atom66" >> $CHECKLOG
fi
fi

