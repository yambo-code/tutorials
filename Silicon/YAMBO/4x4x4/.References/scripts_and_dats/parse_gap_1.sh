#!/bin/bash 

FILES=(`find . -name \*$1\* |grep o-`)
if [ ! -f ${FILES[0]} ]
then
    echo "File not found"
    exit
fi
rm -f $2
for file in ${FILES[*]}
 do
   VBMo=`grep " 1.000" $file | grep " 4.0000" | grep " 0.000" | awk '{print $3}'`
   VBM=`grep " 1.000" $file | grep " 4.0000" | grep " 0.000" | awk '{print $4}'`
   CBMo=`grep " 2.576" $file | grep " 5.000" | awk '{print $3}'`
   CBM=`grep " 2.576" $file | grep " 5.000" | awk '{print $4}'`
   case "$file" in 
    *-01HF*)
      echo  $file $VBMo $VBM $CBMo $CBM | awk '{print $1 " " $5-$3 }' >>  "$2"
      ;;
    *)
      echo  $file $VBMo $VBM $CBMo $CBM | awk '{print $1 " " $4+$5 }' >>  "$2"
      ;;
   esac
 done
