from subprocess import call
import sys
import os
ntt = sys.argv[1]
call(["./etos3_for_ntt.sh", ntt])
os.remove(ntt+'.det')
os.remove(ntt+'.cla.etos')
os.remove(ntt+'.cla.kmeans')
os.remove(ntt+'.ext')
os.remove(ntt+'.ext.orig')
os.remove(ntt+'.model')
os.remove(ntt+'.model.kmeans')
os.remove(ntt+'.log')