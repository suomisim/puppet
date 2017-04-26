# Palvelinten hallinta luntti

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

Single source of truth
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
