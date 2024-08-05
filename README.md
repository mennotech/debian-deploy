# debian-deploy
Debian automated deployment code

# One time booting with preseed

Create a new VM with the debian netinstall ISO as the boot device

Press "C" and paste the following commands into the grub> command line

<pre>
linux /install.amd/vmlinuz auto=true preseed/url=https://raw.githubusercontent.com/mennotech/debian-deploy/main/debian-seeds/basic-preseed.cfg priority=critical ---
initrd /install.amd/initrd.gz
boot
</pre>


# Refences
- This demo started based on the article found at https://medium.com/@maros.kukan/automating-debian-linux-installation-24d10c85f797
