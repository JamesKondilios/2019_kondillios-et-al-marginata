Methods {#methods .unnumbered}
=======

**Bio-climatic Data collection**:

Past, and future predicted data for 19 global bio-climatic variables for 1975 and 2070 respectively, were obtained from the WorldClim database in raster format, with square cells 2.5 minutes (of a degree) in diameter \cite{}. The variables downloaded included bioclim variables 1 to 19 (Table X). Past bio-climatic variables are raster interpolations of observed data at climate stations between 1960 and 1990. Data for future (2070) predicted bio-climatic variables was based on the Average consensus (relative concentration pathway 8.5) from down-scaled global climate models data from the Coupled Model Intercomparison Project 5 (CMIP5; IPPC Fifth Assessment). 

```
Bioclim number | Feature (units)             
						---|---
bioclim1  		 | Annual mean temperature (°C)   			   
bioclim2  		 | Mean diurnal temperature range (°C)         
bioclim3  		 | Isothermality      									 
bioclim4  		 | Temperature seasonality 						 	 
bioclim5  		 | Max temperature of warmest week (°C)   
bioclim6  		 | Min temperature of coldest week (°C)   
bioclim7  		 | Temperature annual range (°C) 				  
bioclim8  		 | Mean temperature of wettest quarter(°C)
bioclim9  		 | Mean temperature of driest quarter (°C) 
bioclim10  		 | Mean temperature of warmest quarter (°C)
bioclim11  		 | Mean temperature of coldest quarter (°C)
bioclim12   	 | Annual precipitation (mm)   					 
bioclim13   	 | Precipitation of wettest week (mm)     
bioclim14   	 | Precipitation of driest week (mm)      
bioclim15   	 | Precipitation seasonality              
bioclim16   	 | Precipitation of wettest quarter (mm)  
bioclim17   	 | Precipitation of driest quarter (mm)   
bioclim18   	 | Precipitation of warmest quarter (mm)  
bioclim19   	 | Precipitation of coldest quarter (mm)  
```

**Sample collection:**

Native species range data of *E. marginata* (Domm ex Sm.) was obtained from the Atlas of Living Australia. This data was filtered to exclusively include observations of *E. marginata* in Western Australia. The resulting observations (n=1346) clustered in the southern region of Western Australia (Fig 1B). A species occurrence polygon of the *E. marginata* native species range was then produced in R using the *ahull* and *ashape* functions (Fig 1C; [@Pateiro-Lopez2010]). This polygon was created for the later purpose of projecting our GDM onto. We collected 284 E. marginata leaf samples from mature trees falling along 5 geographical transects (Fig 1A) within the native species range. We did not perform a power analysis to determine sample size during the design of this study.

![Figure 1: Sampling and species distribution of Eucalyptus marginata across Western Australia. **A**, Sample distribution of Eucalyptus marginata across southern region of Western Australia (n=284). Sampling transects labelled T1 to T5. **B**, Natural species distribution of Eucalyptus marginata across Western Australia; Atlas of Living Australia (cite ala). **C**, Distribution polygon of the Eucalyptus marginata distribution illustrated in B. **D**, overlay of the E. marginata sample distribution (orange), E. marginata natural species distribution (navy), and E. marginata species distribution polygon (pink).](figures/E_marg_sample_dist.png){#Fig1 width=100%}



**Genotyping by sequencing:**

Approximately 50 mg of leaf tissue was used during the extraction of DNA from each of our sampled individuals. This was conducted using the \"the Qiagen DNeasy Plant 96 Kit, digested with PstI for reduced genome complexity, and were ligated with a unique adapter pair. Each sample was then individually amplified using PCR. Samples were pooled in equimolar concentrations, and library amplicons (between 350 bp and 600 bp) were extracted from an agarose gel. The resulting library pool was sequenced using a modified Genotyping-By-Sequencing (GBS) protocol [@Elshire2011] on an Illumina HiSeq2500 using a 101 bp paired-end protocol at the Biomolecular Resource Facility at the Australian National University. Approximately XYZ million read pairs were generated during this process.

**Quality control:**

Quality control of the raw GBS sequencing reads was performed with FastQC (v0.10.1, [@SAndrews]). Read demultiplexing of sequencing reads was conducted using AXE [@Murray2018]. Subsequently $X \%$ of read pairs were not able to be assigned to a sample. The reads of each sample were cleaned using the default parameters of the *trimit* function from libqcpp library (v0.2.5, [@Murray2017]). Cleaning involved removal of small fragments read as adapters ( $X\%$ of read pairs), merging overlapping read pairs ($X\%$) and quality trimming ($X\%$). A custom script was used to check for, and subsequently remove reads that did not begin with the expected restriction site sequence ($X\%$ of reads). Sequencing reads were then aligned to the Eucalyptus *grandis* reference genome [@JGI2015; @Bartholome2015; @Myburg2014] using bwa-mem (v0.7.5a-r405, [@Li2013]), however non-nuclear scaffolds were disregarded. $X\%$ of reads successfully mapped to the reference.

Variants for each sample were called using GATK's HaplotypeCaller in GVCF mode (v3.6--0-g89b7209, [@McKenna2010]). For this process, heterozygosity was set to 0.005, indel heterozygosity set to 0.0005, with the min number of reads sharing the same alignment start set to 4. GATK's joint genotyping was re-run on the final set of reads.  Indels, non-variant SNPs (to the reference), and non-biallelic SNPs were removed also using GATK [@McKenna2010].

-   **Directly copied from megans:** \"We determined final filtering thresholds by examining parameter distributions. A locus was retained for subsequent analysis if ExcessHet \< 13.0 ('phred-scaled p-value for exact test of excess heterozygosity'), -0.3 \< InbreedingCoeff \< 0.3 ('likelihood-based test for the inbreeding among samples'), MQ \> 15.0 ('Root Mean Square of the mapping quality of reads across all samples'), -10.0 \< MQRankSum \< 10.0 ('Rank Sum Test for mapping qualities of REF versus ALT reads'), and QD \> 8.0 ('ariant call confidence normalized by depth of sample reads supporting a variant'). We ran a second preliminary PCoA analysis to identify additional outlier samples. Finally, we used VCFtools (v0.1.12b, [@Danecek2011]) to remove SNPs with greater than 60$\%$missing data and thin the SNPs so that none were closer than 300 bp.\"

Genomic Analysis
----------------

**Exploratory analysis**

We imported a genotype matrix csv file into a sample-by-SNP matrix (x samples by y snps). This was conducted using the `df2genind` function from the adegenet library[@Jombart2011]. The resulting genotype matrix was then used to calculate a sample-by-sample, pairwise Euclidean distance matrix using the `dist` function [@TeamRDevelopmentCore2011]. To reduce the dimensionality of this matrix and summarise general patterns between pairwise genetic distance of samples, we performed a principle coordinates analysis using the `cmdscale` function from the *stats* library [@TeamRDevelopmentCore2011]. The maximum number of dimensions of the space representing data was set to 9 (k = 9). Principle coordinates 1 and 2 for each sample were then added as columns to a data frame object containing accession metadata and 22 bio-climatic measurements at the locations of each sampled individual. Relationships between principle coordinates 1 and 2 of the genetic distance matrix, geographic location, and bio-climatic variables were then visualised and examined using the ggplot2 graphics library [@Wickham2016].

**Generalised dissimilarity modelling:**

To model genomic variation as a function of environment and geography, a Generalized Dissimilarity Model (GDM) was used [@Ferrier2007; @Fitzpatrick2015]. This method, based on matrix regression, is able to account for non-linear relationships between the rate of genetic variation along environmental gradients, and the curvilinear relationship between genetic distance and geographical distance. This method was also used to predict "genomic vulnerability" [@Bay2018], by first training a model on current environmental conditions, then predicting on future environmental conditions. This is done under the assumption that the relationships between genetic variation and environmental conditions remains constant.

**GDM - Variable selection:**

Candidate variables for the final model were identified using a two step variable selection process was used. First, to reduce the list of variables, an individual GDM was fit for each variable, with only that variable as an explanatory variable (GDM version ; [@Ferrier2007]). Variables which were able to explain $>5\%$ of overall model deviance were then shortlisted for a backwards selection process. Backwards selection was then performed on the variables in the shortlist. This was performed using the `gdm.varImp` function (GDM; [@Ferrier2007]), with 1000 permutations per variable removed. This process identified that a model which included more than 5 variables would have diminishing returns in terms of overall percent deviance explained and result in over-fitting of the model. Geographic location, Isothermality, Min Temperature of Coldest Month, Mean Temperature of Warmest Quarter, Precipitation of Warmest Quarter were used as explanatory variables in the final model.

**GDM - Projection:**

To project our GDM onto the spatial plane defined previously by our species distribution polygon, we transformed the environmental rasters which were selected in our final model, and transformed them according to the model splines of the GDM using `gdm.transorm` (GDM v ; [@Ferrier2007]). We then performed a principal component analysis of these transformed layers and predicted the principle components across space using the `prcomp` and `predict` functions [@TeamRDevelopmentCore2011].  

We then visualised the first 3 principle components by assigning each principle component an red-green-blue colour scale [@Rstoolbox]. To project the GDM onto a future climate scenario, the above steps were repeated using the 2070 predicted bio-climatic rasters for the same variables. Genomic vulnerability was then calculated using the methods described by Bay et al (Science, 2018).

**GDM - Cross validation:**

To cross validate the predictive ability of the model and choice of variables, the sample data was partitioned into a training set ( $70\%$ of observations) and a test set ( $30\%$ of observations). A GDM was then trained on the training set using the same environmental variables as those included in the final model. This GDM was then fed the environmental variables corresponding to the observations in the test set, and predicted genomic dissimilarity between the test site. Pearson's correlation was then calculated between the predicted genomic dissimilarity between the test sites and the true genomic dissimilarity between the observed test sites, and this value was stored. This process was repeated 100 times, sampling a new test and training set at random from the original dataset.

**Data access:**

[ not yet ]