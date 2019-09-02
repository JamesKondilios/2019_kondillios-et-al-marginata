RESULTS: {#results .unnumbered}
=======

**Genomic Analysis**

Genotyping by sequencing

- Genotyping

- Quality control - removing snps, missing data etc. 

We performed a series of principle coordinate analysis on the SNP matrix, visually analysing the relationships between principle coordinates 1 and 2, geographic location, and bio-climatic variables 1-19. The first two principle coordinates were able to explain $2.6\%$ of total variance ($1.7\%$, and $0.9\%$ respectively). We found a positive curvilinear relationship between PCoA1 and Latitude. Furthermore, PCoA1 and PCoA2 generally differed by bio-climatic variables associated with temperature and seasonality. 

![PCAPLOT](/Users/jameskonda/Desktop/Landscape_Genomics/E_marginata_Papers/kondillios_et_al/figures/PCAPLOT.png)

![PCAvsLat](/Users/jameskonda/Desktop/Landscape_Genomics/E_marginata_Papers/kondillios_et_al/figures/PCAvsLat.png)

**Generalised dissimilarity model** 

From the original $19$ bioclim variables, 5 were selected to be included into the final model. Permutation testing revealed that the optimal model included 5 variables, and that including any more would result in diminishing returns for deviance explained. These were *geographic location*, *Isothermality* (bioclim3), *mean temprature of warmest quarter* (bioclim10), *min temprature of coldest month* (bioclim6), and *precipitation of warmest quarter* (bioclim18). 

The final GDM including these 5 variables  was able to explain 36.17% of overall model deviance. We validated the models predictive ability using cross validation. This was performed by training a model on a random 70% of the data, and testing on the remaining 30%. Pearsons correlation was then calculated between the predicted and observed genomic distances. This was repeated 100 times, resulting in a median Pearsons correlation between predicted and observed genomic distances of 0.6. 

The final GDM indicated that for samples less than 100km in distance, there was no relationship between geographic distance and genomic distance. For samples greater than 100km in distance apart, the GDM indicated a positive curvilinear relationship between envirobmental distance and genomic distance.

We projected the GDM model on to the current environmental landscape using current values of the environmental variables. Dimensionality was reduced using PCA, with the first three principle components being assigned RGB colours to visualise genomic composition. This illuminated three regions of high genomic similarity, coastal, inland and south, all of which appearing to differ in genomic composition from eachother. 



![tidy_gdm_splines](/Users/jameskonda/Desktop/Landscape_Genomics/E_marginata_Papers/kondillios_et_al/figures/tidy_gdm_splines.png)



# rasters of genomic distance now & future

![image-20190827163327320](/Users/jameskonda/Library/Application Support/typora-user-images/image-20190827163327320.png)



![image-20190827163352283](/Users/jameskonda/Library/Application Support/typora-user-images/image-20190827163352283.png)



# Pretend restoration experiment

take a point. calculate radius around it that would be good for seed sourcing. see Bragg/Rosetto's Restore & Renew paper & website



