library(ape)
library(phytools)
library(geiger)

setwd("~/Documents/Teaching/CARDIFF/RCourse/IntroToRForAnthropologists/analysis/")

# Load the data
d = read.csv("../data/RoofShapeData.csv", stringsAsFactors = F)

# Make a table of roof shape types
t(t(table(d$code_label)))

print(xtable(table(Frequency=d$code_label),
      caption = "Frequency of roof shape types",
      label = "roofFreq"),
      file="../results/RoofTypes_Frequency.tex")

# Check focal years
d$focal_year
range(d$focal_year)
table(round(d$focal_year/100))

d = d[d$focal_year >=1800,]

# Look at Indo-European
d = d[d$language_family== "Indo-European",]
# Select only one society per language
d = d[!duplicated(d$language_glottocode),]

# Plot data on phylogeny
roofTypes = factor(d$code_label)
names(roofTypes) = d$language_name

# Load phylogeny
tree = read.tree("../data/IndoEuropean_bouckaert_et_al2012_withGlottocodes.nex")

# Keep only tips with data
tipsWithoutData = tree$tip.label[!tree$tip.label %in% d$language_glottocode]
tree = drop.tip(tree, tipsWithoutData)

tree$tip.label = d[match(tree$tip.label,d$language_glottocode),]$language_name

roofTypes = roofTypes[names(roofTypes) %in% tree$tip.label]

# Plot the data
pdf("../results/IndoEuropean_RoofTypes.pdf")
  dotTree(tree,roofTypes)
  legend(0,4,c("Flat","2 slopes",'4 slopes'),
         col=c("black","red","green"),
         pch=16,
         title = "Roof Shape")
dev.off()

# Calculate phylogenetic signal
fit = fitDiscrete(tree,roofTypes,transform = "lambda")

cat(round(fit$opt$lambda,3),file="../results/IndoEuropean_RoofTypes_Lambda.txt")
