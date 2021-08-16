PaLOSi: a metric to detect removal of brain signals with artifact correction

This metric will be applied to the quality control for the large scale MEEG preprocessing in 6 steps:

1, Raw EEG data from online recording
2, Filtering
3, Bad channel detection: PREP, CleanRaw
4, Artefact correction: MARA, ICLABEL, EOG regression
5, Robust PCA
6, Interpolation

# Tutorials
1. run Automagic
2. run funs/addip.m
3. run test/tst_prj.m

