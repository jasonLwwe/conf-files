import sys
from csv_lineprep import prep_line

file1name = sys.argv[1]
file2name = sys.argv[2]
outfilename = sys.argv[3]

strings = {}
en=0
de=1
es=2
with open(file1name, 'r') as ifile1:
  linenum = 0
  for line in ifile1:
    line = prep_line(line)
    if linenum == 0:
      en1 = line.index('en')
      de1 = line.index('de')
      es1 = line.index('es')
    else:
      english = line[en1]
      german = line[de1]
      spanish = line[es1]
      line[en] = english
      line[de] = german
      line[es] = spanish
      strings[line[en1]] = line
    linenum += 1
    
with open(file2name, 'r') as ifile2:
  linenum = 0
  for line in ifile2:
    line = prep_line(line)
    if linenum == 0:
      en2 = line.index('en')
      de2 = line.index('de')
      es2 = line.index('es')
    else:
      if line[en2] not in strings:
        strings[line[en2]] = line
      else:
        vals = strings[line[en2]]
        if vals[de] == vals[en]:
          vals[de] = line[de2]
        if vals[es] == vals[en]:
          vals[es] = line[es2]
    linenum += 1
        
with open(outfilename,'w') as ofile:
  ofile.write('en,de,es\n')
  keys = strings.keys()
  keys.sort()
  for k in keys:
    line = strings[k]
    line = line[en] + ',' + line[de] + ',' + line[es] + '\n'
    ofile.write(line)
    