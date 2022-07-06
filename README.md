Data and scripts used in "Mutational spectra analysis reveals bacterial niche and transmission routes"

# data
This directory contains data used in the manuscript

## clade_spectra directory

Contains variable sites alignments, phylogenetic trees, position conversion files, reference genomes and rescaled mutational spectra for the 84 clade datasets

Directories are named to match the clade name in all\_SBS\_spectra.csv (Table Sx in the manuscript)

Alignments and phylogenetic trees are named to match the directory name. Position conversion files are named conversion.txt. SBS spectra are named with the directory name followed by \_SBS\_spectrum.csv

Where clades were labelled to separate branches into groups (e.g. to remove hypermutator branches), the labelled trees are included with suffix \_labelled.nwk

SBS spectra were calculated separately for three _B. cenocepacia_ epidemic clones and combined to form a single SBS spectrum for further analysis. Alignments, phylogenetic trees and labelled trees are provided for each epidemic clone. The combined SBS spectrum is in the B\_cenocepacia\_ECs directory. The same conversion.txt file was used for each epidemic clone

SBS spectra were calculated for _M. abscessus_ [here](https://www.nature.com/articles/s41564-021-00963-3) by combining internal branch mutations from DCC and non-DCC clades. SBS spectra are included in this directory for these datasets, the input data used in their calculation is [here](https://zenodo.org/record/5116229#.YsVbHuzMIaE)

The _M. canettii_ dataset additionally includes a small number of _M. tuberculosis_ sequences. The _M. canettii_ SBS spectrum was calculated using the labelled tree in which label MCAN corresponds to the _M. canettii_ branches

The _M. kansasii_ MKMC and non-MKMC SBS spectra were calculated from the same alignment and phylogenetic tree using the labelled tree in which MKMC and non-MKMC are labelled separately

DBS spectra are included in the _C. acnes_ and _S. epidermidis_ directories with the suffix \_DBS\_spectrum.csv. The _S. epidermidis_ DBS spectra in manuscript Figure 4 was formed by combining the DBS spectra of the 3 phylogenetic groups
