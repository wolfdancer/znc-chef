#!/bin/bash

# This runs as root on the server

chef_binary=/usr/bin/chef-solo

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
    export DEBIAN_FRONTEND=noninteractive
    # Upgrade headlessly (this is only safe-ish on vanilla systems)
    aptitude update &&
    apt-get -o Dpkg::Options::="--force-confnew" \
        --force-yes -fuy dist-upgrade &&
    # Install Chef
    aptitude install -y chef
    # Install ZNC
    apt-get install znc/quantal-backports znc-dbg/quantal-backports \
        znc-dev/quantal-backports znc-extra/quantal-backports \
        znc-perl/quantal-backports znc-python/quantal-backports \
        znc-tcl/quantal-backports \
        --force-yes -fuy
fi &&

"$chef_binary" -c solo.rb -j solo.json
