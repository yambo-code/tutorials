#!/bin/tcsh

set DIRS = "2.05 2.1 2.2 2.3 2.4 2.5"

foreach dir ($DIRS)
 date +%H:%M
 echo "Abinit ["$dir"] "
 cd $dir/
# abinis-5.8.0 < ../files > h2_chain.log
 /home/marini/Yambo/yambo-3.2.4/branches/gpl/bin/a2y -F h2_chain_o_DS2_KSS -O ../../${dir}
 cd ../
end
