sudo -u postgres psql -U postgres -d osm -a -f tegola-osm/postgis_helpers.sql
sudo -u postgres psql -U postgres -d osm -a -f tegola-osm/postgis_index.sql
