set xrange [-2:8]
set yrange [-5:10]
set xlabel "Eo [eV]"
set ylabel "E_hf-Eo [eV]"
p 'GAMMA/References/o-01HF_corrections.hf' u 3:($4-$3) w p t "Gamma"
rep '2x2x2/References/o-01HF_corrections.hf' u 3:($4-$3) w p t "2x2x2"
rep '4x4x4/References/o-01HF_corrections.hf' u 3:($4-$3) w p t "4x4x4"
rep '6x6x6/References/o-01HF_corrections.hf' u 3:($4-$3) w p t "6x6x6"
rep '8x8x8/References/o-01HF_corrections.hf' u 3:($4-$3) w p t "8x8x8"


