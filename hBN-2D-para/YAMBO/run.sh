#!/bin/bash
#SBATCH -N 1
#SBATCH -t 06:00:00 
#SBATCH -J test
#SBATCH --reservation=cecam_course
#SBATCH --tasks-per-node=16

nodes=1
nthreads=1
ncpu=`echo $nodes $nthreads 16 | awk '{print $1*$3/$2}'`

module purge
module load intel/16.0.3
module load intelmpi/5.1.3
bindir=/home/cecam.school/bin/

export OMP_NUM_THREADS=$nthreads

label=MPI${ncpu}_OMP${nthreads}
jdir=run_${label}
cdir=run_${label}.out

filein0=yambo_gw.in
filein=yambo_gw_${label}.in

cp -f $filein0 $filein
cat >> $filein << EOF
X_all_q_CPU= "1 1 $ncpu 1"  # [PARALLEL] CPUs for each role
X_all_q_ROLEs= "q k c v"    # [PARALLEL] CPUs roles (q,k,c,v)
X_all_q_nCPU_LinAlg_INV= $ncpu   # [PARALLEL] CPUs for Linear Algebra
X_Threads=  0               # [OPENMP/X] Number of threads for response functions
DIP_Threads=  0             # [OPENMP/X] Number of threads for dipoles
SE_CPU= " 1 1 $ncpu"        # [PARALLEL] CPUs for each role
SE_ROLEs= "q qp b"          # [PARALLEL] CPUs roles (q,qp,b)
SE_Threads=  0    

EOF

echo "Running on $ncpu MPI, $nthreads OpenMP threads"
srun -n $ncpu -c $nthreads $bindir/yambo -F $filein -J $jdir -C $cdir

