#Plots figure 1 containing UMAP of all spectra and example spectrum plots

library(ggplot2)
library(ggpubr)
library(grid)
library(umap)
library(argparse)

parser <- ArgumentParser()
parser$add_argument("-o", help = "Name of output pdf")
args <- parser$parse_args()

set.seed(10)

#Import SBS spectra and transpose
sbsSpectra <- read.csv("all_spectra_combined_proportions.csv", header = TRUE, row.names = 1, stringsAsFactors = FALSE)
sbs <- t(sbsSpectra)

#Campylobacter spectra
campylobacter <- c("C_jejuni_cluster2","C_jejuni_cluster5","C_jejuni_cluster6","C_jejuni_cluster7","C_jejuni_cluster8")
#Environmental spectra
environmental <- c("M_abscessus_environmental","M_canettii","M_avium","M_intracellulare","M_chimaera","M_kansasii_non_MKMC","M_kansasii_MKMC","B_pseudomallei_group1","B_pseudomallei_group2","B_pseudomallei_group3","B_pseudomallei_group4","B_pseudomallei_group5")
#Streptococcus spectra
streptococcus <- c("S_pneumoniae_GPSC1","S_pneumoniae_GPSC2","S_pneumoniae_GPSC3","S_pneumoniae_GPSC6","S_pneumoniae_GPSC54","S_agalactiae_CC1","S_agalactiae_CC10","S_agalactiae_CC17","S_agalactiae_CC19","S_agalactiae_CC23","S_pyogenes_phylogroup0","S_pyogenes_phylogroup1","S_pyogenes_phylogroup2","S_pyogenes_phylogroup3")
#Staphylococcus spectra
staphylococcus <- c("S_aureus_ST22","S_aureus_ST239","S_aureus_ST772","S_aureus_CC398","S_epidermidis_groupA","S_epidermidis_groupB","S_epidermidis_groupC","S_haemolyticus")
#Enterococcus spectra
enterococcus <- c("E_faecalis_pp2","E_faecalis_pp6","E_faecalis_pp7")
#E coli spectra
e_coli <- c("E_coli_lineage11","E_coli_lineage12","E_coli_lineage14","E_coli_lineage34","S_sonnei_lineage1","S_sonnei_lineage2","S_sonnei_lineage3","S_flexneri_PG3")
#Lung mycobacteria spectra
lung_mycobacteria <- c("M_abscessus_DCCs","M_tuberculosis_lineage1","M_tuberculosis_lineage2","M_tuberculosis_lineage3","M_tuberculosis_lineage4","M_tuberculosis_lineage5","M_tuberculosis_lineage6","M_tuberculosis_lineage7","M_tuberculosis_orygis","M_tuberculosis_caprae","M_tuberculosis_bovis")
#Klebsiella spectra
klebsiella <- c("K_pneumoniae_ST11","K_pneumoniae_ST23","K_pneumoniae_ST101","K_pneumoniae_ST147","K_pneumoniae_ST258_512")
#Pseudomonas spectra
pseudomonas <- c("P_aeruginosa_ST17","P_aeruginosa_ST111","P_aeruginosa_ST146","P_aeruginosa_ST175","P_aeruginosa_ST253")
#Legionella spectra
legionella <- c("L_pneumophila_ST1", "L_pneumophila_environmental")

#UMAP of SBS spectra
sU <- umap(sbs)
sUmap <- data.frame(X = sU$layout[,1], Y = sU$layout[,2], Type = "Other")
sUmap$Type[which(row.names(sUmap) %in% campylobacter)] <- "Campylobacter"
sUmap$Type[which(row.names(sUmap) %in% environmental)] <- "Environmental"
sUmap$Type[which(row.names(sUmap) %in% streptococcus)] <- "Streptococcus"
sUmap$Type[which(row.names(sUmap) %in% staphylococcus)] <- "Staphylococcus"
sUmap$Type[which(row.names(sUmap) %in% enterococcus)] <- "Enterococcus"
sUmap$Type[which(row.names(sUmap) %in% e_coli)] <- "E. coli"
sUmap$Type[which(row.names(sUmap) %in% lung_mycobacteria)] <- "Lung mycobacteria"
sUmap$Type[which(row.names(sUmap) == "B_cenocepacia_ECs")] <- "B. cenocepacia ECs"
sUmap$Type[which(row.names(sUmap) %in% klebsiella)] <- "Klebsiella"
sUmap$Type[which(row.names(sUmap) %in% pseudomonas)] <- "Pseudomonas"

