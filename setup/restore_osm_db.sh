#!/bin/bash

sudo -u $DB_USER pg_restore --dbname=$OSM_DB_NAME $BASE_OSM_DUMP_PATH -v --clean --jobs=20