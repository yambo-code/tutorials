#!/bin/tcsh

set DIRS = "2.05 2.1 2.2 2.3 2.4 2.5" 

set APPS = "BSE_RIM TDLDA"

foreach dir ($DIRS)

cd $dir

set POSITION=`echo "scale=4;$dir/2+1" | bc -l`
echo $POSITION

foreach app ($APPS)

rm -f ypp.in
ypp -e s -J $app >& /dev/null
set head_line  = `grep -v '#' o-${app}.exc_I_sorted | head -1`
set STATE=`echo $head_line |  awk '{ na=split($0,a);printf("%d",a[3])}'`
set ENERGY=`echo $head_line |  awk '{ na=split($0,a);printf("%f",a[1])}'`
echo "${app}:" $STATE "@" $ENERGY

cat << EOF > ypp.in
exc_wf
excp 
plot 
Format= "x" 
Direction= "123"
States= "$STATE"
Degen_Step=   0.0100     eV
% Cells
 16 |  1 |  1 |
%
% Hole
 $POSITION | 12.5 | 12.5
%
EOF
ypp -J ${app}  >& /dev/null
set file = "o-"${app}".exc_3d_"$STATE".xsf"
../bin/launch_xcrysden.sh $file
mv $file".png" $dir"."$file".png"

echo $file

end
cd ..
end

