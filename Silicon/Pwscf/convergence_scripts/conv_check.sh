#!/bin/bash
echo "Total E vs ecut"
for ecut in 10.0 12.5 15.0 17.5 20.0 22.5 25.0 27.5 30.0; do
  echo $ecut" :   "$(cat output/ecut_conv/Si_e${ecut}_k4.out | grep ! | tail -c 17)
done
echo "  "
echo "Eigenvalues vs ecut"
for ecut in 10.0 12.5 15.0 17.5 20.0 22.5 25.0 27.5 30.0; do
  echo $ecut" :   "$(cat output/ecut_conv/Si_e${ecut}_k4.out | grep -A 2 'k =-0.1250 0.1250 0.1250'  | tail -n 1 )
done
echo "  "
echo "Stress vc ecut"
for ecut in 10.0 12.5 15.0 17.5 20.0 22.5 25.0 27.5 30.0; do
  echo $ecut" : "$(cat output/ecut_conv/Si_e${ecut}_k4.out | grep -A 3 'total   stress' | tail -c 6 )" kbar"
done
#
echo "  "
echo "  ********  "
echo "Etot vs nkpt"
for ((k=2 ; k<=10 ; k++ )); do
  echo "nkpt= ${k} : "$(cat output/kpt_conv/Si_e15.0_k${k}.out | grep ! | tail -c 17)
done
echo "  "
echo "HOMO/LUMO vs nkpt"
for ((k=2 ; k<=10 ; k++ )); do
  echo "nkpt= ${k} : "$(cat output/kpt_conv/Si_e15.0_k${k}.out | grep  'highest' | tail -c 18 )
done
echo "  "
echo "Stress vs nkpt"
for ((k=2 ; k<=10 ; k++ )); do
  echo "nkpt= ${k} : "$(cat output/kpt_conv/Si_e15.0_k${k}.out | grep -A 3 'total   stress' | tail -c 6 )" kbar"
done
