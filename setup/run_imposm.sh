~/imposm/imposm import \
                -connection postgis://$DB_USER:$DB_PW@$DB_HOST/$OSM_DB_NAME \
                -mapping $TEGOLA_OSM_PATH/imposm3.json \
                -read $OSM_MAP_PATH \
                -write -optimize -overwritecache \
                -cachedir ~/$FILECACHE_BASEPATH/cache \

~/imposm/imposm  import  -connection postgis://$DB_USER:$DB_PW@$DB_HOST/$OSM_DB_NAME \
                         -mapping $TEGOLA_OSM_PATH/imposm3.json \
                         -deployproduction \
                         -cachedir ~/$FILECACHE_BASEPATH/cache
