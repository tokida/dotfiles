#!/bin/bash

set -u

# 実行場所のディレクトリを取得
THIS_DIR=$(cd $(dirname $0); pwd)

cat << END
**************************************************
DOTFILES SETUP START.
**************************************************
END


cd $THIS_DIR
# submoduleのアップデートの実施
git submodule init
git submodule update

for f in .??*; do
    # 次の場合には処理をスキップ
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitconfig.local.template" ] && continue
    [ "$f" = ".gitmodules" ] && continue
    [ "$f" = ".config" ] && continue

    # ユーザのカレントディレクトリにlinkをする
    echo "-> ${f}"
    ln -snfv ~/dotfiles/"$f" ~/
done

echo "--sub: .config directory"
cd .config
for f in *; do
	if [ -d ~/dotfiles/.config/${f} ];then
    	echo "-> .config/${f}"
        ln -snfv ~/dotfiles/.config/"$f" ~/.config/
    fi
done
cd $THIS_DIR
ln -snfv $THIS_DIR/.config/libinput-gestures.conf ~/.config/libinput-gestures.conf


# [ -e ~/.gitconfig.local ] || cp ~/dotfiles/.gitconfig.local.template ~/.gitconfig.local

# zprezto
cd $THIS_DIR
ln -snfv $HOME/.zprezto/runcoms/zlogin ~/.zlogin
ln -snfv $HOME/.zprezto/runcoms/zlogout ~/.zlogout
ln -snfv $HOME/.zprezto/runcoms/zpreztorc ~/.zpreztorc
ln -snfv $HOME/.zprezto/runcoms/zprofile ~/.zprofile
ln -snfv $HOME/.zprezto/runcoms/zshenv ~/.zshenv
cd $HOME/.zprezto
git submodule init
git submodule update
cd $THIS_DIR

# neovim
if [ ! -d $HOME/.config/dein ];then
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > neovim_installer.sh
	sh ./neovim_installer.sh ~/.config/dein
	rm ./neovim_installer.sh
fi

cat << END
**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************
END
