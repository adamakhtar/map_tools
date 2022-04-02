Copy .env.sample to .env and make sure to source it before running any scripts via `source ./.env`

## Setting up a server to process open street map data

The setup scripts use imposm to transform and store the open street map data into postgres.

It will require a powerful server to do this task.

30gm ram.
8-16cpu
1000gb storage (Ideally iOPS enabled)

> In my experience, with a pretty beefy AWS compute optimized instance (I don't recall how big, we should document this) with a high IOPS drive (the process is disk write intensive) we were able to get the data from the planent.pbf file into PostGIS with the generalized tables and the indexes in about 12-14 hours.

> we imported planet osm within 11.30 hours around with a Google cloud server
> spec : 8 vCPU, 30GB RAM and 1TB ( 400GB only used )

> Typically how space does the DB need?
> The database will need about 160GB if you don't use the import schema and just deploy production. If you want to use the import schema then you will need around 320GB, so I would suggest around 400GB to provide some padding.

### First attempt

On my first attempt I used the following

c6i.4xlarge (compute optimized 16cpu 32 gb mem). 12 hours costs $10~12
1000GB EBS: General purpose storage GP3 IOPS 6000 Throughput 125MBps (for 12 hours it costs approx 2 dollars)
