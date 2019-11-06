#! /bin/sh
#
if [ $# != 1 ] ; then
 echo $0 "o- file"
 exit 0
fi

twoD=`echo $1 |grep '2d'`
threeD=`echo $1 |grep '3d'`

if test -n "$twoD"  ; then 
 cp $1 file.xsf
 xcrysden -s ../Xcrysden_scripts/2D.xcrysden
# mv print.png $1".png"
 rm -f file.xsf
fi

if test -n "$threeD"  ; then 
 cp $1 file.xsf
 xcrysden -s ../Xcrysden_scripts/3D.xcrysden
# mv print.png $1".png"
# xcrysden -s ../Xcrysden_scripts/geo.xcrysden
# mv print.png $1"-geo.png"
# rm -f file.xsf
fi

