#!/bin/bash 
bands='10 20 50 100 150 200 250'
for i in ${bands}
do
  sed  -e "s/ETStpsXd= 100/ETStpsXd=$i/g"  Inputs/gw_ff.in  >  Inputs/gw_ff$i'.in'
  mpirun -np 8 yambo -F Inputs/gw_ff$i'.in' -J  ff${i} -C References
done
