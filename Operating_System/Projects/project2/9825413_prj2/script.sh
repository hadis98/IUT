make
insmod mymodule.ko
module='mymodule'
major=`awk "\\$2==\"$module\" {print \\$1}" /proc/devices`
sudo mknod /dev/iutnode c $major 0
sudo chmod 777 /dev/iutnode
sudo python3 test.py
sudo rmmod mymodule
sudo rm /dev/iutnode
make clean
