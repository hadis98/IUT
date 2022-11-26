ccflags-y := -std=gnu99
obj-m += mymodule.o

# KIDR = /usr/src/linux-headers-5.4.0-91-generic

all:
	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) modules
clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean