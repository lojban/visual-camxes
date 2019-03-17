#!/bin/bash

chcon -R -t systemd_unit_file_t systemd/
chcon -t home_bin_t build_container.sh fix_selinux.sh kill_container.sh run_container.sh setup.sh
chcon -R -t container_file_t visual_camxes.py* wsgi.py* static/ templates/
loginctl show-user sampre_cx | grep -q Linger=yes || (
        echo -e "\n\n\nUSER LINGER DISABLED FOR THIS USER.  VERY BAD; MUST FIX.\n\n\n" ;
        loginctl enable-linger sampre_cx
)
