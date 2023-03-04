#!@shell@

curl="@curl@/bin/curl"
dasel="@dasel@/bin/dasel"
systemctl="@systemd@/bin/systemctl"

dir="@directory@"
url="$1"

port="@port@"
socksport="@socksport@";
mixedport="@mixedport@";
loglevel="@loglevel@";
externalcontroller="@exct@";

set -e

mkdir -p $dir

if [ -f "$dir/config.yaml" ]; then
    echo 'Backup old config.yaml'
    cp "$dir/config.yaml" "$dir/config.yaml.old"
fi

function cleanup {
    if [ -f "$dir/config.yaml.old" ]; then
        echo 'Restore old config.yaml'
        cp "$dir/config.yaml.old" "$dir/config.yaml"
        rm "$dir/config.yaml.old"
    fi
}
trap cleanup EXIT

echo 'Downloading raw config.yaml...'
tmpfile=$(mktemp /tmp/update-clash-config.XXXXXX)
$curl "$url" \
  -A "clash" \
  --fail-with-body \
  --show-error \
  --output "$tmpfile"

echo 'Build config.yaml...'

$dasel put -r yaml -t int -f "$tmpfile" -v $mixedport '.mixed-port' -o "$dir/config.yaml"
$dasel put -r yaml -t int -f "$dir/config.yaml" -v $port '.port'
$dasel put -r yaml -t int -f "$dir/config.yaml" -v $socksport '.socks-port'
$dasel put -r yaml -t string -f "$dir/config.yaml" -v $loglevel '.log-level'
$dasel put -r yaml -t string -f "$dir/config.yaml" -v $externalcontroller '.external-controller'
# $dasel put -r yaml -t bool -f "$dir/config.yaml" -v true '.dns.enable'

echo 'Remove raw config.yaml...'
rm "$tmpfile"

echo 'Restarting clash...'
$systemctl restart clash
$systemctl status clash
if [ -f "$dir/config.yaml.old" ]; then
    echo 'Remove old config.yaml'
    rm "$dir/config.yaml.old"
fi
