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

cat ./archinstallscript2.sh | less
echo Put Drive Name
read drivename

ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf

echo SliPC > /etc/hostname

echo 127.0.0.1	        localhost > /etc/hosts
echo ::1		localhost > /etc/hosts
echo 127.0.1.1	SliPC.localdomain	SliPC > /etc/hosts

mkinitcpio -P

passwd 

sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

echo "Setting up non-root user, please enter username:"
read username
useradd -m -G wheel -s /bin/zsh $username
passwd $username
echo "STOP!"
echo "This script is about to install grub for the i386-pc target. Would you like to cancel now? (Y/N)"
read cancelnow
if [ $cancelnow = Y ]; then
	echo "Understood, cancelling now. Be warned you will have to exit and unmount on your own after installing grub."
	exit 0
elif [ $cancelnow = y ]; then
        echo "Understood, cancelling now. Be warned you will have to exit and unmount on your o
wn after installing grub."
	exit 0
elif [ $cancelnow = n ]; then
	echo "Continuing..."
elif [ $cancelnow = N ]; then
	echo "Continuing..."
else
	echo "Input no understood, presuming no, program stopping."
	exit 0
fi
grub-install --target=i386-pc /dev/$drivename
grub-mkconfig -o /boot/grub/grub.cfg
exit
umount -R /mnt
echo And youre done! Reboot and get using! 
