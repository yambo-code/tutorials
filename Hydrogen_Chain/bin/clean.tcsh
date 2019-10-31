#!/bin/tcsh

set DIRS = "2.05 2.1 2.2 2.3 2.4 2.5"

foreach dir ($DIRS)
# cp -r WS/$dir .
 cd $dir
 y_clean o r l
 del SAVE/ndb*
 del *
# rm -fr BSE TDLDA
# mv BSE_RIM BSE
# cd BSE
# s_clean r l
# del *alpha* *sort* ndb*
# cp ../../WS/Images/${dir}*BSE*png .
 cd ../
end
