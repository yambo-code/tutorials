old_prefix="prefix='Si_e15.0_k4'"
old_ecut="ecutwfc=15.0"
for ecut in 10.0 12.5 15.0 17.5 20.0 22.5 25.0 27.5 30.0; do
  new_prefix="prefix='Si_e${ecut}_k4'"
  new_ecut="ecutwfc=${ecut}"
  sed -i "s|$old_prefix|$new_prefix|" input/Si.in
  sed -i "s|$old_ecut|$new_ecut|" input/Si.in
  echo "ecut= $ecut Ry"
  if [ "$ecut" -ne "15.0" ] ; then pw.x < input/Si.in > output/ecut_conv/Si_e${ecut}_k4.out ; fi
  old_prefix=$new_prefix
  old_ecut=$new_ecut
done
restore_prefix="prefix='Si_e15.0_k4'"
restore_ecut="ecutwfc=15.0"
sed -i "s|$old_prefix|$restore_prefix|" input/Si.in
sed -i "s|$old_ecut|$restore_ecut|" input/Si.in

