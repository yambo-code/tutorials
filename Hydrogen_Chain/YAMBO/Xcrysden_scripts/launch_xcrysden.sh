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
 xcrysden -s ../bin/2D.xcrysden
 rm -f file.xsf
 mv print.png $1".png"
fi

if test -n "$threeD"  ; then 
 cp $1 file.xsf
 xcrysden -s ../bin/3D.xcrysden
 rm -f file.xsf
 mv print.png $1".png"
fi

