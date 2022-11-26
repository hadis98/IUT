import os

# with os.scandir() as items:
#     for item in items:
#         print(item.name)

with os.scandir() as items:
    totalSize=0
    for item in items:
        if item.is_file():
            size = item.stat().st_size
            print(f'file:{item.name}\t {size}b')
            totalSize +=size
        elif item.is_dir():
            print(f'> {item.name}')
    print(f'total size: {totalSize}')

os.chdir('./dir1') #change dir
print(f'pwd: {os.getcwd()}')
path = os.getcwd()
if path.endswith('Server'):
    print('/')
else:
    pos = path.index('Server')
    print(path[pos+6:len(path)])

# print('listing all sub directories: ')
# with os.scandir() as items:
#     for item in items:
#         print(item.name)


#os.walk()

# Walking a directory tree and printing the names of the directories and files
for dirpath, dirnames, files in os.walk('.'):
    print(f'Found directory: {dirpath}')
    for file_name in files:
        print(file_name)
    for dirName in dirnames:
        print(dirName)