#!/bin/bash 
#
#grep "NGsBlkXp" o-10b_* | awk '{print $4}' > tmp1
#grep "used" o-10b_* |awk '{print $5}' > tmp2
#cat o-10b* | grep "8.000" |  awk '{print $3+$4}' > tmp3
#cat o-10b* | grep "9.000" |  awk '{print $3+$4}' > tmp4
#paste tmp1 tmp2 tmp3 tmp4 > 10b.dat
#rm tmp1 tmp2 tmp3 tmp4
#
grep "X Steps" o-ff* | awk '{print $5}' > tmp1
#grep "used" o-10b_* |awk '{print $5}' > tmp2
cat o-ff* | grep "8.000" |  awk '{print $3+$4}' > tmp3
cat o-ff* | grep "9.000" |  awk '{print $3+$4}' > tmp4
paste tmp1 tmp3 tmp4 > ff.dat
rm tmp1 tmp3 tmp4
#
