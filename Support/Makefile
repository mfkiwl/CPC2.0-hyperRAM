all: build1 upload
#all: makerom1 build1 upload

.SILENT: build1 build2 upload

clean:
	rm -rf build
	mkdir build

build1: 
	$(MAKE) -C build -f ../Makefile build2

# Build the supervisor code	
build2: next_build_no
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/main.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/config/config.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/library/library.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/stdio_uart/stdio_uart.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/interrupt.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/hdmi/hdmi.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/fdc/fdc.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/fdc/sdc.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/fdc/fat2l.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/keyboard/keyboard.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/usb/usb.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/usb/phy.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/system/system.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/rommgr/rommgr.c
	sdcc --no-std-crt0 -mz80 -c --debug -I ../include ../src/asmi/asmi.c
	sdasz80 -l -o -s -y _boot.rel ../asm/_boot.asm
	
	# Note that _BOOT.REL must be first to correctly set the ordering of the initialized data area
#	sdldz80 -m -i -y -k /usr/share/sdcc/lib/z80 -b _DATA=0xc000 -l z80.lib rom.ihx  `ls *.rel|sort`
#	sdldz80 -m -i -y -k /usr/share/sdcc/lib/z80 -b _DATA=0x7000 -l z80.lib rom.ihx  `ls *.rel|sort`
	sdldz80 -m -i -y -k /usr/share/sdcc/lib/z80 -l z80.lib rom.ihx  _boot.rel `ls *.rel|grep -v _boot`
	# DATA is stored from c000 onwards, including initialized section
	
	# Check for overlapping code sections
	srec_cat rom.ihx -intel -o rom.hex -intel

	# Now create the ROM	
	echo "Creating output files, bin / mif / hex"
	makebin -s 65536 rom.ihx > ROM.bin

	# Map in ROM 6
#	dd if=../../roms/manic_miner.bin of=ROM.bin bs=16384 count=1 seek=2
#	dd if=../../roms/maxam.bin of=ROM.bin bs=16384 count=1 seek=2
#	dd if=../../roms/PACMAN.ROM of=ROM.bin bs=16384 count=1 seek=2
#	dd if=../../Custom-ROM/build/ROM.bin of=ROM.bin bs=16384 count=1 seek=2
	# Map in ROM 7
#	dd if=../../roms/amsdos.bin of=ROM.bin bs=16384 count=1 seek=3
#	dd if=../../roms/parados.bin of=ROM.bin bs=16384 count=1 seek=3
#	dd if=../../Custom-ROM/build/ROM.bin of=ROM.bin bs=16384 count=1 seek=3
	
	../scripts/make_mif ROM
	../scripts/make_hex ROM

upload:
	echo "Uploading to FPGA"
	# Suspend CPC
	echo "1" | nc de10 5555
	scripts/quartus_upload
	echo "0" | nc de10 5555

sim:
	cat scripts/z80-mon.header build/ROM.bin > build/ROM.z80
	z80-mon build/ROM.z80
	
debug:
	$(MAKE) -C build -f ../Makefile debug1
	
debug1:
	sdcdb -mz80 -t z80 --directory=../src --directory=../src/spi --directory=../src/stdlib --directory=../src/stdio --directory=../include rom
	
next_build_no:
	../buildnum.sh

makerom1:
	$(MAKE) -C ../../roms/embedrom -f Makefile
	ln -f ../../roms/embedrom/rom1.h build
