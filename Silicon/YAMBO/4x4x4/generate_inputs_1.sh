#!/bin/bash 
case "$1" in
 *Cohsex*)
   INFILE="02Cohsex"
   ;;
 *PPA*)
   INFILE="03GoWo_PPA_corrections"
   ;;
 *)
   exit
   ;;
esac
XG='1 3 6 7'
for i in ${XG}
 do
   sed  -e "s/1 RL/$i Ry/g"  Inputs/${INFILE}  >  ${INFILE}_$i'.in'
   yambo -F  ${INFILE}_$i'.in' -J $1_HF7Ry_X${i}Ry-Xnb10-Gnb10 -C References
   rm -f ${INFILE}_$i'.in'
 done
