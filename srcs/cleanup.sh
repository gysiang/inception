echo "🧹 Cleaning up Docker containers, volumes, and host entries..."

cd "$(dirname "$0")"

docker compose down --volumes --remove-orphans

docker system prune -f --volumes

sudo rm -rf /home/gyong-si/data/mariadb/*
sudo rm -rf /home/gyong-si/data/wordpress/*

echo "✅ Cleanup complete."
