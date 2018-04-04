# seafileserver
Build seafile server 6.2.5 from source using systemd-nspawn container.
Based on Ubuntu Xenial.
After running ```mkosi```, ```seafile-server_6.2.5_x86-64.tar.gz``` is located in  ```/root/seafile-server-pkgs/```.
mkosi.postinst contains the main script.
See create-systemd-container.sh for more comments.
