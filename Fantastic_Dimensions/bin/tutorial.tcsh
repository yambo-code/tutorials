#!/bin/tcsh

if ( $#argv == 0 ) goto help

set YAMBO = '/home/cfc/myrta/Sources/yambo_GPL/bin/yambo'
set NRUNS = 8

if ("$argv[1]" == "0D_H2" ) then
set NRUNS = 6
set INPUTS = ("01_init" \
 "02_RPA_no_LF" "03_RPA_LF 03_RPA_LF_r_space 03_RPA_LF_xl 03_RPA_LF_QP" \
 "04_alda_r_space" "05_W" "06_BSE" )
set JOBS = ("01_init" \
 "02_RPA_no_LF" "03_RPA_LF" "03_RPA_LF_r_space" "03_RPA_LF_xl" "03_RPA_LF_QP" \
 "04_alda_r_space" "05_W" "06_BSE" )

else if ("$argv[1]" == "1D_Si_wire" ) then
set INPUTS = ("01_init" \
 "02_RPA_no_LF_par 02_RPA_no_LF_perp" "03_RPA_LF_par 03_RPA_LF_perp 03_RPA_LF_QP" \
 "04_alda_g_space 04_alda_r_space" "05_W" "06_BSE" "07_LRC" )
set JOBS = ("01_init" \
 "02_RPA_no_LF_par" "02_RPA_no_LF_perp" \
 "03_RPA_LF_par" "03_RPA_LF_perp"  "03_RPA_LF_QP" \
 "04_alda_g_space" "04_alda_r_space" "05_W" "06_BSE"  "07_LRC" )

else if ("$argv[1]" == "2D_Si_surface" ) then
set INPUTS = ("01_init" \
 "02_RPA_no_LF_par 02_RPA_no_LF_perp" "03_RPA_LF 03_RPA_LF_QP" "04_alda_r_space" \
 "05_W" "06_BSE" "07_LRC" )
set JOBS = ("01_init" \
 "02_RPA_no_LF_par" "02_RPA_no_LF_perp" "03_RPA_LF" "03_RPA_LF_QP" \
 "04_alda_r_space" "05_W" "06_BSE" "07_LRC" )

else if ("$argv[1]" == "3D_LiF" ) then
set INPUTS = ("01_init" \
 "02_RPA_no_LF" "03_RPA_LF 03_RPA_LF_QP" "04_alda_g_space" "05_W" \
 "06_BSE" "07_LRC" )
set JOBS = ("01_init" \
 "02_RPA_no_LF" "03_RPA_LF" "03_RPA_LF_QP" "04_alda_g_space" \
 "05_W" "06_BSE" "07_LRC" )

endif

if ("$argv[2]" == "clean" ) then
cd $argv[1]/YAMBO
rm -f SAVE/*db.* l* r* o*
foreach job ($JOBS)
 if ( -e "$job") then
   rm -f $job/*
   rmdir $job
 endif
end
exit 0
endif

if ("$argv[2]" == "all" ) then
cd $argv[1]/YAMBO
@ ii = 1
 while ($ii < $NRUNS) 

foreach file ($INPUTS[$ii])
 echo [ `date +%H:%M` ] $file '@' $argv[1]
 if ( "$ii" == "5" ) then
   $YAMBO -F Inputs/$file  >& /dev/null
 else
   $YAMBO -F Inputs/$file -J $file  >& /dev/null
 endif
end
  @ ii ++
 end
 echo [ `date +%H:%M` ] END
 exit 0
endif

if ("$argv[2]" == "plot" ) then
 cd $argv[1]/YAMBO
 foreach file (o-*)
  echo p "'"$file"'" w l, "'"Results/$file"'" w p >> o-gnuplot
  echo pause -1 >> o-gnuplot
 end
 exit 0
endif

foreach file ($INPUTS[$argv[2]])
 cd $argv[1]/YAMBO
 echo [ `date +%H:%M` ] $file '@' $argv[1]
 if ("$argv[1]" == "5" ) then
   $YAMBO -F Inputs/$file  >& /dev/null
 else
   $YAMBO -F Inputs/$file -J $file  >& /dev/null
 endif
end

help:
 echo ""
 echo $0 "[0D_H2/1D_Si_wire/2D_Si_surface/3D_LiF] [all/plot/##]"
 echo ""

