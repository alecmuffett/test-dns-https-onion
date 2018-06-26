#!/bin/sh
# testing DNS-over-HTTPS-over-Onion (DHO? DNSHO?)
# explanation: https://twitter.com/AlecMuffett/status/1011504656667770880
# v1.0 - alec.muffett@gmail.com 2018-06-26

# You need to have TorBrowser running locally to provide a SOCKS5
# relay to Tor on port 9150 (see below) for the Onion lookup to work.

TARGET="www.openrightsgroup.org"

TOR_PROXY="127.0.0.1:9150" # amend this, if your tor proxy is elsewhere

while read src url curl_opts; do
    echo ""
    echo :::: testing $src ::::
    curl -H 'accept: application/dns-json' $curl_opts $url
    echo ""
done <<EOF
google      https://dns.google.com/resolve?name=$TARGET
cloudflare  https://cloudflare-dns.com/dns-query?name=$TARGET
cf_onion    https://dns4torpnlfs2ifuz2s2yf3fc7rdmsbhm6rw75euj35pac6ap25zgqad.onion/dns-query?name=$TARGET -x socks5h://$TOR_PROXY/
EOF

exit 0
