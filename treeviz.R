library(dplyr)
library(tidyr)
library(stringr)
library(ape)
setwd("<path>")

#tree-building libraries
library(treedataverse)
library(TDbook)

library("treeio")
library("ggtree")
library("wakefield")
library("ggnewscale")
library("ggplot2")
options(ignore.negative.edge=TRUE)

nwk <- read.newick("~/Downloads/tree1-vbcg.nwk")
nwk <- read.newick("~/Downloads/tree2-new.nwk")
# review tree, does it require slicing?
#for examplepaeni_arbol <- as_tibble(paeni_tree) %>% slice(1:168) %>% select(label) # beyond 134 are bootstrap values

tre <- ggtree(nwk)+geom_tiplab(color="black", align=T, size=2, linetype=NA)
tre
#lets root this tree

rooted.tre <- root(nwk, which(nwk$tip.label == "GCF_000196515.1_ASM19651v1_genomic.fna")) # GCF_014023275.1_ASM1402327v1_genomic.fna Nostoc edaphicum outgroup
rooted.tre <- root(nwk, which(nwk$tip.label == "GCF_000009045.1_ASM904v1_genomic.fna")) #root with subtilis
ggtree(rooted.tre) + geom_tiplab() + geom_treescale()
# beautiful!