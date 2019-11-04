#!/bin/bash
#
echo "#Direct gap vs kpt" > Cohsex_gap1_kpt.dat
echo "#Indirect gap vs kpt" > Cohsex_gap2_kpt.dat
k=(1 2 4 6 8)
for ((i=0 ; i<=4 ; i++ )); do
  if [ "${k[$i]}" -eq "1" ];
  then
    DFT_gap1=$(grep Gap ../../YAMBO/k_grid_Gamma/Results/r_setup | grep Direct | tail -c 20 | head -c 6)
    DFT_gap2=$(grep Gap ../../YAMBO/k_grid_Gamma/Results/r_setup | grep Indirect | tail -c 20 | head -c 6)
    d_Cohsex_v=$(grep 0.000000 ../../YAMBO/k_grid_Gamma/Results/o-Cohsex_HF7Ry_X0Ry-nb10.qp | head -n 2 | tail -c 21 | head -c 10)
    d_Cohsex_c1=$(grep -A 1 0.000000 ../../YAMBO/k_grid_Gamma/Results/o-Cohsex_HF7Ry_X0Ry-nb10.qp | head -n 4 | tail -c 21  | head -c 10)
    d_Cohsex_c2=$(grep $DFT_gap2 ../../YAMBO/k_grid_Gamma/Results/o-Cohsex_HF7Ry_X0Ry-nb10.qp | tail -c 21 | head -c 10)
  else
    DFT_gap1=$(grep Gap ../../YAMBO/k_grid_${k[$i]}x${k[$i]}x${k[$i]}/Results/r_setup | grep Direct | tail -c 20 | head -c 6)
    DFT_gap2=$(grep Gap ../../YAMBO/k_grid_${k[$i]}x${k[$i]}x${k[$i]}/Results/r_setup | grep Indirect | tail -c 20 | head -c 6)
    d_Cohsex_v=$(grep 0.000000 ../../YAMBO/k_grid_${k[$i]}x${k[$i]}x${k[$i]}/Results/o-Cohsex_HF7Ry_X0Ry-nb10.qp | head -n 2 | tail -c 21 | head -c 10)
    d_Cohsex_c1=$(grep -A 1 0.000000 ../../YAMBO/k_grid_${k[$i]}x${k[$i]}x${k[$i]}/Results/o-Cohsex_HF7Ry_X0Ry-nb10.qp | head -n 4 | tail -c 21  | head -c 10)
    d_Cohsex_c2=$(grep $DFT_gap2 ../../YAMBO/k_grid_${k[$i]}x${k[$i]}x${k[$i]}/Results/o-Cohsex_HF7Ry_X0Ry-nb10.qp | tail -c 21 | head -c 10)
  fi
  echo ${k[$i]}"  "$d_Cohsex_v"  "$d_Cohsex_c1"  "$d_Cohsex_c2
  Cohsex_gap1=$( echo "scale=6; $DFT_gap1-1*($d_Cohsex_v)+$d_Cohsex_c1" | bc -l )
  Cohsex_gap2=$( echo "scale=6; $DFT_gap2-1*($d_Cohsex_v)+$d_Cohsex_c2" | bc -l )
  echo  ${k[$i]}"  "$Cohsex_gap1 >> Cohsex_gap1_kpt.dat
  echo  ${k[$i]}"  "$Cohsex_gap2 >> Cohsex_gap2_kpt.dat
done
#
echo "#Direct gap vs Xecut" > Cohsex_gap1_Xecut.dat
echo "#Indirect gap vs Xecut" > Cohsex_gap2_Xecut.dat
DFT_gap1=$(grep Gap ../../YAMBO/k_grid_4x4x4/Results/r_setup | grep Direct | tail -c 20 | head -c 10)
DFT_gap2=$(grep Gap ../../YAMBO/k_grid_4x4x4/Results/r_setup | grep Indirect | tail -c 20 | head -c 10)
#
echo "Xecut"
echo $DFT_gap1"  "$DFT_gap2
Xecut=(0Ry 1Ry 3Ry 6Ry 7Ry)
Xe=(0 1 3 6 7)
for ((i=0 ; i<=4 ; i++ )); do
  d_Cohsex_v=$(grep 0.000000 ../../YAMBO/k_grid_4x4x4/Results/o-Cohsex_HF7Ry_X${Xecut[$i]}-nb10.qp | head -n 2 | tail -c 21 | head -c 10)
  d_Cohsex_c1=$(grep -A 1 0.000000 ../../YAMBO/k_grid_4x4x4/Results/o-Cohsex_HF7Ry_X${Xecut[$i]}-nb10.qp | head -n 4 | tail -c 21  | head -c 10)
  d_Cohsex_c2=$(grep $DFT_gap2 ../../YAMBO/k_grid_4x4x4/Results/o-Cohsex_HF7Ry_X${Xecut[$i]}-nb10.qp | tail -c 21 | head -c 10)
  Cohsex_gap1=$( echo "scale=6; $DFT_gap1 -1*($d_Cohsex_v)+$d_Cohsex_c1" | bc -l )
  Cohsex_gap2=$( echo "scale=6; $DFT_gap2 -1*($d_Cohsex_v)+$d_Cohsex_c2" | bc -l )
  echo ${Xe[$i]}"  "$d_Cohsex_v"  "$d_Cohsex_c1"  "$d_Cohsex_c2
  echo ${Xe[$i]}"  "$Cohsex_gap1 >> Cohsex_gap1_Xecut.dat
  echo ${Xe[$i]}"  "$Cohsex_gap2 >> Cohsex_gap2_Xecut.dat
