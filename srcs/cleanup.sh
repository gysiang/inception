echo "🧹 Cleaning up Docker containers, volumes, and host entries..."

cd "$(dirname "$0")"

# Step 1: Stop and remove all containers in your project
docker-compose down --volumes --remove-orphans

# Step 2: Remove dangling volumes and images (optional)
docker system prune -f --volumes

# Step 3: Remove 'gyong-si.42.fr' from /etc/hosts
HOST_ENTRY="gyong-si.42.fr"
if grep -q "$HOST_ENTRY" /etc/hosts; then
    echo "🔧 Removing $HOST_ENTRY from /etc/hosts"
    sudo sed -i "/$HOST_ENTRY/d" /etc/hosts
else
    echo "✅ No $HOST_ENTRY entry in /etc/hosts"
fi

echo "✅ Cleanup complete."
