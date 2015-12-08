#!/bin/bash

#Deploy Python (should have python deployed):
sudo apt-get update

#dependencies
sudo apt-get install python-dev -y
#libpng
sudo apt-get install zlib1g-dev -y
wget http://prdownloads.sourceforge.net/libpng/libpng-1.5.4.tar.gz?download
mv libpng-1.5.4.tar.gz?download libpng-1.5.4.tar.gz
tar xzf libpng-1.5.4.tar.gz
cd libpng-1.5.4
./configure --prefix=/usr/local/libpng
make
sudo make install
cd ..
#libjpeg
wget http://www.ijg.org/files/jpegsrc.v8c.tar.gz
tar xzf jpegsrc.v8c.tar.gz
cd jpeg-8c
./configure --prefix=/usr/local/libjpeg
make
sudo make install
cd ..

sudo apt-get install freetype* -y
sudo apt-get install pyparsing* -y
sudo apt-get install tornado* -y
sudo apt-get install cycler* -y


sudo apt-get install python-pip -y
sudo pip install json
sudo pip install logging
sudo pip install nose
sudo pip install ReportLab

#biopython>=1.65 
sudo pip install Biopython
#matplotlib>=1.4.3 
sudo apt-get install matplotlib* -y
#numpy>=1.10.0.post2 
sudo pip install NumPy
#pandas>=0.17.0
sudo pip install pandas
sudo pip install SciPy
sudo pip install ipython-genutils

sudo apt-get install r-base -y

# using blast nci image
##blast 
#wget ftp://ftp.ncbi.nih.gov/blast/executables/LATEST/ncbi-blast-2.2.31+-x64-linux.tar.gz
#tar xzf ncbi-blast-2.2.31+-x64-linux.tar.gz
#cd ncbi-blast-2.2.31+
##stuck here ... using ready made image instead.
#make
#sudo make install
#cd ..

## todo vvv reading ftp://ftp.ncbi.nih.gov/blast/documents/blast.html as blast is downloaded, not executing yet.
## todo MUMmer as well.
#wget http://downloads.sourceforge.net/project/mummer/mummer/3.23/MUMmer3.23.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fmummer%2Ffiles%2Fmummer%2F3.23%2F&ts=1448474975&use_mirror=heanet

#rpy2>=2.7.0 
sudo pip install Rpy2

#scipy>=0.16.0 
pip install git+https://github.com/scipy/scipy.git

#PyANI
sudo pip install git+https://github.com/widdowquinn/pyani/releases

#test
./average_nucleotide_identity.py -i tests/test_ani_data/ -o tests/test_ANIb_output -m ANIb -g

# azure management to collect data
sudo pip install azure-mgmt

# will enable when done, either bloxfer or cifs to Azure.
##transferring files from the storage and processing them
#sudo pip install blobxfer
##actual transfer, use saskey!
#blobxfer.py mystorageacct container0 mylocaldir --remoteresource 

#connect the Azure storage for fna files
sudo apt-get install cifs-utils
#sudo mount -t cifs //myaccountname.file.core.windows.net/mysharename ./mymountpoint -o vers=3.0,username=myaccountname,password=StorageAccountKeyEndingIn==,dir_mode=0777,file_mode=0777