done
#
#
echo "#Direct gap vs Xnb" > Cohsex_gap1_Xnb.dat
echo "#Indirect gap vs Xnb" > Cohsex_gap2_Xnb.dat
DFT_gap1=$(grep Gap ../../YAMBO/k_grid_4x4x4/Results/r_setup | grep Direct | tail -c 20 | head -c 7)
DFT_gap2=$(grep Gap ../../YAMBO/k_grid_4x4x4/Results/r_setup | grep Indirect | tail -c 20 | head -c 7)
#
echo "Xnb"
echo $DFT_gap1"  "$DFT_gap2
for Xnb in 7 10 15 20 30 40 50; do
  d_Cohsex_v=$(grep 0.00000 ../../YAMBO/k_grid_4x4x4/Results/o-Cohsex_HF7Ry_X1Ry-nb${Xnb}.qp | head -n 2 | tail -c 21 | head -c 10)
  d_Cohsex_c1=$(grep -A 1 0.00000 ../../YAMBO/k_grid_4x4x4/Results/o-Cohsex_HF7Ry_X1Ry-nb${Xnb}.qp | head -n 4 | tail -c 21  | head -c 10)
  d_Cohsex_c2=$(grep $DFT_gap2 ../../YAMBO/k_grid_4x4x4/Results/o-Cohsex_HF7Ry_X1Ry-nb${Xnb}.qp | tail -c 21 | head -c 10)
  Cohsex_gap1=$( echo "scale=6; $DFT_gap1-1*($d_Cohsex_v)+$d_Cohsex_c1" | bc -l )
  Cohsex_gap2=$( echo "scale=6; $DFT_gap2-1*($d_Cohsex_v)+$d_Cohsex_c2" | bc -l )
  echo $Xnb"  "$d_Cohsex_v"  "$d_Cohsex_c1"  "$d_Cohsex_c2
  echo  $Xnb"  "$Cohsex_gap1 >> Cohsex_gap1_Xnb.dat
  echo  $Xnb"  "$Cohsex_gap2 >> Cohsex_gap2_Xnb.dat
done
#
#
#
echo "#Direct gap vs Gnb" > Cohsex_gap1_Gnb.dat
echo "#Indirect gap vs Gnb" > Cohsex_gap2_Gnb.dat
DFT_gap1=$(grep Gap ../../YAMBO/k_grid_4x4x4/Results/r_setup | grep Direct | tail -c 20 | head -c 10)
DFT_gap2=$(grep Gap ../../YAMBO/k_grid_4x4x4/Results/r_setup | grep Indirect | tail -c 20 | head -c 10)
#
echo "Gnb"
echo $DFT_gap1"  "$DFT_gap2
for Gnb in 07 10 15 20 30 40; do
  d_Cohsex_v=$(grep 0.000000 ../../YAMBO/k_grid_4x4x4/Results/o-Cohsex_HF7Ry_X0Ry-nb10_nb${Gnb}.qp | head -n 2 | tail -c 21 | head -c 10)
  d_Cohsex_c1=$(grep -A 1 0.000000 ../../YAMBO/k_grid_4x4x4/Results/o-Cohsex_HF7Ry_X0Ry-nb10_nb${Gnb}.qp | head -n 4 | tail -c 21  | head -c 10)
  d_Cohsex_c2=$(grep $DFT_gap2 ../../YAMBO/k_grid_4x4x4/Results/o-Cohsex_HF7Ry_X0Ry-nb10_nb${Gnb}.qp | tail -c 21 | head -c 10)
  Cohsex_gap1=$( echo "scale=6; $DFT_gap1-1*($d_Cohsex_v)+$d_Cohsex_c1" | bc -l )
  Cohsex_gap2=$( echo "scale=6; $DFT_gap2-1*($d_Cohsex_v)+$d_Cohsex_c2" | bc -l )
  echo  $Gnb"  "$d_Cohsex_v"  "$d_Cohsex_c1"  "$d_Cohsex_c2
  echo  $Gnb"  "$Cohsex_gap1 >> Cohsex_gap1_Gnb.dat
  echo  $Gnb"  "$Cohsex_gap2 >> Cohsex_gap2_Gnb.dat
done
