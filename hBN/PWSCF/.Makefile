include ../.vars.mk

SAVE:  hBN.save
	(cd $< && $(P2Y))
hBN.save: Inputs/hBN_scf.in Inputs/hBN_nscf.in Pseudos/N.pz-vbc.UPF Pseudos/B.pz-vbc.UPF
	$(PW) < $< > hBN_scf.out
	$(PW) < $(word 2,$^) > hBN_nscf.out
clean:
	git ls-files --others --exclude-standard | xargs rm -fr
	git clean -f -d
