#!/bin/bash
if [ ! -f /.root_pw_set ]; then
	/set_root_pw.sh
fi

#Change terminal size
sed -i "s/FontName=Monospace.*/FontName=Monospace 10/g" ~/.config/xfce4/terminal/terminalrc

dbus-daemon --system --fork

exec /usr/sbin/sshd -D
