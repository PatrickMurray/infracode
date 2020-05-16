# HP EliteDesk 800 G1 Desktop Mini PC

The following documentation will outline the setup of an HP EliteDesk 800 G1
Desktop Mini PC with the following specifications:

- Intel Core i5-4590T CPU, Quad-Core, 2.00 GHz
- 8192 MB DDR3 / 1333 MHz
- SATA SSD

## Provisioning

Ensure that the machine has the following:

1) a power supply
2) an active Internet connection
3) video output


### BIOS

Upon first boot, enter the machine's BIOS by pressing the `F10` key.

#### Obtain Latest Firmware

1) From the [HP Support website](https://support.hp.com/us-en/drivers), click
   `Desktop` and enter the machine's serial number and click `Submit`.
2) Download compressed driver `.exe` and run it. The program will prompt you
   for a location to extract the compressed drivers.
   * Select an external USB drive that has been formatted to a `FAT32`
     file-system (the USB drive must be less than 32 GB in capacity).
3) The extraction utility will create a new folder in the USB drive called
   `DOS Flash` which will require some reorganization before it can be used to
   upgrade the machine's BIOS firmware:
     * Delete everything in the parent directory except the `DOS Flash` folder;
     * Move the contents of the `DOS Flash` folder to the root of the USB
       drive;
     * Delete the `DOS Flash` folder.
4) The drive should now be ready to upgrade the machine's BIOS firmware.

#### Upgrade Firmware

1) Insert a USB drive with the latest version of the machine's BIOS firmware.
2) Upon first boot, press `F10` to enter the BIOS.
3) Select `Flash System ROM` and press `Enter`.
4) Following the DHCP progress bar, select the `USB` drive at the drive
   selection prompt and press `Enter`.
5) Select the binary file presented and press `Enter`. In my case, that is
   `L04_0233.BIN`
6) Confirm the binary file you will be flashing the system BIOS with. Select
   `OK` and press `Enter`. The
   * The machine's BIOS firmware will now be updated. This may take several
     minutes to complete.
7) When the system firmware has successfully been flashed, press any key to
   continue.
   * The machine will reboot. Press `F10` to reenter the BIOS.
8) After rebooting and entering the BIOS, navigate to `System Information` and
   confirm that the BIOS update is complete by observing the
   `BIOS Version & Date` value.

#### Configuration



### Intel Management Engine

#### Setup

#### Configuration


### OS Installation

### Configuration Management

