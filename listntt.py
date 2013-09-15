import os
import sys
import os.path

startdir = os.getcwd();

for dirpath, dirnames, filenames in os.walk(startdir):
   for filename in filenames:
      if os.path.splitext(filename)[1] == '.ntt':
         filepath = os.path.join(dirpath, filename)
         print(filepath)