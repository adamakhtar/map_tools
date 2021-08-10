#!/bin/bash

sudo pg_dump -h $DB_HOST -p $DB_PORT -U $DB_USER -F c -b -v -f $BASE_NE_DUMP_PATH $NE_DB_NAME