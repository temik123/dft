COUNT=$(ls backup_* 2>/dev/null | wc -l) 
OLDEST=$(ls backup_* | sort | head -n 1)

DB_HOST=db
DB_PORT=5432
DB_USER=postgres
PASS=test
NAME=$(date +%Y-%m-%d_%H-%M-%S)

echo "$COUNT"
if [ "$COUNT" -ge 3 ]; then
rm $OLDEST
echo "Backup $OLDEST has been removed"
else
echo "Backup count haven't reached 3 yet"
fi

if PGPASSWORD=$PASS pg_dump -U $DB_USER -h $DB_HOST -p $DB_PORT > backup_$NAME.sql; then
echo "Backup $NAME has been successfully created"
else 
echo "Backup creation failed"
fi
