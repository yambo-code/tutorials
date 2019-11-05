set output '09_LRC.pdf'
set term pdf
set xlabel 'Energy (eV)' font ",10"
set ylabel 'Optical Absorption' font ",10"
set key left font ",8"
set style line 1 lw 4 lc rgb "purple" pointtype 6
set style line 2 lw 4 lc rgb "sea-green" pointtype 8
plot 'References/o-3D_LRC.eps_q1_inv_LRC_dyson' u 1:2 w l ls 1 t 'LRC', 'References/o-3D_LRC.eps_q1_inv_LRC_dyson' u 1:4 w l ls 2 t 'IPA'
