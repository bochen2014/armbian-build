# I want to learn how uboot works


# rockchip rk3318 瑞芯

## NAND vs eMMC vs eMCP difference:

RK3228 and RK3229 tv boxes comes with three different flash memory chips: eMMC, NAND and eMCP.

* NAND chip is just the non-volatile memory
* eMMC chip contains both the non-volatile memory plus a controller.
* eMCP chip contains the non-volatile memory, a controller for the non-volatile memory (like eMMC), but also contains a bank of DDR SDRAM memory on the same physical chip.

If you have a NAND chips you're unlucky because mainline kernel currently cannot access it, but also because you need special care and instructions explained later.
 

You can discover if you have a `NAND`, `eMMC` or `eMCP` chip looking on the board or reading the signature on the flash memory chip.

The Multitool (see later) also can detect which chip you have onboard: the program will warn you at startup if you have a NAND chip.


Multitool:

The Multitool is a small but powerful tool to do quick backup/restore of internal flash, but also burn images and general system rescue and maintenance via terminal or SSH.

Compressed images will be uncompressed on fly.









# Amlogic s9xx  -- ToothPick multiboot 晶晨
> [installation steps](https://forum.armbian.com/topic/17106-installation-instructions-for-tv-boxes-with-amlogic-cpus)
> [I want to understand how things work](https://forum.armbian.com/topic/19004-trying-to-learn-more-about-u-boot-for-amlogic-devices/)
## models
 H96 Max X3 (s905x3)  /   Nexbox A95X


## SYNOPSIS
> [github PR](https://github.com/armbian/build/pull/4296/files#diff-a68a9360507234a81418560c30a3c219253ce6900e27b0d90a75af0e554ea1ea)

> * [hexdump] amlogic socs by default always boot from emmc if emmc is there (which is always the case for tv boxes) - best for you is to look at the multiboot script from the old images of `balbes150` - this one uses the legacy u-boot of the box to boot an own kernel or to chainload a mainline u-boot to boot it
> * [steeMan] The boot process starts with the vendor u-boot on emmc.  The multiboot process essentially hijacks the original android u-boot process and allows other boot paths to occur that the original android box manufacture never intended (to chainload a mainline u-boot to boot it)

 
* aml_autoscript (for `toothpick`) and aml_autoscript.zip (for `android > application > Run Update & Backup  -- Select Local > navigate to sd card > aml_autoscript.zip -- select Update`)  - These are what enable 'multiboot' (https://github.com/endlessm/u-boot-meson/blob/master/common/aml_autoscript.c)

* Understand how u-boot environment variable work to control the boot process

* Then move onto the s905_autoscript and emmc_autoscript - understand how these work to actually boot the kernel

* Look at what the chainloaded u-boot-s905, u-boot-s905x2-s922 and u-boot-s905x-s912 are and why they are used (for extra credit, these are built from [hexdump's github sources](https://github.com/hexdump0815/u-boot-misc), and you can rebuild them yourself)



## how to enable multiboot
Once you have your SD card prepared you need to enable multiboot on the box. The "toothpick" method means to hold the reset button while applying power to the box. 

## burn armbian to emmc
> Note: It is not possible to install into emmc on boxes with the s905 cpu (s905x, s905w, s905x2, etc however should all be supported).
You install armbian to emmc by running the appropriate shell script in the /root directory:` install-aml.sh` (Instead of using `install_aml_s905x.sh` just simply use `install_aml.sh` and it works fine. )