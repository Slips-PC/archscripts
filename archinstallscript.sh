#!/bin/sh

# HELLO
#
# Read this script in it's entirety before executing it.
# DO NOT EXECUTE SCRIPTS WITHOUT READING THEM FIRST.
#
# If you are not okay with any action taken by this script, press N at the next prompt, whether
# or not your drives are properly formatted.
#
# Exit this prompt by pressing q.
#
# -Slips

cat ./archinstallscript.sh | less
echo "CONFIRM THAT YOU HAVE MOUNTED YOUR MAIN PARTITION TO /mnt AND YOUR SWAP WITH swapon (Y/N):"
read drivesformatted
if [ "$drivesformatted" = "n" ]; then
        echo "PLEASE MOUNT DRIVES: mount /dev/root_partition /mnt && swapon /dev/swap_partition"
        exit 1 
elif [ "$drivesformatted" = "N" ]; then
        echo "PLEASE MOUNT DRIVES: mount /dev/root_partition /mnt && swapon /dev/swap_partition"
        exit 1
elif [ "$drivesformatted" = "y" ]; then
        echo "Continuing..."
elif [ "$drivesformatted" = "Y" ]; then
        echo "Continuing..."
else
        echo "Input not understood, presuming no and exiting script..."
        echo "PLEASE MOUNT DRIVES: mount /dev/root_partition /mnt && swapon /dev/swap_partition"
        exit 1
fi

pacstrap /mnt base linux linux-firmware base-devel sudo networkmanager zsh neovim grub

genfstab -U /mnt >> /mnt/etc/fstab
echo "From here:"
echo "copy archinstallscript2.sh to /mnt, type arch-chroot /mnt, execute archinstallscript2.sh."
