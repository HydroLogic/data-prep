
## Download CA DFIRM -
wget https://hazards.fema.gov/nfhlv2/output/State/NFHL_06_20150608.zip
## Download Hazus AAL by Census Blocks
wget https://data.femadata.com/Hazus/FloodProjects/AAL/National_AAL_Blocks.zip
## Pull CA from USGS small scale datasets
pgsql2shp -f ca_state.shp shapes "SELECT Lower(name) nm, Lower(state_abbr) stabr, state_fips, pop, sq_miles, prim_miles, geom FROM national.states_010 where state_fips='06'"