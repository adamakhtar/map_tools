#!/bin/bash

sudo -u $DB_USER psql -c "CREATE DATABASE natural_earth;"
sudo -u $DB_USER psql -d natural_earth -c "CREATE EXTENSION postgis;"
sudo -u $DB_USER psql -d natural_earth -c "CREATE EXTENSION hstore;"
