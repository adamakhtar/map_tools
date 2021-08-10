#!/bin/bash

sudo -u postgres psql -c "CREATE DATABASE osm;"
sudo -u postgres psql -d osm -c "CREATE EXTENSION postgis;"
sudo -u postgres psql -d osm -c "CREATE EXTENSION hstore;"
