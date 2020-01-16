# script to create climate summary files for each region and bioclim variable

library(SDMTools)
library(raster)

# define the working directories
wd = '/rdsi/vol08/wallace2/W2/climate_summaries'
climate_dir = '/rdsi/vol08/wallace2/W2/climate_summaries'
bioclims = paste0('bioclim_', c('01', '04', '05', '06', '12', '15', '16', '17'))

# read in base csv
base_csv = read.csv('/rdsi/vol08/wallace2/W2/training.data/mask.pos.csv')[,c('lat', 'lon')]
# row col lat lon ecozone0.5 ecozone0.01 area avoid.regions wwf_pp ecozone0.01.v2

# read in wwwf terr ecosystems and extract for base pos
wwf_terr = read.asc.gz('/rdsi/vol08/wallace2/W2/wwf_terr_ecos_clipped.asc.gz')
base_csv[,'wwf_terr_ecos'] = extract.data(cbind(base_csv$lon, base_csv$lat), wwf_terr)

swls = c(1.5, 2.0, 2.7, 3.2, 4.5, 6.0)
scenarios = c('AVOID50R85', 'AVOID50R26', 'AVOID50R45', 'AVOID50R60', 'AVOID50R85', 'AVOID90R85')
years = c(2024, 2084, 2084, 2084, 2084, 2084) 

for (bioclim in bioclims) { cat('\n', bioclim)

	bioclim_dir = paste0(climate_dir, '/', bioclim)
	
	# create a summary csv of values in each location(cell)
	curr_asc = read.asc.gz(paste0(bioclim_dir, '/current/', bioclim, '.asc.gz'))
	current_vals = extract.data(cbind(base_csv$lon, base_csv$lat), raster(curr_asc))
	base_csv[,'current'] = current_vals

	# extract projected value for each scenario/year/deciles	
	# define scenarios
	eses = paste0(sprintf('%.1f',swls), '_', scenarios, '_', years)
	deciles = c('tenth', 'fiftieth', 'ninetieth')
	
	deciles_dir = paste0(bioclim_dir, '/deciles')

	for (es in eses) { cat(es, '\n')

			for (dec in deciles) { cat(dec, '\n')
			
				# define column name
				sc_name = paste0(es, '_', dec)
				
				# define filename and read in asc
				filename = paste0(deciles_dir, '/', es, '_', dec, '.asc.gz')
				proj_asc = read.asc.gz(filename)
				
				# extract values for each location and add to output
				proj_vals = extract.data(cbind(base_csv$lon, base_csv$lat), raster(proj_asc))
				base_csv[,sc_name] = proj_vals
			} # end deciles
	} # end eses

	# define regions
	regions = c('wwf_terr_ecos')

	# create separate summary files of values for each region	
	for (reg in regions) { cat(reg, '\n')
	
		# determine which column has region data	
		region_col = which(colnames(base_csv) == reg)
		# restrict the data to that particular region and remove NA's
		region_data = as.matrix(na.omit(base_csv[,c(region_col,4:22)]))
		# group the data by state subregion and calculate min, mean, and max		
		region_min = aggregate(region_data, list(region_data[,reg]), FUN=min)
		colnames(region_min)[4:21] = paste0(colnames(region_min)[4:21], '_min')	
		region_max = aggregate(region_data, list(region_data[,reg]), FUN=max)
		colnames(region_max)[4:21] = paste0(colnames(region_max)[4:21], '_max')
		region_mean = aggregate(region_data, list(region_data[,reg]), FUN=mean)	
		colnames(region_mean)[4:21] = paste0(colnames(region_mean)[4:21], '_mean')

		region_summary = cbind(region_min, region_max[3:21], region_mean[3:21])

		# save output
		write.csv(region_summary[,-1], paste0(deciles_dir, '/', reg, '.summary.', bioclim, '.csv'), 
			row.names=FALSE)
	} # end for region	
} # end for bioclim
