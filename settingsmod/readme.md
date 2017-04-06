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
	$ mkdir settings
	$ cd settings
	$ mkdir manifests
	$ mkdir templates
	$ cd manifests
	$ nano init.pp

init.pp -tiedostoon kirjattiin seuraava pätkä koodia:

	class settings {

        	file {'/home/suomisim/.config/xfce4/panel/whiskermenu-1.rc':
                content => template('settings/whiskermenu-1.rc.erb')

        	}

        	file {'/home/suomisim/.config/xfce4/terminal/terminalrc':
                content => template('settings/terminalrc.erb')

        	}


	}

Seuraavaksi kopioitiin asetustiedostot template-kansioon oikeassa muodossa (.erb)

	cp terminalrc /home/suomisim/puppet/settings/templates/terminalrc.erb
	cp whiskermenu-1.rc /home/suomisim/puppet/settings/templates/whiskermenu-1.rc.erb

Lopuksi testattiin moduulia livetikun kanssa, käyttöjärjestelmänä Xubuntu 16.04 LTS. Ensin tallennettiin 
luotu moduuli Githubiin.

	git stage .
	git commit (kommentiksi Improve settings module)
	git pull (vedä aina ennen työntöä)
	git push

 



