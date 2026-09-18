DB_HOST=db
DB_PORT=5432
DB_USER=postgres
PASS=test
NAME=$(date +%Y-%m-%d_%H-%M-%S)





PGPASSWORD=$PASS pg_dump -U $DB_USER -h $DB_HOST -p $DB_PORT > backup_$NAME.sql
