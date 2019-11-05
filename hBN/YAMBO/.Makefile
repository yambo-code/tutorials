include ../.vars.mk

References/o-3D_QP1_BSE.eps_q1_diago_bse: Inputs/05_3D_BSE_stretch.in 3D_BSE/ndb.em1s 
	$(YYY) -F $< -J "3D_QP1_BSE,3D_BSE" -C References

References/o-3D_QP_BSE.eps_q1_diago_bse: Inputs/05_3D_QP_BSE.in 3D_BSE/ndb.em1s 3D_QP_BSE/ndb.QP
	$(YYY) -F $< -J "3D_QP_BSE,3D_BSE" -C References

3D_QP_BSE/ndb.QP: Inputs/04_3D_QP_BSE_g0w0.in SAVE/ndb.kindx
	$(YYY) -F $< -J 3D_QP_BSE  -C References

References/o-3D_BSE-high.eps_q1_haydock_bse: Inputs/03_3D_BSE_haydock_solver_high.in 3D_BSE/ndb.BS_Q1_CPU_0
	$(YYY) -F $< -J "3D_BSE-high,3D_BSE" -C References

References/o-3D_BSE-low.eps_q1_haydock_bse: Inputs/03_3D_BSE_haydock_solver_low.in 3D_BSE/ndb.BS_Q1_CPU_0
	$(YYY) -F $< -J "3D_BSE-low,3D_BSE" -C References

References/o-3D_BSE.eps_q1_diago_bse: Inputs/03_3D_BSE_diago_solver.in 3D_BSE/ndb.BS_Q1_CPU_0
	$(YYY) -F $< -J 3D_BSE -C References

3D_BSE/ndb.BS_Q1_CPU_0: Inputs/02_3D_BSE_kernel.in 3D_BSE/ndb.em1s
	$(YYY) -F $< -J 3D_BSE -C References

3D_BSE/ndb.em1s: Inputs/01_3D_BSE_screening.in SAVE/ndb.kindx
	$(YYY) -F $< -J 3D_BSE -C References
References/o-3D_LRC.eps_q1_inv_LRC_dyson: Inputs/09_LRC.in SAVE/ndb.kindx
	$(YYY) -F $< -J 3D_LRC -C References
References/o-3D_ALDA.eps_q1_inv_alda_dyson: Inputs/08_ALDA.in SAVE/ndb.kindx
	$(YYY) -F $< -J 3D_ALDA -C References

SAVE/ndb.kindx: | SAVE
	$(YYY) 

plotdia: Inputs/plotting/plot_bse_diago.plt References/o-3D_BSE.eps_q1_diago_bse 
	gnuplot $<
plothay: Inputs/plotting/plot_bse_haydock.plt Inputs/plotting/plot_bse_haydock_high.plt References/o-3D_BSE-low.eps_q1_haydock_bse References/o-3D_BSE-high.eps_q1_haydock_bse
	gnuplot $<
	gnuplot $(word 2,$^)
plotlrc: Inputs/plotting/plot_lrc.plt References/o-3D_LRC.eps_q1_inv_LRC_dyson
	gnuplot $<
plotlda: Inputs/plotting/plot_lda.plt References/o-3D_ALDA.eps_q1_inv_alda_dyson
	gnuplot $<
#plotqpcorr: Inputs/plot_diago_qp.plt References/o-3D_QP_BSE.eps_q1_diago_bse References/o-3D_BSE.eps_q1_diago_bse
#	gnuplot $<

diago: SAVE/ndb.kindx 3D_BSE/ndb.em1s 3D_BSE/ndb.BS_Q1_CPU_0 References/o-3D_BSE.eps_q1_diago_bse plotdia

haydock: SAVE/ndb.kindx 3D_BSE/ndb.em1s 3D_BSE/ndb.BS_Q1_CPU_0 References/o-3D_BSE-low.eps_q1_haydock_bse References/o-3D_BSE-high.eps_q1_haydock_bse plothay

tddft: SAVE/ndb.kindx References/o-3D_ALDA.eps_q1_inv_alda_dyson References/o-3D_LRC.eps_q1_inv_LRC_dyson plotlda plotlrc

#qpcorr: SAVE/ndb.kindx 3D_BSE/ndb.em1s 3D_QP_BSE/ndb.QP References/o-3D_QP_BSE.eps_q1_diago_bse plotqpcorr

all: diago haydock qpcorr

clean:
	rm -rf r_* o-* l-* l_* r-* *.pdf SAVE/ndb.* o.* 3D_BSE 3D_QP_BSE 3D_ALDA 3D_LRC
clean_all:
	$(MAKE) clean
	rm -rf SAVE 
