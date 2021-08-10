sudo -u postgres psql -c "DROP DATABASE osm;"

./create_osm_db.sh
./restore_osm_db.sh