#Data to plot arrows on UMAP plot
uArrows <- data.frame(X = c(-2.35, -2.39, -1.25, 0.5, 2.37, 1.524), Y = c(4.67, 2.66, -2.07, -4.836, -0.25, -3.2), Xend = c(-1.98, -1.78, -0.88, 1.11, 2.37, 1.524), Yend = c(4.12, 2.66, -1.52, -4.836, -1.04, -2.38), Label = c("Environmental", "Lung mycobacteria", "E. coli", "Campylobacter", "Streptococcus", "Staphylococcus"))

#Colours for manual colours plot
colours <- list()
colours$Other <- "grey70"
colours$Campylobacter <- "purple"
colours$Environmental <- "green4"
colours$Streptococcus <- "dodgerblue"
colours$Staphylococcus <- "firebrick"
colours$Enterococcus <- "gold"
colours$"E. coli" <- "orange"
colours$"Lung mycobacteria" <- "skyblue"
colours$"B. cenocepacia ECs" <- "black"
colours$Klebsiella <- "magenta"
colours$Pseudomonas <- "plum"

#Extract spectra to plot
envAbs <- data.frame(Substitution = row.names(sbsSpectra), Proportion_of_mutations = sbsSpectra$M_abscessus_environmental)
envAbs$SubstitutionFactor <- factor(envAbs$Substitution, levels = envAbs$Substitution)
envAbsRect <- data.frame(Label = c("C>A", "C>G", "C>T", "T>A", "T>C", "T>G"), xmin = c(1, 17, 33, 49, 65, 81), xmax = c(16.5, 32.5, 48.5, 64.5, 80.5, 96.5), ymin = (max(envAbs$Proportion_of_mutations) + (max(envAbs$Proportion_of_mutations) * 0.05)), ymax = (max(envAbs$Proportion_of_mutations) + (max(envAbs$Proportion_of_mutations) * 0.25)))
dccs <- data.frame(Substitution = row.names(sbsSpectra), Proportion_of_mutations = sbsSpectra$M_abscessus_DCCs)
dccs$SubstitutionFactor <- factor(dccs$Substitution, levels = dccs$Substitution)
dccsRect <- data.frame(Label = c("C>A", "C>G", "C>T", "T>A", "T>C", "T>G"), xmin = c(1, 17, 33, 49, 65, 81), xmax = c(16.5, 32.5, 48.5, 64.5, 80.5, 96.5), ymin = (max(dccs$Proportion_of_mutations) + (max(dccs$Proportion_of_mutations) * 0.05)), ymax = (max(dccs$Proportion_of_mutations) + (max(dccs$Proportion_of_mutations) * 0.25)))
ecoli <- data.frame(Substitution = row.names(sbsSpectra), Proportion_of_mutations = sbsSpectra$E_coli_lineage11)
ecoli$SubstitutionFactor <- factor(ecoli$Substitution, levels = ecoli$Substitution)
ecoliRect <- data.frame(Label = c("C>A", "C>G", "C>T", "T>A", "T>C", "T>G"), xmin = c(1, 17, 33, 49, 65, 81), xmax = c(16.5, 32.5, 48.5, 64.5, 80.5, 96.5), ymin = (max(ecoli$Proportion_of_mutations) + (max(ecoli$Proportion_of_mutations) * 0.05)), ymax = (max(ecoli$Proportion_of_mutations) + (max(ecoli$Proportion_of_mutations) * 0.25)))
campy <- data.frame(Substitution = row.names(sbsSpectra), Proportion_of_mutations = sbsSpectra$C_jejuni_cluster2)
campy$SubstitutionFactor <- factor(campy$Substitution, levels = campy$Substitution)
campyRect <- data.frame(Label = c("C>A", "C>G", "C>T", "T>A", "T>C", "T>G"), xmin = c(1, 17, 33, 49, 65, 81), xmax = c(16.5, 32.5, 48.5, 64.5, 80.5, 96.5), ymin = (max(campy$Proportion_of_mutations) + (max(campy$Proportion_of_mutations) * 0.05)), ymax = (max(campy$Proportion_of_mutations) + (max(campy$Proportion_of_mutations) * 0.25)))
GPSC1 <- data.frame(Substitution = row.names(sbsSpectra), Proportion_of_mutations = sbsSpectra$S_pneumoniae_GPSC1)
GPSC1$SubstitutionFactor <- factor(GPSC1$Substitution, levels = GPSC1$Substitution)
GPSC1Rect <- data.frame(Label = c("C>A", "C>G", "C>T", "T>A", "T>C", "T>G"), xmin = c(1, 17, 33, 49, 65, 81), xmax = c(16.5, 32.5, 48.5, 64.5, 80.5, 96.5), ymin = (max(GPSC1$Proportion_of_mutations) + (max(GPSC1$Proportion_of_mutations) * 0.05)), ymax = (max(GPSC1$Proportion_of_mutations) + (max(GPSC1$Proportion_of_mutations) * 0.25)))
st22 <- data.frame(Substitution = row.names(sbsSpectra), Proportion_of_mutations = sbsSpectra$S_aureus_ST22)
st22$SubstitutionFactor <- factor(st22$Substitution, levels = st22$Substitution)
st22Rect <- data.frame(Label = c("C>A", "C>G", "C>T", "T>A", "T>C", "T>G"), xmin = c(1, 17, 33, 49, 65, 81), xmax = c(16.5, 32.5, 48.5, 64.5, 80.5, 96.5), ymin = (max(st22$Proportion_of_mutations) + (max(st22$Proportion_of_mutations) * 0.05)), ymax = (max(st22$Proportion_of_mutations) + (max(st22$Proportion_of_mutations) * 0.25)))

