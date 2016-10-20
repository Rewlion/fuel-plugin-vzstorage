PACKAGES="createrepo rpm rpm-build dpkg-devel dpkg-dev git"
FPB_REPOSITORY="https://github.com/Rewlion/fuel-plugins"
FPB_FOLDER="fuel-plugins"

echo "installing packages\n"
yum install -y $PACKAGES

echo "installing fuel-plugin-builder"
git clone $FPB_REPOSITORY

if [[ ! -d $FPB_FOLDER ]]; then
  echo "there is a problem with clonning $FPB_REPOSITORY"
  echo $FPB_REPOSITORY
  exit -1
fi

cd $FPB_FOLDER
python setup.py install
if [[ $? -ne 0 ]]; then
  echo "there is a problem with fpb installation"
  exit -1
fi

cd ../
echo "building plugin"
fpb --build .

echo "installing plugin"
fuel plugins --install ./vzstorage*.noarch.rpm

echo "done."
