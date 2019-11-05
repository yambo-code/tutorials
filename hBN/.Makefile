include .vars.mk

yambo_tut: $(Y_HOME)/SAVE
	ls $(Y_HOME)/SAVE
$(Y_HOME)/SAVE: $(PW_HOME)/hBN.save/SAVE
	mv $< $(Y_HOME)
$(PW_HOME)/hBN.save/SAVE:
	$(MAKE) -C $(PW_HOME)
clean:
	$(MAKE) -C $(PW_HOME) clean
	$(MAKE) -C $(Y_HOME) clean

clean_all:
	$(MAKE) -C $(PW_HOME) clean
	$(MAKE) -C $(Y_HOME) clean_all

