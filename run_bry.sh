#!/bin/bash
#cd ${PBS_O_WORKDIR}
cd ${HOME}/ROMS/matlab
#
#matlab -nodisplay -r "d_roms2roms_4Yaeyama"
matlab -nodisplay -r "d_obc_roms2roms_4Yaeyama"
#matlab -nodisplay -r "roms_anima_flt3"
#matlab -nodisplay -hostfile $PBS_NODEFILE -r initial/d_roms2roms_4Yaeyama.m
