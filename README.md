Data and scripts used in "Mutational spectra are associated with bacterial niche"

DOI: [![DOI](https://zenodo.org/badge/510709436.svg)](https://zenodo.org/badge/latestdoi/510709436)

# data
This directory contains data used in the manuscript

## clade_spectra directory

Contains variable sites alignments, phylogenetic trees, position conversion files, reference genomes and rescaled mutational spectra for the 84 clade datasets

Directories are named to match the clade name in all\_SBS\_spectra.csv

Alignments and phylogenetic trees are named to match the directory name. Position conversion files are named conversion.txt. SBS spectra are named with the directory name followed by \_SBS\_spectrum.csv

Where clades were labelled to separate branches into groups (e.g. to remove hypermutator branches), the labelled trees are included with suffix \_labelled.nwk

SBS spectra were calculated separately for three _B. cenocepacia_ epidemic clones and combined to form a single SBS spectrum for further analysis. Alignments, phylogenetic trees and labelled trees are provided for each epidemic clone. The combined SBS spectrum is in the B\_cenocepacia\_ECs directory. The same conversion.txt file was used for each epidemic clone

SBS spectra were calculated for _M. abscessus_ [here](https://www.nature.com/articles/s41564-021-00963-3) by combining internal branch mutations from DCC and non-DCC clades. SBS spectra are included in this directory for these datasets, the input data used in their calculation is [here](https://zenodo.org/record/5116229#.YsVbHuzMIaE)

The _M. canettii_ dataset additionally includes a small number of _M. tuberculosis_ sequences. The _M. canettii_ SBS spectrum was calculated using the labelled tree in which label MCAN corresponds to the _M. canettii_ branches

The _M. kansasii_ MKMC and non-MKMC SBS spectra were calculated from the same alignment and phylogenetic tree using the labelled tree in which MKMC and non-MKMC are labelled separately

DBS spectra are included in the _C. acnes_ and _S. epidermidis_ directories with the suffix \_DBS\_spectrum.csv. The _S. epidermidis_ DBS spectra in manuscript Figure 4 was formed by combining the DBS spectra of the 3 phylogenetic groups

## dna_repair_gene_signatures directory

Contains SBS signatures for DNA repair genes, identified through hypermutator lineages. Files are named with the species from which the signature was extracted followed by the DNA repair gene

## P_aeruginosa_ST_spectra directory

Contains variable sites alignments, phylogenetic trees, position conversion files, reference genomes and labelled phylogenetic trees used to calculate DNA repair gene hypermutator SBS spectra from _P. aeruginosa_ lineages

In labelled phylogenetic trees, branches with no evidence of hypermutation are labelled nH while potential hypermutator branches are labelled with either the tip name (for tip branches) or the internal node name (for branches downstream of internal hypermutator lineages)

SBS spectra for individual hypermutator branches are in the respective ST directory named with the ST followed by the branch name

hypermutator_branches.csv contains the 50 hypermutator lineages, their STs, branch names and file names. These files are within the respective ST directory, with the exception of the _M. abscessus_ and _M. leprae_ hypermutator lineages which are in the mycobacteria_hypermutator_lineages directory within the data directory

## mycobacteria_hypermutator_lineages directory

Contains the SBS spectra for hypermutator lineages in _M. abscessus_ and _M. leprae_. The gene corresponding to each hypermutator lineage is in hypermutator_branches.csv within the P_aeruginosa_ST_spectra directory

## M_kansasii_gene_burden_transmission directory

Contains the data used to run transmission analyses and gene burden tests on _M. kansasii_. The _M. kansasii_ alignment and labelled phylogenetic tree are kansasii.filtered_polymorphic_sites.fasta and MKMC_rooted_labels.nex, respectively.

SNP distances, geographical locations and sampling dates are in all_patient_linkages.csv.

The results from the gene burden test are in poisson_test.txt and variants_in_burden_hits.txt.

# figures_data

Contains raw data used to produce each figure and supplementary figure. Each directory contains a README with more information
