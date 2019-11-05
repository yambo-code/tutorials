set output '08_ALDA.pdf'
set term pdf
set xlabel 'Energy (eV)' font ",10"
set ylabel 'Optical Absorption' font ",10"
set key right font ",8"
set style line 1 lw 4 lc rgb "purple" pointtype 6
set style line 2 lw 4 lc rgb "sea-green" pointtype 8
plot 'References/o-3D_ALDA.eps_q1_inv_alda_dyson' u 1:2 w l ls 1 t 'ALDA', 'References/o-3D_ALDA.eps_q1_inv_alda_dyson' u 1:4 w l ls 2 t 'IPA'
