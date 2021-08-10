#!/bin/bash

sudo pg_dump -h $DB_HOST -p $DB_PORT -U $DB_USER -F c -b -v -f $BASE_OSM_DUMP_PATH $OSM_DB_NAME