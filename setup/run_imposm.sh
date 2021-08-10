~/imposm/imposm import \
                -connection postgis://$DB_USER:$DB_PW@$DB_HOST/$OSM_DB_NAME \
                -mapping tegola-osm/imposm3.json \
                -read ~/map.osm.pbf \
                -write -optimize -diff -overwritecache \
                -cachedir ~/$FILECACHE_BASEPATH/cache \
                -diffdir ~/$FILECACHE_BASEPATH/diff

~/imposm/imposm  import  -connection postgis://$DB_USER:$DB_PW@$DB_HOST/$OSM_DB_NAME \
                         -mapping tegola-osm/imposm3.json \
                         -deployproduction \
                         -cachedir ~/$FILECACHE_BASEPATH/cache
