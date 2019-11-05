set output '03_bse_diago.pdf'
set term pdf
set xlabel 'Energy (eV)' font ",10"
set ylabel 'Optical Absorption' font ",10"
set key left font ",8"
set style line 1 lw 4 lc rgb "purple" pointtype 6
set style line 2 lw 4 lc rgb "sea-green" pointtype 8
plot 'References/o-3D_BSE.eps_q1_diago_bse' u 1:2 w l ls 1 t 'BSE', 'References/o-3D_BSE.eps_q1_diago_bse' u 1:4 w l ls 2 t 'IPA'
