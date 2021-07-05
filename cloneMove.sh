args=("$@")
git -C ~/tempRepo clone ${args[0]} 
#git remote set-url origin 
URL=${args[0]}
URL_NOPRO=${URL:7}
URL_REL=${URL_NOPRO##*/}
TEMP_NOW=${URL_REL%%\?*}
FOLDER_NAME=${URL_REL%%\.*}
echo $FOLDER_NAME
cd ~/tempRepo/
rm -r -f $FOLDER_NAME/.git
cd ~/tempRepo/
zip -r -q $FOLDER_NAME'.zip' $FOLDER_NAME