# TEM_image_analysis

![images_large_nn0c06809_0005](https://github.com/carryer123/TEM_image/assets/13994361/258df20f-e5e7-4037-b889-1b5507d59e40)

Abstract

Although transmission electron microscopy (TEM) may be one of the most efficient techniques available for studying the morphological characteristics of nanoparticles, analyzing them quantitatively in a statistical manner is exceedingly difficult. Herein, we report a method for mass-throughput analysis of the morphologies of nanoparticles by applying a genetic algorithm to an image analysis technique. The proposed method enables the analysis of over 150,000 nanoparticles with a high precision of 99.75% and a low false discovery rate of 0.25%. Furthermore, we clustered nanoparticles with similar morphological shapes into several groups for diverse statistical analyses. We determined that at least 1,500 nanoparticles are necessary to represent the total population of nanoparticles at a 95% credible interval. In addition, the number of TEM measurements and the average number of nanoparticles in each TEM image should be considered to ensure a satisfactory representation of nanoparticles using TEM images. Moreover, the statistical distribution of polydisperse nanoparticles plays a key role in accurately estimating their optical properties. We expect this method to become a powerful tool and aid in expanding nanoparticle-related research into the statistical domain for use in big data analysis.

# Program

Matlab_R2015b

# Training

The images are in the training folder.

EM_ga.m

# Test

I uploaded new_gene_97 version of gene.

run(gene, image, number)

# etc. 

There are some clustering, statistical analysis, etc. in the paper.

# Reference paper

https://pubs.acs.org/doi/full/10.1021/acsnano.0c06809
