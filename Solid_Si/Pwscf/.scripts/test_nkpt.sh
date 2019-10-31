#!/bin/bash
old_prefix="prefix='Si_e15.0_k4'"
old_kpt="  4 4 4 1 1 1"
for ((k=2 ; k<=10 ; k++ )); do
  new_prefix="prefix='Si_e15.0_k${k}'"
  new_kpt="  $k $k $k 1 1 1"
  sed -i "s|$old_prefix|$new_prefix|" input/Si.in
  sed -i "s|$old_kpt|$new_kpt|" input/Si.in
  echo "nkpt= ${k}x3"
  pw.x < input/Si.in > output/kpt_conv/Si_e15.0_k${k}.out
  old_prefix=$new_prefix
  old_kpt=$new_kpt
done
restore_prefix="prefix='Si_e15.0_k4'"
restore_kpt="  4 4 4 1 1 1"
sed -i "s|$old_prefix|$restore_prefix|" input/Si.in
sed -i "s|$old_kpt|$restore_kpt|" input/Si.in

