#!/bin/bash

git clone https://github.com/suomisim/puppet

puppet apply --modulepath=/home/suomisim/puppet/modules -e "include setupmodv1"