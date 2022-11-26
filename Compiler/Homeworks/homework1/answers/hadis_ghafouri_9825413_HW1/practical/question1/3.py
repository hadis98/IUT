import re
# string = "101 this is a test 10000111"
regex = r'\b(0|1(10)*(0|11)(01*01|01*00(10)*(0|11))*1)*\b'
# match = re.findall(regex,string)
match = re.search(regex,"10100")
print(match)
match = re.search(regex,"10000111")
print(match)
match = re.search(regex,"10")
print(match)