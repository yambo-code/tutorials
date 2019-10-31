#! /usr/bin/env python3
import sys

def parse_report(file_qp):
   #
   outl=[]
   outd={}
   fl=open(file_qp,"r") 
   #
   for line in fl: 
     #
     if "#  X G`s" in line: 
        outd["X_gvect"]=int(line.split()[-1])
     if "#  X bands" in line: 
        outd["X_bands"]=int(line.split()[-1])
     if "#  Sc/G bands" in line: 
        outd["G_bands"]=int(line.split()[-1])
     if "#" in line: continue
     if len(line) == 0: continue
     s=line.split()
     if len(s) != 5 : continue
    
     data=[float(s[0]),float(s[1]),float(s[2]),float(s[3])]
     outl.append(data) 
     outd["qp_list"]=outl

   fl.close()
   return outd

def formatter(val,maxfield=12):
    sval=str(val)
    return " "*(maxfield-len(sval))+sval

def print_qp_data(outd=None,val=None):
    if outd == None: 
       strout =  formatter("# Xo_gvect")
       strout += formatter("Xo_nbnd")
       strout += formatter("G_nbnd")
       strout += formatter("Egap [eV]")
       print(strout)
       return

    outl=outd["qp_list"]
    #
    # determine top of the valence
    if val==None:
      for dat in outl:
         if dat[2] == 0.0: 
            val=int(dat[1])
            break

    # valence top was not found
    if val == None: sys.exit(2)

    # compute the gap
    homo=-10000
    lumo=+10000
    for dat in outl:
       tmp=(dat[2]+dat[3])
       if (dat[1]==val+1):
         if (tmp<lumo): lumo=tmp
       if (dat[1]==val):
         if (tmp>homo): homo=tmp
    #
    egap=lumo-homo
    egap_str=str("%10.6f" % egap)
    #
    stdout  = formatter(outd["X_gvect"])
    stdout += formatter(outd["X_bands"])
    stdout += formatter(outd["G_bands"])
    stdout += formatter(egap_str)
    print(stdout)

def main(argv):
   #
   usage_str='''
  Usage parse_qp.py  [-h,--help] file_qp1 file_qp2...
'''
   #
   if len(argv) == 1:
     print(usage_str)
     sys.exit(1)
   if argv[1]=="-h" or argv[1]=="--help":
     print(usage_str)
     sys.exit(0)
   #
   print_qp_data()
   flist=argv
   for f in flist[1:]:
     #
     outd=parse_report(f)
     print_qp_data(outd)



if __name__ == "__main__":
   main(sys.argv)
