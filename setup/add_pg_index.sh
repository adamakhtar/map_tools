sudo -u postgres psql -U postgres -d osm -a -f $TEGOLA_OSM_PATH/postgis_helpers.sql
sudo -u postgres psql -U postgres -d osm -a -f $TEGOLA_OSM_PATH/postgis_index.sql
