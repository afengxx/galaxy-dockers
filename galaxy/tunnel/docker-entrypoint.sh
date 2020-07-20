#!/bin/sh

set -ex

patch_conf() {
cat >> $OVPN_CONFIG <<EOF
proto $OVPN_PROTO
port $OVPN_PORT
tls-auth $OVPN_TLS_AUTH 0
server $OVPN_IP_POOL 255.255.255.0 nopool
ca $OVPN_CA
cert $OVPN_CERT
key $OVPN_KEY
EOF
}

if [ ! -f "$GALAXY_INITIALIZED_MARK" ]; then
  patch_conf
  touch $GALAXY_INITIALIZED_MARK
  echo
  echo 'openvpn init process complete; ready for start up.'
  echo
else
  echo
  echo 'Skipping initialization'
  echo
fi
 
mkdir -p $OVPN_IP_POOL_DIR

cat > /etc/inetd.conf <<EOF
80      stream  tcp     nowait  nobody  /usr/bin/nc nc nginx 80
EOF
 
if [ "$RUN_AFTER_SIDECAR" = "yes" ]; then
	until wget --spider localhost:15000 > /dev/null; do echo '>>> Waiting for sidecar'; sleep 2 ; done ; echo '>>> Sidecar available';sleep 5;
fi
inetd
/bin/sh -c "$@"
