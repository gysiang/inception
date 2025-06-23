echo "🧹 Cleaning up Docker containers, volumes, and host entries..."

cd "$(dirname "$0")"

# Step 1: Stop and remove all containers in your project
docker-compose down --volumes --remove-orphans

# Step 2: Remove dangling volumes and images (optional)
docker system prune -f --volumes

echo "✅ Cleanup complete."
