#!/bin/bash
cd ${PBS_O_WORKDIR}
#matlab -nodisplay -r initial/d_roms2roms_4Yaeyama.m
matlab -nodisplay -hostfile $PBS_NODEFILE -r initial/d_roms2roms_4Yaeyama.m
