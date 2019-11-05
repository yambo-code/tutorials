#!/bin/bash 
case "$1" in
 *Cohsex*)
   INFILE="02Cohsex"
   ;;
 *PPA*)
   INFILE="03GoWo_PPA_corrections"
   ;;
esac
GB='10 20 30 40 50'
for i in ${GB}
 do
   sed  -e "s/ 1 |  10 / 1 |  $i /g"  Inputs/${INFILE}  >  ${INFILE}_$i'.in'
   yambo -F  ${INFILE}_$i'.in' -J $1_HF7Ry_X1Ry-Xnb10-Gnb${i} -C References
   rm -f ${INFILE}_$i'.in'
 done
