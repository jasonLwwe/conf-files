def prep_line(line):
  line = line.strip('\n')
  splits = [-1]
  if '\"' in line:
    in_string = False
    i = 0
    for ch in line:
      if ch == '\"':
        in_string = not in_string
      elif ch == ',' and not in_string:
        splits.append(i)
      else:
        pass
      i += 1
    new_line = []
    for i in xrange(len(splits)):
      if i < len(splits) - 1:
        new_line.append(line[splits[i]+1:splits[i+1]])
      else:
        new_line.append( line[splits[i]+1:] )
    
    line = new_line
  else:
    line = line.split(',')
    
  return line
    
if __name__ == "__main__":
  import sys
  filename = sys.argv[1]
  print(filename)
  errors = False
  with open(filename, 'r') as file:
    for line in file:
      line = prep_line(line)
      if len(line) != 5:
        print "Error: " + str(line)
        errors = True
  if not errors:
    print("There were no errors!!")
        

