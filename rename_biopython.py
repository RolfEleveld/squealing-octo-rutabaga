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
        found = record.description.split("|")
        new='_'.join(found[4:5])
        print found
        ft=os.path.join(dst,new)
        print f
        print ft
        # remove/replace these  words
        new= new.replace("Streptococcus","S.")
        new= new.replace("strain_","")
        new= new.replace("genome_assembly_","")
        new= new.replace(",_complete","")
        new= new.replace("_complete_genome","")
        new= new.replace(",_whole_genome","")
        new= new.replace(",_whole","")
        new= new.replace(",","")
        new= new.replace(" ","_")
        new= new.replace("/","")
        new= new + ".fasta"
        print new
        fi.close()
        os.rename(f, ft)
