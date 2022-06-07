# ADAM
Agrifood system Data Analysis Modeling framework

### read me file metadata
Author: \[ \
  { \
	  Author name: Gideon Kruseman \
	  Author affiliation: CIMMYT-CGIAR \
	  Author email: g.kruseman@cgiar.org \
  } \
\] \
Date: 6 April 2022 \
ADAM Version: 1.0.0 \
ADAM documentation version: 1.0.0.1 \
Status: under development 



## Purpose
The purpose of ADAM is to bring together tools and models that use a variety of data from many sources to support policy and investment decision making.

## Approach
Strict separation of underlying data, calculation rules and user settings. 
We try to achieve maximum transparency through open access and full documentation of tools and methods as well as the use of data tagged with rich metadata.
This allows for reproducibility of results, reuse of tools for new analyses.

![Figure1](https://user-images.githubusercontent.com/103105585/161967277-9c65d322-7fa1-4aa8-87e3-6ddee55b44c4.jpg)
Figure 1. Very broad overview of ADAM

The code  on the [ADAM GitHub repository](https://github.com/ForesightAndMetrics/ADAM) is developed and managed in the lower left hand box. This includes the code for testing ADAM.

## Underlying software and tools used
### Introduction
We strive to use open-source software solutions as much as possible. However that may not allways be possible. For instance there, to our knowledge, is no open source mathematical programming software available that allows the meaningful separation of model code (calculation rules), input data and user (control) settings.

### GAMS
[GAMS](https://www.gams.com/) is proprietary mathematical programming software. Many of the modules in ADAM can operate with a free license as they make only limited use of the solvers of GAMS. We use GAMS in ADAM because of its unrivaled transparency in coding/ scripts, especially when combined with the integrated development environment GTREE.
GAMS in combuination with GTREE (see below) is used by ADAM to manage workflows and keep data, calculation rules and user defined settings strictly separated while ensuring maximum transparency.

#### GTREE
GTREE is an integrated development environment until recently publicly available through the Wageningen Economic Research (WECR) [Gamstools website]([https://www.wecr.wur.nl/gamstools/index.htm](https://www.medictcare.nl/gamstools/)). The software is not available there anymore. While we figure out how to make it publicly available again, the software and tools that were in the public domain and meant to be usede by anyone, can be obtained through the [ADAM administrator](mailto:G.kruseman@cgiar.org).

### R
ADAM makes use of [R](https://cran.r-project.org/) for statistical analyses andthe generation of graphics. Where possible R based geo-spatial analysis tools are used.

### AWK
The conversion of data from a wide variety of data sources into standard interoperable formats requires the parsing of downloaded files. These files are generally structured files in a text format such as, but not limited to, CSV. [AWK](https://en.wikipedia.org/wiki/AWK) is a powerful test processing language used for data processing and reporting.  

### ARC-GIS
Although we aim at using open-source GIS software, some tools and approaches are done using ARC-GIS softeware 
