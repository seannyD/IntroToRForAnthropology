library(ape)

setwd("~/Documents/Teaching/CARDIFF/RCourse/IntroToRForAnthropologists/analysis/")

# Data from https://github.com/D-PLACE/dplace-data/tree/master/phylogenies/bouckaert_et_al2012

taxa = read.csv("../data/indo_european_B_summary.csv",stringsAsFactors = F)
tree = read.nexus("../data/indo_european_B_summary.trees")

# Some tips match to the same glottocode, so exclude one of these:
matches = match(tree$tip.label,taxa$taxon)
dups = tree$tip.label[duplicated(taxa[matches,]$glottocode)]
tree = drop.tip(tree,dups)

# Exchange tip labels for glottocodes
tree$tip.label = taxa[match(tree$tip.label,taxa$taxon),]$glottocode
# Exclude tips without glottocodes
tree = drop.tip(tree,"")
# Write the tree
write.tree(tree, "../data/IndoEuropean_bouckaert_et_al2012_withGlottocodes.nex")
