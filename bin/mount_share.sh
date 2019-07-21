if [ !  -d /mnt/share ];then
  sudo mkdir /mnt/share
fi 
sudo mount -t cifs //192.168.0.100/share /mnt/share/ -o uid=$(id -u),gid=$(id -g),username=hideaki 

if [ !  -d /mnt/backup ];then
  sudo mkdir /mnt/backup
fi 
sudo mount -t cifs //192.168.0.100/backup /mnt/backup/ -o uid=$(id -u),gid=$(id -g),username=hideaki 
