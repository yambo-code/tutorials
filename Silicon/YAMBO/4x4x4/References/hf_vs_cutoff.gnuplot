set xrange [-2:8]
set yrange [-6:10]
set xlabel "Eo [eV]"
set ylabel "E_hf-Eo [eV]"
p 'References/o-HF_3Ry.hf' u 3:($4-$3) w p t "3Ry"
rep 'References/o-HF_6Ry.hf' u 3:($4-$3) w p t "6Ry"
rep 'References/o-HF_7Ry.hf' u 3:($4-$3) w p t "7Ry"
rep 'References/o-HF_15Ry.hf' u 3:($4-$3) w p t "15Ry"


