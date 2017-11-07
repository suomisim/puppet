# Palvelinten hallinta luntti
Lähde: http://terokarvinen.com/2017/aikataulu-%E2%80%93-palvelinten-hallinta-ict4tn022-2-%E2%80%93-5-op-uusi-ops-loppukevat-2017-p2
http://terokarvinen.com/2017/aikataulu-palvelinten-hallinta-ict4tn022-3-5-op-uusi-ops-loppusyksy-2017-p5

## 12.4.2017

	git config --global user.email "simppas@gmail.com" && git config --global user.name "Simo Suominen"

	git config --global credential.helper "cache --timeout=3600"

Tehtävään 2 kuvaus repositoryn luomisesta

Vältä käyttäjäkohtaisia

terokarvinen dconf

ublock origin viime kurssi tietoista (debian)

git stage . -> git add .

sudo chown -hR suomisim public_html/



git reset --hard

## 26.4.2017

Lisää työpöydän reset moduuliin
Lisää palomuuri LAMP moduuliin
ublock origin ei ihan toiminut about:config

Single source of truthsu
Itempotency
IaaC

PuppetMaster on Ubuntu @Terokarvinen

sudo hostnamectl set-hostname
sudo service avahi-demon restart

/var/lib/puppet/ssl/certs/

dns_alt_names = 

sudo puppet cert list


sudo service puppet stop
sudo service puppetmaster stop

sudo rm -r /var/lib/puppet/ssl/


sudo puppet agent -tdv

Tee mastermoduuli /etc/puppet/puppet.conf





## 3.5.2017

Lisää moduuliin tarkoitus

Avaceroot

class ufw {
Exec {
path => ‘/bin/:/usr/bin/:/sbin/:/usr/sbin/’,
}

exec { ‘ufw enable’:
unless => ‘sudo ufw status verbose|grep “Status: active”‘,
}

exec { ‘ufw allow 22/tcp’:
unless => ‘ufw status verbose|grep 22/tcp’,
}

}

## 24.10.2017

sudo puppet resource file/package/service
puppet describe file/package/service

/etc/puppet/manifests/site.pp ->

include helloworld

sudo puppet apply /etc/puppet/manifests/site.pp

etckeeper

## 31.10.2017

/etc/puppet.conf

[main]
ordering = manifest

strace -e open

Terokarvinen puppet defaults

## 7.11.2017

Moduuleja livetikku kuntoon + hostname livetikulle
Terokarvinen vagrantfile
Terokarvinen vagrant tscript


