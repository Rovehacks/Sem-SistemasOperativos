!/bin/bash
echo Hola Mundo > mytext
cat mytext
mkdir backup
mv mytext backup/mytext
ls backup
rm backup/mytext
rm -r backup
