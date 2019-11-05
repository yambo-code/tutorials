set output '03_bse_haydock.pdf'
set term pdf dashed
set key left font ",8"
set xlabel 'Energy (eV)' font ",10"
set ylabel 'Optical Absorption ' font ",10"
set style line 1 lt 1 lw 4 lc rgb "purple" pointtype 6
set style line 2 lt 2 lw 4 lc rgb "sea-green" pointtype 8
set style line 3 lt 3 lw 4 lc rgb "gold" pointtype 8
set xrange [2:8]
plot 'o-3D_BSE.eps_q1_diago_bse' u 1:2 w l ls 1 t 'Diagonalization', 'o-3D_BSE-low.eps_q1_haydock_bse' u 1:2 w l ls 2 t 'Haydock (21 its)', 'o-3D_BSE-low.eps_q1_haydock_bse' u 1:6 w l ls 3 t 'Haydock (20 its)'
