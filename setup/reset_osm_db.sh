sudo -u $DB_USER psql -c "DROP DATABASE osm;"

./create_osm_db.sh
./restore_osm_db.sh