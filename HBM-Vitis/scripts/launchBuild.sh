#!/bin/bash
source scripts/setenv_2020.2.sh
make cleanall
make all TARGET=hw CFG_FILE=alveou280.ini DEVICE=xilinx_u280_xdma_201920_3
