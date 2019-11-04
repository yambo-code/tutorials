include vars.mk

yambo_tut: $(Y_HOME)/SAVE
	ls $(Y_HOME)/SAVE
$(Y_HOME)/SAVE: $(PW_HOME)/tmp/hbn.save/SAVE
	mv $< $(Y_HOME)
$(PW_HOME)/tmp/hbn.save/SAVE:
	$(MAKE) -C $(PW_HOME)
clean:
	$(MAKE) -C $(PW_HOME) clean
	$(MAKE) -C $(Y_HOME) clean

clean_all:
	$(MAKE) -C $(PW_HOME) clean
	$(MAKE) -C $(Y_HOME) clean_all
	rm -f tut_outputs.tar

report: 
	tar -cvf tut_outputs.tar $(PW_FILES) $(Y_FILES) make.log
