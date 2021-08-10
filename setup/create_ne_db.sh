#!/bin/bash

sudo -u postgres psql -c "CREATE DATABASE natural_earth;"
sudo -u postgres psql -d natural_earth -c "CREATE EXTENSION postgis;"
sudo -u postgres psql -d natural_earth -c "CREATE EXTENSION hstore;"
