#!/bin/bash

./fix_selinux.sh

rm -rf ~/.config/systemd/
mkdir -p ~/.config/systemd/
ln -s $(pwd)/systemd ~/.config/systemd/user

systemctl --user daemon-reload

systemctl --user enable visual_camxes
systemctl --user start visual_camxes
