#! /usr/bin/env python3
import sys

def parse_report(file_report,fmt_seconds):
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
     if parse_timing and "Dipoles :" in line:
       outd["dip_time"] = line.split(":")[1].split("CPU")[0]
     #if parse_timing and "Dipoles (REDUX)" in line:
     #  outd["dip_REDUX_time"] = line.split(":")[1].split("CPU")[0]
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
   if fmt_seconds: 
      outd_sec=convert_to_sec(outd)
      outd=outd_sec
      #if "dip_time_sec" in outd  and "dip_REDUX_time_sec" in outd : outd["dip_tot_time_sec"]=outd["dip_time_sec"]+outd["dip_REDUX_time_sec"]
      if "Xo_time_sec"  in outd  and "Xo_REDUX_time_sec"  in outd : outd["Xo_tot_time_sec"]=outd["Xo_time_sec"]+outd["Xo_REDUX_time_sec"]
      if "X_time_sec"   in outd  and "X_REDUX_time_sec"   in outd : outd["X_tot_time_sec"]=outd["X_time_sec"]+outd["X_REDUX_time_sec"]
      if "HF_time_sec"  in outd  and "HF_REDUX_time_sec"  in outd : outd["HF_tot_time_sec"]=outd["HF_time_sec"]+outd["HF_REDUX_time_sec"]
      if "GW_time_sec"  in outd  and "GW_REDUX_time_sec"  in outd : outd["GW_tot_time_sec"]=outd["GW_time_sec"]+outd["GW_REDUX_time_sec"]
   #    
   #print(outd)
   #print()
   return outd

def convert_to_sec(outd):
   outd_new={}
   for key,val in outd.items():
      if isinstance(val,str) and "_time" in key :
         key_new=key+"_sec"
         val_new=0
         if "d" in val:
            val_new+= 86400*int(val.split("d")[0])
            val=val.split("d")[1]
         if "h" in val:
            val_new+= 3600*int(val.split("h")[0])
            val=val.split("h")[1]
         if "m" in val:
            val_new+= 60*int(val.split('m')[0])
            val=val.split("m")[1]
         if "s" in val:
            val_new+=int(float(val.split("s")[0]))
         outd_new[key_new]=val_new
      else:
         outd_new[key]=val
      #
   return outd_new

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

def print_perfGW_data(outd=None,fmt_seconds=False,header=False):
    #
    if outd==None: return
    if header :
       strout ="# ncores"  
       if "mpi_tasks"     in outd : strout+=formatter("MPI")  
       if "openmp_threads"in outd : strout+=formatter("threads")  
       #
       if not fmt_seconds:
          if "dip_time"      in outd : strout+=formatter("dip")  
          if "dip_REDUX_time"in outd : strout+=formatter("dip_REDUX")  
          if "Xo_time"       in outd : strout+=formatter("Xo")  
          if "Xo_REDUX_time" in outd : strout+=formatter("Xo_REDUX")  
          if "X_time"        in outd : strout+=formatter("X")  
          if "X_REDUX_time"  in outd : strout+=formatter("X_REDUX")  
          if "io_X_time"     in outd : strout+=formatter("io_X")  
          if "io_WF_time"    in outd : strout+=formatter("io_WF")  
          if "HF_time"       in outd : strout+=formatter("Sgm_x")  
          if "HF_REDUX_time" in outd : strout+=formatter("(REDUX)")  
          if "GW_time"       in outd : strout+=formatter("Sgm_c")  
          if "GW_REDUX_time" in outd : strout+=formatter("(REDUX)")  
          if "wall_time"     in outd : strout+=formatter("WALL_TIME")  
       else:
          if "dip_time_sec"  in outd : strout+=formatter("dip_TOT")  
          if "Xo_time_sec"   in outd : strout+=formatter("Xo_TOT")  
          if "X_time_sec"    in outd : strout+=formatter("X_TOT")  
          if "io_X_time_sec" in outd : strout+=formatter("io_X")  
          if "io_WF_time_sec"in outd : strout+=formatter("io_WF")  
          if "HF_time_sec"   in outd : strout+=formatter("Sgm_x_TOT")  
          if "GW_time_sec"   in outd : strout+=formatter("Sgm_c_TOT")  
          if "wall_time_sec" in outd : strout+=formatter("WALL_TIME")  
       #
       print(strout)
       return

    strout = formatter(outd["ncores"],len("# ncores"))
    if "mpi_tasks"     in outd : strout+= formatter(outd["mpi_tasks"])
    if "openmp_threads"in outd : strout+= formatter(outd["openmp_threads"])
    if not outd["completed"]:
       print(strout)
       return

    if not fmt_seconds: 
       if "dip_time"        in outd : strout+= formatter(outd["dip_time"])
       if "dip_REDUX_time"  in outd : strout+= formatter(outd["dip_REDUX_time"])
       if "Xo_time"       in outd : strout+= formatter(outd["Xo_time"])
       if "Xo_REDUX_time" in outd : strout+= formatter(outd["Xo_REDUX_time"])
       if "X_time"        in outd : strout+= formatter(outd["X_time"])
       if "X_REDUX_time"  in outd : strout+= formatter(outd["X_REDUX_time"])
       if "io_X_time"     in outd : strout+= formatter(outd["io_X_time"])
       if "io_WF_time"    in outd : strout+= formatter(outd["io_WF_time"])
       if "HF_time"       in outd : strout+= formatter(outd["HF_time"])
       if "HF_REDUX_time" in outd : strout+= formatter(outd["HF_REDUX_time"])
       if "GW_time"       in outd : strout+= formatter(outd["GW_time"])
       if "GW_REDUX_time" in outd : strout+= formatter(outd["GW_REDUX_time"])
       if "wall_time"     in outd : strout+= formatter(outd["wall_time"])
    else:
       #if "dip_tot_time_sec"in outd : strout+= formatter(str(outd["dip_tot_time_sec"]))
       if "dip_time_sec"    in outd : strout+= formatter(str(outd["dip_time_sec"]))
       if "Xo_tot_time_sec" in outd : strout+= formatter(str(outd["Xo_tot_time_sec"]))
       if "X_tot_time_sec"  in outd : strout+= formatter(str(outd["X_tot_time_sec"]))
       if "io_X_time_sec"   in outd : strout+= formatter(str(outd["io_X_time_sec"]))
       if "io_WF_time_sec"  in outd : strout+= formatter(str(outd["io_WF_time_sec"]))
       if "HF_tot_time_sec" in outd : strout+= formatter(str(outd["HF_tot_time_sec"]))
       if "GW_tot_time_sec" in outd : strout+= formatter(str(outd["GW_tot_time_sec"]))
       if "wall_time_sec"   in outd : strout+= formatter(str(outd["wall_time_sec"]))

    print(strout)
    return


def main(argv):
   #
   usage_str='''
  Usage parse_Yambo.py  [-h,--help] [-s, --sec] [-a, --all]  file1 file2...
'''
   #
   verbose=False
   fmt_seconds=False
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
   if argv[1]=="-s" or argv[1]=="--sec":
     argv.pop(1)
     fmt_seconds=True
   #
   flist=argv
   first=True
   for f in flist[1:]:
     #
     outd=parse_report(f,fmt_seconds)
     #
     if not verbose and first :  print_perfGW_data(outd,fmt_seconds,header=True)
     #
     first=False
     #
     if verbose:
        print_parsed_data(outd,datafile=f)
     else:
        print_perfGW_data(outd,fmt_seconds)



if __name__ == "__main__":
   main(sys.argv)
