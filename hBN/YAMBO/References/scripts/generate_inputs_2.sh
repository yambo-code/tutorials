#!/bin/bash 
bands='10 20 30 40 50 60 70 80'
for i in ${bands}
 do
   sed  -e "s/1 | 40/1 | $i/g"  Inputs/gw_ppa_30b_3Ry.in  >  Inputs/gw_ppa_Gbnd$i'.in'
   mpirun -np 8 yambo -F Inputs/gw_ppa_Gbnd$i'.in' -J  Gbnd${i} -C References
 done
