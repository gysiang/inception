HOST_ENTRY="127.0.0.1 gyong-si.42.fr"

if ! grep -q "$HOST_ENTRY" /etc/hosts; then
    echo "Adding $HOST_ENTRY to /etc/hosts"
    echo "$HOST_ENTRY" | sudo tee -a /etc/hosts > /dev/null
else
    echo "$HOST_ENTRY already exists in /etc/hosts"
fi
