#!/bin/tcsh

set ABINIT = 'abinis-5.4.4'
set A2Y = 'a2y'

set DIRS = "0D_H2 1D_Si_wire 2D_Si_surface 3D_LiF"

foreach dir ($DIRS)
 if ( $#argv == 0 ) then
  echo [ `date +%H:%M` ] Abinit '@' $dir
  cd $dir/Abinit
  $ABINIT < $dir".files" > $dir."log"
  $A2Y -F ${dir}"_o" -O ../YAMBO
  mv ${dir}".out" ${dir}".out_REFERENCE"
  mv ${dir}".LOG" ${dir}".log_REFERENCE"
  cd ../../
 else if ( $#argv == 1 ) then
  cd $dir/Abinit
  rm -f ${dir}*".log"
  rm -f ${dir}*".LOG"
  rm -f ${dir}*".out"
  rm -f ${dir}"_"*
  rm -f ${dir}"."*A
  rm -f ${dir}"."*B
  rm -f ${dir}"."*C
  cd ../../
 endif
end
