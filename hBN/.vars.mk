TUTORIAL_HOME=$(CURDIR)
PW_HOME=$(TUTORIAL_HOME)/PWSCF
Y_HOME=$(TUTORIAL_HOME)/YAMBO
YMB_EXE=/home/marini/Yambo/gpl/bin
P2Y=$(YMB_EXE)/p2y
YYY=$(YMB_EXE)/yambo
PW=pw.x
MAKE=make
PW_RFILES=$(wildcard $(PW_HOME)/Refs/*)
Y_RFILES=$(wildcard $(Y_HOME)/Refs/*)
PW_FILES=$(addprefix $(PW_HOME)/, $(notdir $(PW_RFILES)))
Y_FILES=$(addprefix $(Y_HOME)/, $(notdir $(Y_RFILES)))
