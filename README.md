# Linux マシンにおけるパッケージの復元

```
sudo dpkg --get-selections > installed.list
```

```
apt-get install dselect
dselect update
dpkg --clear-selections
dpkg --set-selections < installed.list
apt-get dselect-upgrade
apt-get autoremove
```

以下のコマンドで書き出し 

```
sudo dpkg --get-selections > etc/`hostname`-package.selections
```
