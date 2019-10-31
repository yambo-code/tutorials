#!/bin/bash
#
echo "#Direct gap vs kpt" > DFT_gap1_kpt.dat
echo "#Indirect gap vs kpt" > DFT_gap2_kpt.dat
echo "#Direct gap vs kpt" > HF_gap1_kpt.dat
echo "#Indirect gap vs kpt" > HF_gap2_kpt.dat
k=(1 2 4 6 8)
for ((i=0 ; i<=4 ; i++ )); do
  if [ "${k[$i]}" -eq "1" ];
  then
    DFT_gap1=$(grep Gap ../../YAMBO/k_grid_Gamma/Results/r_setup | grep Direct | tail -c 20 | head -c 10)
    DFT_gap2=$(grep Gap ../../YAMBO/k_grid_Gamma/Results/r_setup | grep Indirect | tail -c 20 | head -c 10)
    d_HF_v=$(grep 0.000000 ../../YAMBO/k_grid_Gamma/Results/o-HF_7Ry.HF | head -n 1 | tail -c 11)
    d_HF_c1=$(grep -A 1 0.000000 ../../YAMBO/k_grid_Gamma/Results/o-HF_7Ry.HF | head -n 4 | tail -n 1 | tail -c 11)
    d_HF_c2=$(grep $DFT_gap2 ../../YAMBO/k_grid_Gamma/Results/o-HF_7Ry.HF | head -n 1 | tail -c 11)
  else
    DFT_gap1=$(grep Gap ../../YAMBO/k_grid_${k[$i]}x${k[$i]}x${k[$i]}/Results/r_setup | grep Direct | tail -c 20 | head -c 10)
    DFT_gap2=$(grep Gap ../../YAMBO/k_grid_${k[$i]}x${k[$i]}x${k[$i]}/Results/r_setup | grep Indirect | tail -c 20 | head -c 10)
    d_HF_v=$(grep 0.000000 ../../YAMBO/k_grid_${k[$i]}x${k[$i]}x${k[$i]}/Results/o-HF_7Ry.HF | head -n 1 | tail -c 11)
    d_HF_c1=$(grep -A 1 0.000000 ../../YAMBO/k_grid_${k[$i]}x${k[$i]}x${k[$i]}/Results/o-HF_7Ry.HF | head -n 4 | tail -n 1 | tail -c 11)
    d_HF_c2=$(grep $DFT_gap2 ../../YAMBO/k_grid_${k[$i]}x${k[$i]}x${k[$i]}/Results/o-HF_7Ry.HF | head -n 1 | tail -c 11)
  fi
  HF_gap1=$( echo "scale=6; -$d_HF_v+$d_HF_c1" | bc -l )
  HF_gap2=$( echo "scale=6; -$d_HF_v+$d_HF_c2" | bc -l )
  echo  ${k[$i]}"  "$DFT_gap1 >> DFT_gap1_kpt.dat
  echo  ${k[$i]}"  "$DFT_gap2 >> DFT_gap2_kpt.dat
  echo  ${k[$i]}"  "$HF_gap1 >> HF_gap1_kpt.dat
  echo  ${k[$i]}"  "$HF_gap2 >> HF_gap2_kpt.dat
done
#
#
echo "#Direct gap vs ecut" > HF_gap1_ecut.dat
echo "#Indirect gap vs ecut" > HF_gap2_ecut.dat
DFT_gap1=$(grep Gap ../../YAMBO/k_grid_4x4x4/Results/r_setup | grep Direct | tail -c 20 | head -c 10)
DFT_gap2=$(grep Gap ../../YAMBO/k_grid_4x4x4/Results/r_setup | grep Indirect | tail -c 20 | head -c 10)
#
for ecut in 1 3 6 7 15; do
  d_HF_v=$(grep 0.000000 ../../YAMBO/k_grid_4x4x4/Results/o-HF_${ecut}Ry.HF | head -n 1 | tail -c 11)
  d_HF_c1=$(grep -A 1 0.000000 ../../YAMBO/k_grid_4x4x4/Results/o-HF_${ecut}Ry.HF | head -n 4 | tail -n 1 | tail -c 11)
  d_HF_c2=$(grep $DFT_gap2 ../../YAMBO/k_grid_4x4x4/Results/o-HF_${ecut}Ry.HF | head -n 1 | tail -c 11)
  HF_gap1=$( echo "scale=6; -$d_HF_v+$d_HF_c1" | bc -l )
  HF_gap2=$( echo "scale=6; -$d_HF_v+$d_HF_c2" | bc -l )
  echo  $ecut"  "$HF_gap1 >> HF_gap1_ecut.dat
  echo  $ecut"  "$HF_gap2 >> HF_gap2_ecut.dat
done

