#!/bin/bash
#
#name='DIC_01'
#name='DIC_02'
#name='DIN_01'
#name='DIN_02'
#name='PO4_01'
#name='PO4_02'
#name='PhyCtot_01'
#name='PhyCtot_02'
#name='PhyNtot_01'
#name='PhyNtot_02'
#name='PhyPtot_01'
#name='PhyPtot_02'
#name='ZooC01_01'
#name='ZooC01_02'
#name='ZooN01_01'
#name='ZooN01_02'
#name='ZooP01_01'
#name='ZooP01_02'
#name='POC01_01'
#name='POC01_02'
#name='POC02_01'
#name='POC02_02'
#name='POC03_01'
#name='POC03_02'
#name='PON01_01'
#name='PON01_02'
#name='PON02_01'
#name='PON02_02'
#name='PON03_01'
#name='PON03_02'
#name='POP01_01'
#name='POP01_02'
#name='POP02_01'
#name='POP02_02'
#name='POP03_01'
name='POP03_02'

#name='sediment_POC02_02'

#name='mud_01'
#name='mud_02'


#img_dir='figs_png_Y1srf2'
#img_dir='figs_png_Y2btm'
#img_dir='figs_png_Y2srf'
#img_dir='figs_png_Y3btm'
#img_dir='figs_png_Y3srf'
#img_dir='figs_png_Y3btm2015S'
#img_dir='figs_png_cbl2016_temp_btm'
#img_dir='figs_png_Y1_nst_srf_v2'
img_dir='figs_png_Y2_nst_srf_v2'

#tag='Y1srf'
#tag='Y2btm'
#tag='Y2srf'
#tag='Y3btm'
#tag='Y3srf'
#tag='Y1_nst_srf_v2'
tag='Y2_nst_srf_v2'

printf "file '%s'\n" ${img_dir}/${name}*.png > imglist.txt

#ffmpeg -r:v 40 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -an anim/${tag}_${name}.mp4
#ffmpeg -r:v 30 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
ffmpeg -r:v 10 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
#
# -r:v 30 => 30 frame per sec.
