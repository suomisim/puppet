#!/bin/bash

git clone https://github.com/suomisim/puppet /home/suomisim/puppet

wget https://raw.githubusercontent.com/suomisim/puppet/master/unattended/firstboot
sudo mv firstboot /etc/init.d/
sudo chmod +x /etc/init.d/firstboot
update-rc.d firstboot defaults
