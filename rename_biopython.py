#!/usr/bin/python
import argparse
import os
from Bio import SeqIO
import re
__author__ = 'frederic.foucault'
 
parser = argparse.ArgumentParser(description='This script will open the fna files from the source and rename them based on the header comment in target.')
parser.add_argument('-s','--source', help='Source Directory',required=True)
parser.add_argument('-t','--target',help='Target directory', required=True)
args = parser.parse_args()
 
## show values ##
print ("source files in: %s" % args.source )
print ("Target files in: %s" % args.target )

#src = '/Users/frederic.foucault/ANI_Streptococcus'
#dst = '/Users/frederic.foucault/ANI/ANI_Streptococcus'
src = args.source
dst = args.target

listOfFiles = os.listdir(src)

for fha in listOfFiles:
    f= os.path.join(src,fha)

    with open(f, "r") as fi:
        record = SeqIO.parse((fi),"fasta").next()
        # return the last 2 of the first five | separated items, if none exist return the original string
        f5 = "|".join(record.description.split("|",5))
        print f5
        new = '_'.join(f5.rsplit("|",2))
        print new
        # remove/replace these  words
        new= new.replace(" ","_")
        new= new.replace("Streptococcus_","S._")
        new= new.replace("strain_","")
        new= new.replace("genome_assembly_","")
        new= new.replace("_complete_genome","")
        new= new.replace("_whole_genome","")
        new= new.replace("_whole","")
        new= new.replace("_complete","")
        new= new.replace(",","")
        new= new.replace("/","")
        new= new + ".fasta"
        print ("header is: '%s' converted to '%s'" % (record.description, new) )
        fi.close()
        ft=os.path.join(dst,new)
        print ("rename: '%s' to '%s'" % (f, ft) )
        os.rename(f, ft)
