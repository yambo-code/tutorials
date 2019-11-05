#!/bin/bash 
bands='10 20 30 40'
blocks='1 2 3 4 5'
for i in ${bands}
 do
  for j in ${blocks}
   do
    sed  -e "s/1 | 10/1 | $i/g"  Inputs/gw_ppa.in  > tmp$i
    sed  -e "s/NGsBlkXp= 1/ NGsBlkXp= $j/g"  tmp$i > gw_ppa_$i'b_'$j'Ry.in'
    mpirun -np 8 yambo -F gw_ppa_${i}b_${j}Ry.in -J ${i}b_${j}Ry -C References
    rm tmp*
   done
 done
