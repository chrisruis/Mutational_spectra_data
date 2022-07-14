#Plots figure 4
#Plots PCA of lung and environmental spectra, C>A vs T>C for these spectra,
#spectrum subtractions, decomposition pie charts, hierarchical clustering for salmonella and
#DBS for skin pathogens

library(ggplot2)
library(grid)
library(ggpubr)
library(patchwork)
library(ade4)
library(ape)
library(ggtree)
library(argparse)

parser <- ArgumentParser()
parser$add_argument("-o", help = "Name of output PDF")
args <- parser$parse_args()

####Panel A - salmonella spectrum clustering
#Import the salmonella similarities as a matrix
sCosine <- as.matrix(read.csv("salmonella_cosine_similarity.csv", header = TRUE, row.names = 1))
#Convert the similarities to distances
sDistances <- 1 - sCosine
#Import salmonella sample annotations
sAnnotations <- read.csv("salmonella_sample_annotations.csv", header = TRUE, row.names = 1)
#Import salmonella niche colours and extract to list
sColours <- read.csv("salmonella_annotation_colours.csv", header = TRUE)
sLabels <- list()
for (i in 1:length(sColours[,1])) {
  sLabels[sColours[i,1]] <- sColours[i,2]}
#Cluster salmonella spectra
sFit_subs <- hclust(as.dist(sDistances), method = "average")
#Convert clustering to a tree
sFit_subs_tree <- hclust2phylog(sFit_subs)
sP <- ggtree(sFit_subs_tree) + geom_tiplab(size = 14)

####Panel B - skin DBS spectra
#Import the skin bacteria DBS spectra
acnes <- read.csv("C_acnes_DBS_spectrum.csv", header = TRUE, stringsAsFactors = FALSE)
acnes$SubstitutionFactor <- factor(acnes$Substitution, levels = acnes$Substitution)
acnes$Proportion_of_mutations <- acnes$Number_of_mutations/sum(acnes$Number_of_mutations)
epidermidis <- read.csv("S_epidermidis_DBS_spectrum.csv", header = TRUE, stringsAsFactors = FALSE)
epidermidis$SubstitutionFactor <- factor(epidermidis$Substitution, levels = epidermidis$Substitution)
epidermidis$Proportion_of_mutations <- epidermidis$Number_of_mutations/sum(epidermidis$Number_of_mutations)
#Label rectangles for acnes
acRect <- data.frame(Label = c("AA>NN", "AC>NN", "AG>NN", "AT>NN", "CA>NN", "CC>NN", "CG>NN", "GA>NN", "GC>NN", "TA>NN"), xmin = c(1, 10, 19, 28, 34, 43, 52, 58, 67, 73), xmax = c(9.5, 18.5, 27.5, 33.5, 42.5, 51.5, 57.5, 66.5, 72.5, 78.5), ymin = (max(acnes$Proportion_of_mutations) + (max(acnes$Proportion_of_mutations) * 0.05)), ymax = (max(acnes$Proportion_of_mutations) + (max(acnes$Proportion_of_mutations) * 0.25)))
epRect <- data.frame(Label = c("AA>NN", "AC>NN", "AG>NN", "AT>NN", "CA>NN", "CC>NN", "CG>NN", "GA>NN", "GC>NN", "TA>NN"), xmin = c(1, 10, 19, 28, 34, 43, 52, 58, 67, 73), xmax = c(9.5, 18.5, 27.5, 33.5, 42.5, 51.5, 57.5, 66.5, 72.5, 78.5), ymin = (max(epidermidis$Proportion_of_mutations) + (max(epidermidis$Proportion_of_mutations) * 0.05)), ymax = (max(epidermidis$Proportion_of_mutations) + (max(epidermidis$Proportion_of_mutations) * 0.25)))
#CC>TT label for C. acnes
ccLabel <- data.frame(Label = c("CC>TT"), X = c(64), Y = c(0.35))
ccArrow <- data.frame(X = c(58), Xend = c(51), Y = c(0.335), Yend = c(0.3))

