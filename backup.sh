#!/bin/bash
# Simple backup script

SOURCE_DIR="${1:-$HOME/Documents}"
BACKUP_DIR="${2:-$HOME/backups}"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_${DATE}.tar.gz"

mkdir -p "$BACKUP_DIR"

echo "Starting backup..."
echo "Source: $SOURCE_DIR"
echo "Destination: $BACKUP_DIR/$BACKUP_NAME"

tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

if [ $? -eq 0 ]; then
    SIZE=$(du -h "$BACKUP_DIR/$BACKUP_NAME" | cut -f1)
    echo "Backup complete! Size: $SIZE"
else
    echo "Backup failed!"
    exit 1
fi

# Keep only last 5 backups
cd "$BACKUP_DIR" && ls -t backup_*.tar.gz | tail -n +6 | xargs rm -f 2>/dev/null
echo "Old backups cleaned up."
