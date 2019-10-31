#!/bin/tcsh

set DIRS = "2.05 2.1 2.2 2.3 2.4 2.5"

foreach dir ($DIRS)
 date +%H:%M
 echo "1. Prerun ["$dir"] ... "
 yambo -I  $dir -O $dir -C $dir  >&/dev/null
 date +%H:%M
 echo "2. TDLDA ["$dir"] ... "
 yambo -I  $dir -O $dir -C $dir -J TDLDA -F inputs/tdlda.in  >&/dev/null
 date +%H:%M
 echo "3. BSE ["$dir"] ... "
 yambo -I  $dir -O $dir -C $dir -J BSE -F inputs/bse.in  >&/dev/null
 date +%H:%M
 cp $dir/BSE/ndb.em1s $dir/SAVE
 echo "4. BSE + RIM ["$dir"] ... "
 yambo -I  $dir -O $dir -C $dir -J BSE_RIM -F inputs/bse_plus_rim.in  >&/dev/null
 date +%H:%M
 echo "5. density plot ["$dir"] ... "
 ypp -I  $dir -C $dir -F inputs/density_plot.in  >&/dev/null
 cd $dir
 ../bin/launch_xcrysden.sh o.density_2d.xsf
 mv o.density_2d.xsf.png $dir.o.density_2d.xsf.png
 cd ..
 date +%H:%M
end
