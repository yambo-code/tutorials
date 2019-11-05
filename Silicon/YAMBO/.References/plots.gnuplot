
#set xrange [-2:8]
#set yrange [-5:10]

set xlabel "Number of K-points in the BZ"
set ylabel "Direct gap [eV]"

set term png
set out "hf_direct_gap_vs_kpoints.png"
p 'hf_direct_gap_vs_kpoints.dat'w lp
#pause -1

set term png
set out "Cohsex_HF7Ry_X0Ry-nb10_gap_vs_kpoints.png"
p 'Cohsex_HF7Ry_X0Ry-nb10_gap_vs_kpoints.dat'w lp

set term png
set out "PPA_gap_vs_kpts.png"
p 'PPA_gap_vs_kpts.dat'w lp

set xlabel "W size [Ry]"
set term png
set out "PPA_W_size.png"
p '4x4x4/PPA_W_size.dat'w lp
set out "COHSEX_no_empties_W_size.png"
p '4x4x4/COHSEX_no_empties_W_size.dat'w lp
#pause -1

set xlabel "W bands"
set term png
set out "PPA_W_bands.png"
p '4x4x4/PPA_W_bands.dat'w lp
set out "COHSEX_no_empties_W_bands.png"
p '4x4x4/COHSEX_no_empties_W_bands.dat'w lp
#pause -1

set xlabel "G bands"
set term png
set out "PPA_G_bands.png"
p '4x4x4/PPA_G_bands.dat'w lp
set out "COHSEX_empties_G_bands.png"
p '4x4x4/COHSEX_empties_G_bands.dat'w lp
#pause -1


