#!/bin/bash

sudo puppet apply --modulepath=/home/suomisim/puppet/modules -e "include setupmodv1"