#Colours for spectrum plot
spectrumColours <- c(rep("blue", 16), rep("black", 16), rep("red", 16), rep("grey50", 16), rep("green4", 16), rep("pink", 16))
rectColours <- c("blue", "black", "red", "grey50", "green4", "pink")

#write.table(sUmap, "spectra_umap_coordinates.csv", row.names = TRUE, quote = FALSE, sep = ",")

pdf(args$o, height = 40, width = 30)
#Plot SBS UMAP coloured manually
sUPlot <- ggplot() + theme_bw() + geom_point(data = sUmap, aes(x = X, y = Y, colour = Type), size = 8) + scale_colour_manual(values = colours) + xlab("UMAP 1") + ylab("UMAP 2") + theme(legend.title = element_blank(), legend.key.size = unit(2, "cm"), legend.text = element_text(size = 40), axis.title = element_text(size = 40), axis.text = element_text(size = 40))
sUArrows <- sUPlot + geom_segment(data = uArrows, aes(x = X, y = Y, xend = Xend, yend = Yend, colour = Label), size = 4) + scale_colour_manual(values = colours)

#Empty label for spacing
emptyLabel <- textGrob("")

#Plot spectra
envAbsPlot <- ggplot() + theme_classic() + scale_x_discrete(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0)) + geom_bar(data = envAbs, aes(x = SubstitutionFactor, y = Proportion_of_mutations), stat = "identity", fill = spectrumColours) + geom_rect(data = envAbsRect, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), fill = rectColours) + geom_text(data = envAbsRect, aes(label = Label, x = (xmin + (xmax - xmin)/2), y = (ymin + (ymax - ymin)/2)), colour = "white", size = 8) + ggtitle(expression(paste(italic("M. abscessus"), " environmental", sep = ""))) + theme(plot.title = element_text(size = 40, hjust = 0.5, colour = "green4"), axis.title = element_blank(), axis.text.x = element_blank(), axis.text.y = element_text(size = 30))
dccsPlot <- ggplot() + theme_classic() + scale_x_discrete(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0)) + geom_bar(data = dccs, aes(x = SubstitutionFactor, y = Proportion_of_mutations), stat = "identity", fill = spectrumColours) + geom_rect(data = dccsRect, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), fill = rectColours) + geom_text(data = dccsRect, aes(label = Label, x = (xmin + (xmax - xmin)/2), y = (ymin + (ymax - ymin)/2)), colour = "white", size = 8) + ggtitle(expression(paste(italic("M. abscessus"), " DCCs", sep = ""))) + theme(plot.title = element_text(size = 40, hjust = 0.5, colour = "skyblue"), axis.title = element_blank(), axis.text.x = element_blank(), axis.text.y = element_text(size = 30))
ecoliPlot <- ggplot() + theme_classic() + scale_x_discrete(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0)) + geom_bar(data = ecoli, aes(x = SubstitutionFactor, y = Proportion_of_mutations), stat = "identity", fill = spectrumColours) + geom_rect(data = ecoliRect, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), fill = rectColours) + geom_text(data = ecoliRect, aes(label = Label, x = (xmin + (xmax - xmin)/2), y = (ymin + (ymax - ymin)/2)), colour = "white", size = 8) + ggtitle(expression(paste(italic("E. coli"), " lineage 11", sep = ""))) + theme(plot.title = element_text(size = 40, hjust = 0.5, colour = "orange"), axis.title = element_blank(), axis.text.x = element_blank(), axis.text.y = element_text(size = 30))
campyPlot <- ggplot() + theme_classic() + scale_x_discrete(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0)) + geom_bar(data = campy, aes(x = SubstitutionFactor, y = Proportion_of_mutations), stat = "identity", fill = spectrumColours) + geom_rect(data = campyRect, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), fill = rectColours) + geom_text(data = campyRect, aes(label = Label, x = (xmin + (xmax - xmin)/2), y = (ymin + (ymax - ymin)/2)), colour = "white", size = 8) + ggtitle(expression(paste(italic("C. jejuni"), " cluster 2", sep = ""))) + theme(plot.title = element_text(size = 40, hjust = 0.5, colour = "purple"), axis.title = element_blank(), axis.text.x = element_blank(), axis.text.y = element_text(size = 30))
GPSC1Plot <- ggplot() + theme_classic() + scale_x_discrete(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0)) + geom_bar(data = GPSC1, aes(x = SubstitutionFactor, y = Proportion_of_mutations), stat = "identity", fill = spectrumColours) + geom_rect(data = GPSC1Rect, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), fill = rectColours) + geom_text(data = GPSC1Rect, aes(label = Label, x = (xmin + (xmax - xmin)/2), y = (ymin + (ymax - ymin)/2)), colour = "white", size = 8) + ggtitle(expression(paste(italic("S. pneumoniae"), " GPSC1", sep = ""))) + theme(plot.title = element_text(size = 40, hjust = 0.5, colour = "dodgerblue"), axis.title = element_blank(), axis.text.x = element_blank(), axis.text.y = element_text(size = 30))
st22Plot <- ggplot() + theme_classic() + scale_x_discrete(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0)) + geom_bar(data = st22, aes(x = SubstitutionFactor, y = Proportion_of_mutations), stat = "identity", fill = spectrumColours) + geom_rect(data = st22Rect, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), fill = rectColours) + geom_text(data = st22Rect, aes(label = Label, x = (xmin + (xmax - xmin)/2), y = (ymin + (ymax - ymin)/2)), colour = "white", size = 8) + ggtitle(expression(paste(italic("S. aureus"), " ST22", sep = ""))) + theme(plot.title = element_text(size = 40, hjust = 0.5, colour = "firebrick"), axis.title = element_blank(), axis.text.x = element_blank(), axis.text.y = element_text(size = 30))

yLabel <- textGrob("Proportion of mutations", rot = 90, gp = gpar(fontsize = 40))

spectraCombined <- ggarrange(envAbsPlot, dccsPlot, ecoliPlot, campyPlot, GPSC1Plot, st22Plot, ncol = 3, nrow = 2)
spectraLabel <- ggarrange(yLabel, spectraCombined, ncol = 2, nrow = 1, widths = c(0.03, 0.97))

combinedPlot <- ggarrange(emptyLabel, sUArrows, emptyLabel, spectraLabel, ncol = 1, nrow = 4, heights = c(0.03, 0.6, 0.02, 0.4), labels = c(NA, "A", NA, "B"), font.label = list(size = 80), label.y = c(1, 1.06, 1, 1.05))

plot(combinedPlot)
dev.off()