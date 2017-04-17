class simotest {
# Pakettien asennus
    
    $paketit = [ 'vlc', 'curl', 'lynx', 'shutter', 'geany', 'tree' ]

    package { $paketit: ensure => 'installed'    

    }

}
