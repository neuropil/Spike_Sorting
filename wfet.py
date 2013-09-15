import scipy.io as sio
import sys
from pylab import *

def cellwrite(filename, cellarray, writeway):
    fid = file(filename, writeway)
    lines = ['\t'.join([str(int(cell)) for cell in row]) + '\n' for row in cellarray]
    fid.writelines(lines)
    fid.close()

directory = sys.argv[1]
matname = sys.argv[2]
data = sio.loadmat(directory+matname+'.mat')
nFet = data['nFet']
fet = data['fet']
filename = directory+matname+'.fet.1'
cellwrite(filename, nFet, 'w')
cellwrite(filename, fet, 'a')