cd "$(dirname "$0")"

docker-compose down --volumes --remove-orphans

docker system prune -f --volumes

HOST_ENTRY="gyong-si.42.fr"
if grep -q "$HOST_ENTRY" /etc/hosts; then
    echo "🔧 Removing $HOST_ENTRY from /etc/hosts"
    sudo sed -i "/$HOST_ENTRY/d" /etc/hosts
else
    echo "✅ No $HOST_ENTRY entry in /etc/hosts"
fi

echo "✅ Cleanup complete.
