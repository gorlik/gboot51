-------------------------------------------------------------------------------
 gflash - Readme.txt
-------------------------------------------------------------------------------
Copyright (c) 2010,2013 Gabriele Gorla
gorlik@yahoo.com

gflash is a command line flash update utility for Silicon Laboratories 
USB microcontroller using the gboot bootloader.
gflash works has ben tested in linux i386 and windows, but should work on any
platform supported by libusb.

Features
------------------
Not many features, just the bare minumum.
Allows to read/write/erase the flash and reboot the MCU as necessary.
It also allows to read some basic information about the device to make sure
you are flashing the right firmware.

Building gflash
----------------------------
Linux requirements:
libusb-1.0-dev
GNU make
gcc
gboot source

make a symlink named gboot in the gflash directory pointing to the gboot source.
to build type "make". If you have mingw32 cross development tools installed
you can build the windows version typing "make win"

Building on windows should be fairly simple, but untested. A precompiled win32 binary 
can be found at http://gglabs.us/node/3

The windows binaries are statically linked against libusbx 1.0.17 (not libusb).
 

Using gflash
----------------------------
simple flashing:
gflash_cli i
Ask the MCU for the device information and flash layout. Make sure the flash start is 
equal to the --code-start-loc used to compile the firmware to be flashed.

gflash_cli p file.bin
Program file.bin into the MCU flash at loaction FLASH_START. The bin file 
should not have any offset, gflash will automatically add FLASH_START to 
the write commands.

gflash_cli b
Reboot the MCU. If the firmware was flashed successfully the MCU will execute
the firmware instead of gboot.


Building a firmware to work with gboot
----------------------------------------
All is required is to add --code-loc 0x0400 to the link stage of your 
firmware. Convert the intel hex file to bin using srec_cat, hex2bin or your 
favorite tool and use the command above to upload the code.

When using srec_cat make sure to add the "-offset -0x0400" to the command line.
i.e.:
srec_cat firmware.ihx -Intel -offset -0x400 -Output firmware.bin -Binary

TODO
-------
- write a gui version
