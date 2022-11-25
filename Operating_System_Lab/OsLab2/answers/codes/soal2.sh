if [ ! -d $3 ] ; then
	mkdir $3
fi
cp -r ./$1/. $3
echo "All dir1 files copied to dir3"
cp -r ./$2/. $3
echo "All dir2 files copied to dir3"
ls $3 | less
