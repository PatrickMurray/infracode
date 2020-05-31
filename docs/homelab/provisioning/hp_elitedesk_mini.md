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

##### Factory Reset

1) Under the `File` tab, select `Default Setup` and press `Enter`.
2) Select `Restore Factory Settings as Default` and press `Enter`.
3) Select `OK` and press `Enter`.
4) Press `Esc` to exit the default setup prompt.

##### Storage

Within the `Storage` tab, complete the following tasks:

1) Select `Device Configuration` and press `Enter`, confirm that the machine's
   hard drive is installed and detected, and press `Esc`.
2) Select `Storage Options` and press `Enter`, ensure that the `SATA Emulation`
   setting is configured to `AHCI`, and press `F10` to accept.
3) Optionally, you may move the machine's hard drive higher up in the boot
   order by: selecting `Boot Order` and pressing `Enter`, using the arrow keys
   to select the desired hard drive and pressing `Enter`, then moving the drive
   up.


### Intel Management Engine

#### Setup

Next we will setup the Intel Management Engine for remote management and system
administration.

1) Within the BIOS, navigate to the `Advanced` tab, select
   `Management Operations` and press `Enter`.
2) Ensure that `AMT` is `Enabled`.
3) Next, mark `Unconfigure ATM/ME` as `Enabled`, and press `F10` to accept.
   * Upon initial setup, this will reset the Intel ME credentials which will be
     setup later on.
   * This setting will be reverted in the future as to not reset our newly
     created Intel ME credentials.

Once complete, exit the BIOS by pressing `F10` to `Save Changes and Exit`.

After rebooting the machine, hold down `Ctrl+P` to enter the Intel Management
Engine main menu.

1) Select `MEBx Login` and press `Enter`.
2) When prompted for the administrator password, type the default (`admin`) and
   press `Enter`.
3) When prompted for a new administrator password, type a temporary
   administrator password.
   * The temporary password must contain a minimum of 8 alpha-numeric
     characters and symbols.
   * *NOTE*: We will be changing this password later within MeshCommander when
     we configure other settings.
4) Select `MEBx Exit` and press `Enter`, press `Y` at the confirmation prompt.


#### Configuration

Locally run the following command in a terminal to start the MeshCommander
server:

```bash
meshcommander
```

In a web browser, navigate to `http://localhost:3000/`. Click `Add Computer...`
and enter the following information about the system:

1) A human readable name; for example, `node0`
2) A group name to which the system will be associated; for example, `homelab`;
3) The system's reachable network address;
4) Under the `Auth / Security` section, initially select `Digest / None` and
   enter the credentials that were set during the the Intel ME setup.

TODO


### OS Installation

#### Selecting Boot Medium

1) Reboot the machine and attach your operating system installation medium.
   Upon boot, press `F9` to enter the boot device selection menu.
2) Select the desired boot device.


#### Debian Installer

1) From the GRUB bootloader, select `Install` to use a command-line interface
   installer and press `Enter`.
2) Select `English` as the default language for the system and press `Enter`.
3) Select `United States` as the system location and press `Enter`.
4) Select `American English` as the default keymap and press `Enter`.
5) Enter `node{N}` (where `N` is substituted with a number) for the system's
   hostname and press `Enter`.
6) Enter a root password, press `Enter` and repeat once again.
7) Enter a username for the system and press `Enter`.
   * *NOTE*: You do not need to enter a full name for the user. You may choose
     to only enter a username.
8) Confirm the username and press `Enter`.
9) Enter a password for the new user and press `Enter`, repeat.
10) Select `Eastern` as the system timezone and press `Enter`.
11) With respect to disk encryption, select `Guided - use entire disk and set up encrypted LVM` and press `Enter`.
12) Select the drive to encrypt and press `Enter`.
13) When prompted to select a partitioning scheme, select
    `All files in one partition (recommended for new users)` and press `Enter`.
14) When warned about permanently erasing drive data, select `Yes` and press
    `Enter`.
15) Write the changes to disk by selecting `Yes` and pressing `Enter`.
16) When the installer attempts to overwrite the contents of the disk with
    random data, select `Cancel` and press `Enter` to quit the overwrite. This
    is unnecesary on SSDs that have been encrypted in the past.
    * If the disk in question is neither an SSD nor has been encrypted before,
      it is recommended to overwrite it's contents for added security.
17) Enter an encryption passphrase and press `Enter`, repeat.
18) When prompted to enter the side of the guided partition, accept the default
    value, select `Continue` and press `Enter`.
19) Write the changes to disk by selecting
    `Finish partitioning and write changes to disk` and press `Enter`.
20) Confirm the changes by selecting `Yes` and pressing `Enter`.
21) When prompted to configure a CD/DVD apt source, select `No` and press
    `Enter`.
22) Select the `United States` Debian archive mirror and press `Enter`.
23) Select `deb.debian.org` and press `Enter`.
24) Leave the HTTP proxy field empty and press `Enter`.
25) When prompted to opt-in the package usage survey, select `No` and press
    `Enter`.
26) When prompted to install select software, make the following
    removals/selections, select `Continue` and press `Enter`.
    * Removals:
      * `Debian desktop environment`
      * `print server`
      * `standard system utilities`
    * Selections:
      * `SSH server`
27) When prompted to install the GRUB bootloader on disk, select `Yes` and
    press `Enter`.
28) Select the desired hard drive and press `Enter`.

The installation is now complete. Select `Continue` and press `Enter`. The
system will now reboot and you will be prompted to enter the disk decryption
passphrase. Do not enter the passphrase using your keyboard as we will use this
opportunity to test the Intel Management Engine's ability to remote into the
unbooted operating system and enter the disk decryption passphrase remotely.


### Configuration Management


#### Ansible User

From a root shell on the system, run the following commands:

```bash
useradd --create-home ansible
passwd ansible
apt-get -y install sudo python
echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible
userdel --remove DEFAULT_USERNAME
```

### Locally

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub ansible@HOSTNAME
```
