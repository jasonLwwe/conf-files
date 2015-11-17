import sys
from csv_lineprep import prep_line

filename = sys.argv[1]
outfilename = sys.argv[2]
print(filename)
print(outfilename)

ofile = open(outfilename, 'w')
with open(filename) as ifile:
  linenum = 0
  for line in ifile:
    print(line)
    line = prep_line(line)
    print(line)
    if linenum == 0:
      en = line.index('en')
      de = line.index('de')
      es = line.index('es')
    
    line = line[en] + ',' + line[de] + ',' + line[es] + '\n'
    print(line)
    ofile.write(line)
    linenum += 1
    
ofile.close()