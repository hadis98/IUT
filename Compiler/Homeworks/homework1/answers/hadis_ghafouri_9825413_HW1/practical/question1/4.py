import re
# haRegex = re.compile(r'\b[^11](11){,2}[^11]\b')
haRegex = re.compile(r'(([^1])*(11){,2}([^1])*)|(([^1])*(11){,1}([^1])*(11){,1})|((11){,1}([^1])*(11){,1})|((11){,2}([^1])*)')
mo1 = haRegex.match('0011')
print(mo1)
mo1 = haRegex.match('01011')
print(mo1)
mo1 = haRegex.match('00111111')
print(mo1)
mo1 = haRegex.match('110011')
print(mo1)

