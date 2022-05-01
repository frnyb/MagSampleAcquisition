#!/usr/bin/python3

import sys

filename = sys.argv[1]
filedata = None

# Read in the file
with open(filename, 'r') as file :
  filedata = file.read()

# Replace the target string
filedata = filedata.replace('\t\t', '\t')

# Write the file out again
with open(filename, 'w') as file:
  file.write(filedata)
