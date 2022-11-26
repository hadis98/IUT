import re
p = re.compile('0*10*10*10*10*')
print(p.findall("sdf0111010asdf 0011000101"))
