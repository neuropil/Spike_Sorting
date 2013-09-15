Finished:
1. Read/Write NTT files; Now we can inject feature matrix and cluster into NTT file which enable visualization of undefined feature space such as wavelet in spike-sort 3D
2. Feature extraction module: peak, valley, energy, PCA and peak-valley ratio etc.
3. Feature Distribution module: for best feature space election, realize feature space extraction larger than 8 dimensions and examine their distribution in each dimension. I found unimode distribution does not contribute to clustering by comparing the AMI score with and without that specific dimension.
4. Klustakwik clustering module in matlab: this is integrated using python script: 1. compile unix version of klustakwik; 2. connect klustakwik and matlab with python
5. Quality Matrix calculation,output and visualization including iso-distance, l-ration, number of spikes, ISI histogram.
6. Automatically pick clusters by l-ratio<1 and visualization in matlab, the way to use quality-matrix needs to be discussed further.

To do:
1. Autocorrelation; Crosscorrelation between clusters.
2. Spike-sorting reports on young and old animal.
3. Examine the stationality, animate the clustering evolving process?
4. Larminal spikes statistic analysis

Challenges and approaches: (* is unaddressed)
1. Some features don't match, such as PCA, in MClust and Spike-Sort3D. I re-write PCA feature extraction script, and found the MClust is wrong, and spike-sort 3d use 2nd PC as 1st PC.
2. Using Klustakwik in Matlab, write feature file to feed KlusterKwik, read clustering data back and use them to calculate quality matrix. KlustaKwik use file channel for IO, however, writing 3M file is so slow, so I wrote python script to connect matlab script and KlustaKwik to make them a platform.
3. Integrating Quality-Matrix and pick those clusters with good quality and display their ISI distribution and waveform(tetrode), ISI distribution use log10 space, but there is no log-histogram function built-in matlab, I worte one.
4. Get the real time information: Time steps of Timestamps and the sampling rate does not match. I verified that timestamps take 1 micron unit, but 2 actual sample points take 1/320000 sec inteval. Without real time information we can not analyze the autocorrelation.
4(*) Autocorrelation of clusters, only derive the formula with julia mathmatically.