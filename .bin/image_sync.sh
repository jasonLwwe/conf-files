!/bin/bash
# Downdloads images from wwe.com
#   $1 Should be the directory containing the root directory 
#       where all images are stored.
#         eg. /u01/www/wwe3redesign/html (where the images are stored
#             in a subdirectory under this path).
#
#   $2 Absolute path to a file containing the list of images to download.
#       It should have one file per line and be a relative
#       path starting from the root image directory.
#         e.g. f/article/image/2015/12/image.jpg
#

base_dir=$2

while read image; do
  path=$( echo $image | rev | cut -d"/" -f2- | rev );
  location="$base_dir"/"$path"
  if [ ! -d $location ]; then
    echo Creating directory path: $location;
    sudo -u dynamic -g dynamic mkdir -p $location;
  fi
  cd $location;
  sudo -u dynamic -g dynamic wget "http://www.wwe.com/$image";
done < $1
