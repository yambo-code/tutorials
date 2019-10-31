#!/bin/bash
#
echo "#Direct gap" > Direct_Gap.dat
echo "#Indirect gap" > Indirect_Gap.dat
#
##############
# Experimental
echo "Experimental"
echo "1.0  3.4" >> Direct_Gap.dat
echo "1.0  1.1" >> Indirect_Gap.dat 
echo "   " >> Direct_Gap.dat
echo "   " >> Indirect_Gap.dat 
#
##############
# DFT
echo "DFT"
DFT_Dgap=$(grep Gap ../../YAMBO/8x8x8/REFERENCE/r-00_init_setup | grep Direct | tail -c 20 | head -c 6)
DFT_Igap=$(grep Gap ../../YAMBO/8x8x8/REFERENCE/r-00_init_setup | grep Indirect | tail -c 20 | head -c 6)
#
echo "1.1  "$DFT_Dgap >> Direct_Gap.dat
echo "1.1  "$DFT_Igap >> Indirect_Gap.dat 
echo "   " >> Direct_Gap.dat
echo "   " >> Indirect_Gap.dat 
#
##############
# HF
echo "HF"
d_HF_v=$(grep 0.000000 ../../YAMBO/8x8x8/REFERENCE/o-HF_7Ry.HF | head -n 1 | tail -c 11)
d_HF_c1=$(grep -A 1 0.000000 ../../YAMBO/8x8x8/REFERENCE/o-HF_7Ry.HF | head -n 4 | tail -n 1 | tail -c 11)
d_HF_c2=$(grep $DFT_Igap ../../YAMBO/8x8x8/REFERENCE/o-HF_7Ry.HF | head -n 1 | tail -c 11)
#
HF_Dgap=$( echo "scale=6; -$d_HF_v+$d_HF_c1" | bc -l )
HF_Igap=$( echo "scale=6; -$d_HF_v+$d_HF_c2" | bc -l )
#
echo "1.2  "$HF_Dgap >> Direct_Gap.dat
echo "1.2  "$HF_Igap >> Indirect_Gap.dat 
echo "   " >> Direct_Gap.dat
echo "   " >> Indirect_Gap.dat 
#
# DFT reference for Cohsex and GoWo
DFT_gap1=$(grep Gap ../../YAMBO/4x4x4/REFERENCE/r-00_init_setup | grep Direct | tail -c 20 | head -c 7)
DFT_gap2=$(grep Gap ../../YAMBO/4x4x4/REFERENCE/r-00_init_setup | grep Indirect | tail -c 20 | head -c 7)
##############
# Cohsex
echo "Cohsex"
d_Cohsex_v=$(grep 0.00000 ../../YAMBO/4x4x4/REFERENCE/full_parameters/o-Cohsex_HF7Ry_X7Ry-nb30.qp | head -n 2 | tail -c 21 | head -c 10)
d_Cohsex_c1=$(grep -A 1 0.00000 ../../YAMBO/4x4x4/REFERENCE/full_parameters/o-Cohsex_HF7Ry_X7Ry-nb30.qp | head -n 4 | tail -c 21  | head -c 10)
d_Cohsex_c2=$(grep $DFT_gap2 ../../YAMBO/4x4x4/REFERENCE/full_parameters/o-Cohsex_HF7Ry_X7Ry-nb30.qp | tail -c 21 | head -c 10)
#
Cohsex_Dgap=$( echo "scale=6; $DFT_gap1-1*($d_Cohsex_v)+$d_Cohsex_c1" | bc -l )
Cohsex_Igap=$( echo "scale=6; $DFT_gap2-1*($d_Cohsex_v)+$d_Cohsex_c2" | bc -l )
#
echo "1.3  "$Cohsex_Dgap >> Direct_Gap.dat
echo "1.3  "$Cohsex_Igap >> Indirect_Gap.dat 
echo "   " >> Direct_Gap.dat
echo "   " >> Indirect_Gap.dat 
#
##############
# GoWo (PPA)
echo "GoWo (PPA)"
d_GoWo_PPA_v=$(grep 0.00000 ../../YAMBO/4x4x4/REFERENCE/full_parameters/o-GoWo_PPA_HF7Ry_X7Ry-nb30_nb30.qp | head -n 2 | tail -c 21 | head -c 10)
d_GoWo_PPA_c1=$(grep -A 1 0.00000 ../../YAMBO/4x4x4/REFERENCE/full_parameters/o-GoWo_PPA_HF7Ry_X7Ry-nb30_nb30.qp | head -n 4 | tail -c 21  | head -c 10)
d_GoWo_PPA_c2=$(grep $DFT_gap2 ../../YAMBO/4x4x4/REFERENCE/full_parameters/o-GoWo_PPA_HF7Ry_X7Ry-nb30_nb30.qp | tail -c 21 | head -c 10)
#
GoWo_PPA_Dgap=$( echo "scale=6; $DFT_gap1-1*($d_GoWo_PPA_v)+$d_GoWo_PPA_c1" | bc -l )
GoWo_PPA_Igap=$( echo "scale=6; $DFT_gap2-1*($d_GoWo_PPA_v)+$d_GoWo_PPA_c2" | bc -l )
#
echo "1.4  "$GoWo_PPA_Dgap >> Direct_Gap.dat
echo "1.4  "$GoWo_PPA_Igap >> Indirect_Gap.dat
echo "   " >> Direct_Gap.dat
echo "   " >> Indirect_Gap.dat 
#
