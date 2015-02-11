#/bin/sh

err="-copy.sh"

source=/var/lib/jenkins/jobs/PHPUnitProjectTestSuite/workspace/${1}/${2}
if [ ! -d "$source" ]; then
	echo $err: source: $source no such file or directory 
	exit 1
fi

dest=/opt/vhosts/wwecom7/tests/images/${1}/${2}
cp -pr ${source}/region-* $dest
rm ${dest}/*-{src,diff}.png 2>/dev/null
ls -1 $dest | grep ^region | cut -d'-' -f2- | xargs -I{} mv ${dest}/{region-,}{}
