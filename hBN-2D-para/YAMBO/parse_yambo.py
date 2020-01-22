#! /usr/bin/env python3
import sys

def parse_report(file_report):
   #
   parse_timing=False
   outd={}
   outd["parallel_structure"]=""
   outd["mpi_tasks"]=1
   outd["openmp_tasks"]=1
   outd["ncores"]=1
   outd["completed"]=False
   #
   fl=open(file_report,"r") 
   #print ("parsing "+file_report)
   #
   for line in fl: 
     #
     # versioning
     #
     if "Version" in line:
       s=line.split()
       outd["version"]=s[s.index("Version")+1]
     if "Revision" in line:
       s=line.split()
       outd["revision"]=s[s.index("Revision")+1]
     if "Hash" in line:
       s=line.split()
       outd["hash"]=s[s.index("Hash")+1]
     #
     # parallel data
     #
     if "CPU-Threads" in line:
       outd["parallel_structure"]=outd["parallel_structure"]+" " \
                                  +line.split(":")[1].replace("\n"," ")
     if "MPI CPU" in line:
       outd["mpi_tasks"]=int(line.split(":")[-1])
     if "THREADS   " in line:
       outd["openmp_threads"]=int(line.split(":")[-1])
     if "THREADS TOT(max)" in line:
       outd["ncores"]=int(line.split(":")[-1])
     #
     # timing
     #
     if "Timing Overview" in line: parse_timing=True
     if "| The users of YAMBO have little formal obligations " in line: 
         parse_timing=False
         outd["completed"]=True
     #
     if parse_timing and "Timing  " in line:
       outd["wall_time"] = line.split(":")[1].split("/")[0].replace("-","")
     if parse_timing and "io_WF" in line:
       outd["io_WF_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "io_HF" in line:
       outd["io_HF_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "io_DIPOLES" in line:
       outd["io_DIPOLES_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "io_X" in line:
       outd["io_X_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "RIM" in line:
       outd["RIM_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "Coulomb Cutoff" in line:
       outd["cutoff_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "Dipoles" in line:
       outd["dipoles_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "Xo (procedure)" in line:
       outd["Xo_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "Xo (REDUX)" in line:
       outd["Xo_REDUX_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "X (procedure)" in line:
       outd["X_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "X (REDUX)" in line:
       outd["X_REDUX_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "LINEAR ALGEBRA" in line:
       outd["LinAlG_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and " HF " in line:
       outd["HF_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "HF(REDUX)" in line:
       outd["HF_REDUX_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "GW(ppa)" in line:
       outd["GW_time"] = line.split(":")[1].split("CPU")[0]
     if parse_timing and "GW(REDUX)" in line:
       outd["GW_REDUX_time"] = line.split(":")[1].split("CPU")[0]

   fl.close()
   clean_parsed_data(outd)
   #
   return outd

def clean_parsed_data(outd):
   #
   for key in outd:
     val=outd[key] 
     if isinstance(val,str):
        val=val.replace(" ","")
        outd[key]=val

def print_parsed_data(outd,datafile=None):
    print()
    if datafile != None:
       print(" %20s : %s " % ("file", str(datafile)))
    #
    for key in outd:
       print(" %20s : %s " % (key, str(outd[key])) )
    print()

def formatter(val,maxfield=12):
    sval=str(val)
    return " "*(maxfield-len(sval))+sval

def print_perfGW_data(outd=None):
    #
    if outd==None:
       strout ="# ncores"  
       strout+=formatter("MPI")  
       strout+=formatter("threads")  
       strout+=formatter("io_WF")  
       strout+=formatter("Dipoles")  
       strout+=formatter("Xo")  
       strout+=formatter("Xo(REDUX)")  
       strout+=formatter("X")  
       strout+=formatter("Sgm_x")  
       strout+=formatter("(REDUX)")  
       strout+=formatter("Sgm_c")  
       strout+=formatter("(REDUX)")  
       strout+=formatter("WALL_TIME")  
       print(strout)
       return

    strout = formatter(outd["ncores"],len("# ncores"))
    strout+= formatter(outd["mpi_tasks"])
    strout+= formatter(outd["openmp_threads"])
    if not outd["completed"]:
       print(strout)
       return
    strout+= formatter(outd["io_WF_time"])
    strout+= formatter(outd["dipoles_time"])
    strout+= formatter(outd["Xo_time"])
    strout+= formatter(outd["Xo_REDUX_time"])
    strout+= formatter(outd["X_time"])
    strout+= formatter(outd["HF_time"])
    strout+= formatter(outd["HF_REDUX_time"])
    strout+= formatter(outd["GW_time"])
    strout+= formatter(outd["GW_REDUX_time"])
    strout+= formatter(outd["wall_time"])
    print(strout)
    return


def main(argv):
   #
   usage_str='''
  Usage parse_Yambo.py  [-h,--help] [-a, --all]  file1 file2...
'''
   #
   verbose=False
   #
   if len(argv) == 1:
     print(usage_str)
     sys.exit(1)
   if argv[1]=="-h" or argv[1]=="--help":
     print(usage_str)
     sys.exit(0)
   if argv[1]=="-a" or argv[1]=="--all":
     argv.pop(1)
     verbose=True
   #
   if not verbose:  print_perfGW_data()
   #
   flist=argv
   for f in flist[1:]:
     #
     outd=parse_report(f)
     #
     if verbose:
        print_parsed_data(outd,datafile=f)
     else:
        print_perfGW_data(outd)



if __name__ == "__main__":
   main(sys.argv)
