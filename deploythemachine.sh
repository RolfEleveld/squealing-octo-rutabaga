#!/bin/bash

# expect 4 paramerters: $1 is the link to the storage share $2 is the user name $3 is the pass key for the cifs user and $4 the relative path to process
# the script expects $1 to have research (with fna files) and compute to store the calculated results.

#Deploy Python (should have python deployed):
sudo apt-get update -y

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
# available?
sudo pip install json
sudo pip install logging
sudo pip install nose
sudo pip install ReportLab

#biopython>=1.65 
sudo pip install Biopython

#matplotlib>=1.4.3 
#numpy>=1.10.0.post2 
#pandas>=0.17.0
#rpy2>=2.7.0 
sudo apt-get install python-rpy2 -y
#scipy>=0.16.0 
sudo apt-get install python-numpy python-scipy python-matplotlib* ipython ipython-notebook python-pandas python-sympy python-nose -y -q
sudo apt-get install r-base -y
sudo pip install ipython-genutils

##blast 
wget ftp://ftp.ncbi.nih.gov/blast/executables/LATEST/ncbi-blast-2.2.31+-x64-linux.tar.gz
tar xzf ncbi-blast-2.2.31+-x64-linux.tar.gz
# take the pwd and /bin and make that part of path
export PATH=$PATH:$HOME/ncbi-blast-2.2.31+/bin
export BLASTDB=$BLASTDB:$HOME/ncbi-blast-2.2.31+/db
# From ftp://ftp.ncbi.nih.gov/blast/documents/blast.html

# MUMmer
wget -O MUMmer3.23.tar.gz http://downloads.sourceforge.net/project/mummer/mummer/3.23/MUMmer3.23.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fmummer%2Ffiles%2Fmummer%2F3.23%2F&ts=1448474975&use_mirror=heanet
tar xzf MUMmer3.23.tar.gz
cd MUMmer3.23
make
# take the pwd and /bin and make that part of path
export PATH=$PATH:$HOME/MUMmer3.23
cd ..

#PyANI
#https://github.com/widdowquinn/pyani
# below pops a window to deploy web service ( do we need this package?)
sudo apt-get install r-base* -y -q
sudo apt-get install r-base-dev* -y -q
sudo yes | pip install pyani

# azure management to collect data
sudo pip install azure-mgmt

# will enable when done, either bloxfer or cifs to Azure.
##transferring files from the storage and processing them
#sudo pip install blobxfer
##actual transfer, use saskey!
#blobxfer.py mystorageacct container0 mylocaldir --remoteresource 

#connect the Azure storage for fna files
sudo apt-get install cifs-utils -y
sudo apt-get install apt-file -y
sudo mkdir -p /mnt/source
#$1 is the SAMBA link to the share
#$2 is the user name
#$3 is the key to access the share
sudo mount -t cifs $1 /mnt/source -o vers=3.0,username=$2,password=$3,dir_mode=0777,file_mode=0777

#create an output folder in /mnt/compute
time_stamp=$(date +%Y_%m_%d)
compute_path="/mnt/compute/${time_stamp}"
temp_path="/mnt/tmp/${time_stamp}"
output_path="/mnt/result/${time_stamp}"
result_path="/mnt/source/compute/${time_stamp}"

sudo mkdir -p "${temp_path}"
sudo mkdir -p "${compute_path}"

#$4 contains the relative path to the FNA files to be processed e.g. "/research/*[7-9][7-9]*Velvet*" or "/research/*ASM*"
sudo cp /mnt/source$4 ${temp_path} -R

wget "https://raw.githubusercontent.com/RolfEleveld/squealing-octo-rutabaga/master/rename_biopython.py"
sudo python rename_biopython.py -s "${temp_path}" -t "${compute_path}"

# deployed path of biopython
sudo  /usr/local/bin/average_nucleotide_identity.py -i "${compute_path}" -o "${output_path}" -m ANIb -g
# if run with & one can see utilization with: top -bn2 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'

sudo ls -l ${temp_path} > ${output_path}/filteredfilelist.txt
sudo ls -l ${output_path} > ${output_path}/processedfilelist.txt
sudo mkdir "${result_path}"
sudo cp "${output_path}" "${result_path}" -R
