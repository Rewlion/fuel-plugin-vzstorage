PACKAGES="createrepo rpm rpm-build dpkg-devel dpkg-dev git"

echo "installing packages\n"
yum install -y $PACKAGES

echo "installing fuel-plugin-builder"
easy_install pip
pip install fuel-plugin-builder

echo "building plugin"
fpb --build .

echo "installing plugin"
fuel plugins --install ./vzstorage*.noarch.rpm

echo "done."
