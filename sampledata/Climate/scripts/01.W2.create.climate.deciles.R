# this script will produce decile (10/50/90) maps for temperature and rainfall

library(SDMTools)
source('/home1/14/jc140298/NRM/dev/helperFunctions.R') # my.dataframe2asc

# define the location of the environmental layers
current_clim_dir = '/rdsi/vol08/wallace2/Climate/climgen.RCP/global/10arcminute/baseline.50to00/bioclim'
future_clim_dir = '/rdsi/vol08/wallace2/Climate/climgen.RCP/global/10arcminute/bioclim_asc'

# define working dirs
wd = '/rdsi/vol08/wallace2/W2/climate_summaries'

# define the years,  scenarios low/high, climate variables
swls = c(1.5, 2, 2.7, 3.2, 4.5, 6)
scenarios = c('AVOID50R85', 'AVOID50R26', 'AVOID50R45', 'AVOID50R60', 'AVOID50R85', 'AVOID90R85')
years = c(2024, 2084, 2084, 2084, 2084, 2084) 
climate = paste0('bioclim_', c('01', '04', '05', '06', '12', '15', '16', '17'))

## current - just copy original file
for (clim in climate) { 
	
	# create the output directory
	clim_wd = paste0(wd, '/', clim, '/current'); dir.create(clim_wd, recursive=T)

	# copy the current projection
	curr_proj = paste0(current_clim_dir, '/', clim, '.asc')
	system(paste0('cp ', curr_proj, ' ', clim_wd))
	system(paste0('gzip ', clim_wd, '/', clim, '.asc'))
}

# future - need to calculate deciles
# read in lon/lat 
df_locs =  read.csv('/rdsi/vol08/wallace2/W2/training.data/mask.pos.csv')

for (clim in climate) { cat('\n', clim)
	
	# create the output directory
	clim_wd = paste0(wd, '/', clim)
	deciles_wd = paste0(clim_wd, '/deciles'); dir.create(deciles_wd); setwd(deciles_wd)

	for (i in 1:length(swls)) { cat(swls[i],'...')

		# get a list of the gcm projections related to that swl scenario
		swl_scenarios = list.files(future_clim_dir, pattern=scenarios[i], full.names=TRUE)
		future_projs = swl_scenarios[grep(years[i], swl_scenarios)] #21
	
		# create variable for scenario name to use for naming files
		scname = paste0(sprintf('%.1f',swls[i]), '_', scenarios[i], '_', years[i])
		
		# create a matrix to hold the projections, one column per GCM (proj)
		df_proj = matrix(NA,nrow=length(df_locs$lon),ncol=length(future_projs))
		colnames(df_proj) = basename(future_projs)
		
		# read in each projection map and extract data values; one map per column
		for (i in 1:length(future_projs)) { cat(i, '...')

			# extract values for each cell from the projection map
			filename = paste0(future_projs[i], '/', clim, '.asc')
			df_proj[,basename(future_projs[i])] = extract.data(data.frame(df_locs$lon, df_locs$lat), 
				read.asc(filename))

		} # end for projections

		# calculate 10,50,90 deciles for each location
		out_deciles = apply(df_proj, 1, quantile, probs=c(0.10,0.50, 0.90), na.rm=TRUE, type=8)
			
		# use the deciles to create maps
		tenth = data.frame(cbind(df_locs$lat, df_locs$lon, t(out_deciles)[,1])); my.dataframe2asc(tenth, paste0(scname, '_tenth'), gz=TRUE)
		fiftieth = data.frame(cbind(df_locs$lat, df_locs$lon, t(out_deciles)[,2])); my.dataframe2asc(fiftieth, paste0(scname, '_fiftieth'), gz=TRUE)
		ninetieth = data.frame(cbind(df_locs$lat, df_locs$lon, t(out_deciles)[,3])); my.dataframe2asc(ninetieth, paste0(scname, '_ninetieth'), gz=TRUE)
	} # end for swl	
} # end clim