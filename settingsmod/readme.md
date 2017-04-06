# Palvelinten hallinta - viikko 2

Lähde  Tero Karvinen 2017: Linux kurssi, http://terokarvinen.com

Harjoitusympäristönä asennettu Xubuntu 16.04, Xenial Xerus

Harjoituskoneen tiedot:

Emolevy X79A-GD65 (8D)

Prosessori Intel(R) Core(TM) i7-3930K

16GiB RAM

Näytönohjain GeForce GTX 690

## Tee puppet-moduli, joka tekee asetukset jollekin komentorivi- tai graafisen käyttöliittymän ohjelmalle.

Harjoitustyön tavoitteena on tehdä käytännönläheinen moduuli muokkaamaan Xubuntun käyttöliittymää haluttuun suuntaan.
Lopullisena tavoitteena on moduuli, jonka voi ajaa esim. livetikulla tai heti ensimmäisenä uudelleen asennetulle Xubuntulle.
Muutokset saattavat olla pieniä, mutta niiden tekeminen erikseen joka kerta vie aikaa. Testikoneella oli tehty muutoksia mm. 
käynnistysvalikkoon ja työpöytään, joten kopioimalla näiden asetustiedostot moduuliin tehdyt muutokset saatiin monistettua.

### Työpöydän asetukset

Pikaisen googletuksen perusteella Xfce4 työpöydän ja käynnistysvalikon asetukset löytyivät polulta /home/<user>/.config/xfce4/
Talteen päätettiin ottaa käynnistysvalikon asetustiedosto whiskermenu-1.rc ja komentokehotteen asetustiedosto terminalrc.
Harjoituksessa luotiin Puppet-moduuli settings, joka siirtää asetustiedostot oikeaan paikkaan ja näin asettaa asetukset voimaan.

	$ cd
	$ mkdir settingsmod
	$ cd settingsmod
	$ mkdir manifests
	$ mkdir templates
	$ cd manifests
	$ nano init.pp

init.pp -tiedostoon kirjattiin seuraava pätkä koodia:

	class settingsmod {

        	file {'/home/suomisim/.config/xfce4/panel/whiskermenu-1.rc':
                content => template('settingsmod/whiskermenu-1.rc.erb')

        	}

        	file {'/home/suomisim/.config/xfce4/terminal/terminalrc':
                content => template('settingsmod/terminalrc.erb')

        	}


	}

Seuraavaksi kopioitiin asetustiedostot template-kansioon oikeassa muodossa (.erb)

	cp terminalrc /home/suomisim/puppet/settingsmod/templates/terminalrc.erb
	cp whiskermenu-1.rc /home/suomisim/puppet/settingsmod/templates/whiskermenu-1.rc.erb

Lopuksi kopioitiin moduuli /etc/puppet/modules -kansioon. Ennen moduulin ajamista muokattiin komentokehotteen
ja käynnistysvalikon asetuksia, jotta nähtäisiin että asetukset muuttuvat takaisin. Komentokehotteen kokoa
muutettiin pienemmäksi (Preferences -> Appearance -> Default geometrics) ja käynnistysvalikosta Favourites
-pikakuvakkeista poistettiin pari kuvaketta. Seuraavaksi ajettiin moduuli komennolla:

	$ sudo puppet apply -e 'class {"settingsmod":}'




 



