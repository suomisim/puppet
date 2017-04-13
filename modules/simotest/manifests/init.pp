class simotest {

    file {"/tmp/hellosimo2":                #tiedoston luonto
     content => "Hello again, Simo!\n",        #tiedoston sisältö
    }

    exec { 'apt-update':                    #komento
     command => '/usr/bin/apt-get update'    #komennon polku
    }

    $paketit = [ 'vlc', 'curl', 'lynx' ]    #asennettavien pakettien kuvaus

    package { $paketit: ensure => 'latest'    #pakettien asennus

    }

}
