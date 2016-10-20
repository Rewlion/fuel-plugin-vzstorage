$PACKAGES       = "createrepo rpm rpm-build dpkg-devel dpkg-dev git"
$FPB_REPOSITORY = "https://github.com/Rewlion/fuel-plugins"
$FPB_FOLDER     = "fuel-plugins"

echo "installing packages\n"
yum install -y $PACKAGES

echo "installing fuel-plugin-builder"
git clone $FPB_REPOSITORY

if [[ ! -d $FPB_FOLDER ]]; then
  echo "there is a problem with clonning $(FPB_REPOSITORY)"
  die
fi

$ret = python $(FPB_FOLDER)/setup.py install 
if [ $ret -ne 0 ]; then
  echo "there is a problem with fpb installation"
  die
fi

echo "building plugin"
fpb --build .

echo "installing plugin"
fuel plugins --install ./virtuozzo*.noarch.rpm

echo "done."