#!/bin/bash

sudo -u $DB_USER psql -c "CREATE DATABASE osm;"
sudo -u $DB_USER psql -d osm -c "CREATE EXTENSION postgis;"
sudo -u $DB_USER psql -d osm -c "CREATE EXTENSION hstore;"
