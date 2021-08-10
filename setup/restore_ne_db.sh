#!/bin/bash

sudo -u postgres pg_restore --dbname=$NE_DB_NAME $BASE_NE_DUMP_PATH -v --clean --jobs=20