#Colours for DBS spectrum plots
colours <- c("red", "red", "red", "red", "red", "red", "red", "red", "red", "limegreen", "limegreen", "limegreen", "limegreen", "limegreen", "limegreen", "limegreen", "limegreen", "limegreen", "gold", "gold", "gold", "gold", "gold", "gold", "gold", "gold", "gold", "dodgerblue", "dodgerblue", "dodgerblue", "dodgerblue", "dodgerblue", "dodgerblue", "orange", "orange", "orange", "orange", "orange", "orange", "orange", "orange", "orange", "mediumpurple", "mediumpurple", "mediumpurple", "mediumpurple", "mediumpurple", "mediumpurple", "mediumpurple", "mediumpurple", "mediumpurple", "cyan", "cyan", "cyan", "cyan", "cyan", "cyan", "magenta", "magenta", "magenta", "magenta", "magenta", "magenta", "magenta", "magenta", "magenta", "yellowgreen", "yellowgreen", "yellowgreen", "yellowgreen", "yellowgreen", "yellowgreen", "darksalmon", "darksalmon", "darksalmon", "darksalmon", "darksalmon", "darksalmon")
rectColours <- c("red", "limegreen", "gold", "dodgerblue", "orange", "mediumpurple", "cyan", "magenta", "yellowgreen", "darksalmon")

pdf(args$o, width = 30, height = 20)
#Empty label, used for padding
emptyLabel <- textGrob("")

####Panel A
#Plot salmonella clustering
sTPlot <- gheatmap(sP, sAnnotations, offset = 0.06, width = 0.3, colnames = FALSE) + scale_fill_manual(values = sLabels) + theme(legend.position = c(0.15, 0.8), legend.spacing.x = unit(0.5, "cm"), legend.spacing.y = unit(0.5, "cm"), legend.key.height = unit(2, "cm"), legend.key.width = unit(4, "cm"), legend.title = element_blank(), legend.text = element_text(size = 50)) + guides(fill = guide_legend(byrow = TRUE))
sTCombined <- ggarrange(emptyLabel, sTPlot, emptyLabel, ncol = 3, nrow = 1, widths = c(0.1, 0.8, 0.1))

####Panel B
#Plot skin pathogen DBS
aDPlot <- ggplot() + theme_classic() + scale_x_discrete(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0), limits = c(0, 0.46), breaks = c(0, 0.1, 0.2, 0.3, 0.4)) + geom_bar(data = acnes, aes(x = SubstitutionFactor, y = Proportion_of_mutations), stat = "identity", fill = colours) + geom_rect(data = acRect, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), fill = rectColours) + geom_text(data = acRect, aes(label = Label, x = (xmin + (xmax - xmin)/2), y = (ymin + (ymax - ymin)/2)), colour = "white", size = 8) + geom_text(data = ccLabel, aes(label = Label, x = X, y = Y), size = 16) + geom_segment(data = ccArrow, aes(x = X, xend = Xend, y = Y, yend = Yend), size = 2) + ggtitle(expression(italic("C. acnes"))) + theme(plot.title = element_text(size = 50, hjust = 0.5), axis.title = element_blank(), axis.text.x = element_blank(), axis.text.y = element_text(size = 30))
eDPlot <- ggplot() + theme_classic() + scale_x_discrete(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0), limits = c(0, 0.46), breaks = c(0, 0.1, 0.2, 0.3, 0.4)) + geom_bar(data = epidermidis, aes(x = SubstitutionFactor, y = Proportion_of_mutations), stat = "identity", fill = colours) + geom_rect(data = acRect, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), fill = rectColours) + geom_text(data = acRect, aes(label = Label, x = (xmin + (xmax - xmin)/2), y = (ymin + (ymax - ymin)/2)), colour = "white", size = 8) + ggtitle(expression(italic("S. epidermidis"))) + theme(plot.title = element_text(size = 50, hjust = 0.5), axis.title = element_blank(), axis.text.x = element_blank(), axis.text.y = element_text(size = 30))
sLabel <- textGrob("Proportion of double mutations", rot = 90, gp = gpar(fontsize = 40))
sPlot <- ggarrange(sLabel, aDPlot, eDPlot, ncol = 3, nrow = 1, widths = c(0.04, 0.48, 0.48))

combinedPlot <- ggarrange(sTCombined, sPlot, ncol = 1, nrow = 2, labels = c("A", "B"), font.label = list(size = 60))

print(combinedPlot)
dev.off()