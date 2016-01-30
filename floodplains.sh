## Download Hazus AAL by Census Blocks
wget https://data.femadata.com/Hazus/FloodProjects/AAL/National_AAL_Blocks.zip
unzip -u -o National_AAL_Blocks
rm National_AAL_Blocks.zip

## Download CA DFIRM -
wget https://hazards.fema.gov/nfhlv2/output/State/NFHL_06_20150608.zip
unzip -u -o NFHL_06_20150608
rm NFHL_06_20150608.zip

pgsql2shp -f cadfirm_a.shp shapes "select * from cadfirm_a"
fio cat cadfirm_a.shp --dst_crs EPSG:4326 | fio collect --precision 6 > cadfirm_a.json

pgsql2shp -f cadfirm_x.shp shapes "select * from cadfirm_x"
fio cat cadfirm_x.shp --dst_crs EPSG:4326 | fio collect --precision 6 > cadfirm_x.json

tippecanoe -o cafldzone.mbtiles -z 16 -Z 4 -ac -ar -ao cadfirm_a.json cadfirm_x.json


# create view cadfirm_a as SELECT "DFIRM_ID" dfirmid, "FLD_AR_ID" fldarid, 
#        lower("FLD_ZONE") fldzone, lower("ZONE_SUBTY") subzone, geom
#   FROM california.dfirm_ca_fldhaz_poly where "FLD_ZONE" like 'A%';

# create or replace view cadfirm_x as 
# SELECT "DFIRM_ID" dfirmid, "FLD_AR_ID" fldarid, 
#        lower("FLD_ZONE") fldzone, lower("ZONE_SUBTY") subzone, geom
#   FROM california.dfirm_ca_fldhaz_poly where "FLD_ZONE" like 'X%' and "ZONE_SUBTY" <> 'AREA OF MINIMAL FLOOD HAZARD'







## Pull CA from USGS small scale datasets
pgsql2shp -f ca_state.shp shapes "SELECT Lower(name) nm, Lower(state_abbr) stabr, state_fips, pop, geom FROM national.states_010 where state_fips='06'"

fio cat ca_state.shp --dst_crs EPSG:4326 | fio collect --precision 6 > ca_stgjsn.json

topojson -o ca_stpoly.json --id-property=STATE_FIPS -p -- ca_state.shp
rm ca_state*
rm ca_stpoly.json

ca_stpoly.json

# Topojson notes and shit
topojson -o final.json -e data.tsv --id-property=code_2,code -p code_2,state=name -- topojson.json
# https://stackoverflow.com/questions/18444261/how-to-add-properties-to-topojson-file
# Here, the input property "FIPS" is coerced to a number and used as the feature identifier; likewise, the column named "FIPS" is used as the identifier in the CSV file. (If your CSV file uses a different column name for the feature identifier, you can specify multiple id properties, such as --id-property=+FIPS,+id.)
# topojson \
#  --id-property postal \
#  -p postal \
#  -p name \
#  -o de-data.json \
#  states.json