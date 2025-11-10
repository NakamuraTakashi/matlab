#!/bin/bash
#
#name='temp'
name='flt'
##name='Hs'
#name='bstrcwmax'
#name='DIN_01'
#name='DIN_02'
#name='mud_01'
#name='mud_02'
#name='PO4_01'
#name='PO4_02'
#name='PhyNTot_01'
#name='PhyNTot_02'
#name='seagrass_SgNBm01_01'
#name='seagrass_SgNBm01_02'
#name='seagrass_SgPBm01_01'
#name='seagrass_SgPBm01_02'
#name='PON03_01'
#name='PON03_02'

img_dir='figs_png_Kushimoto_flt_v2'

tag='Kushimoto_srf_v2'

printf "file '%s'\n" ${img_dir}/${name}*.png > imglist.txt

#ffmpeg -r:v 40 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -an anim/${tag}_${name}.mp4
#ffmpeg -r:v 30 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
ffmpeg -r:v 15 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
#
# -r:v 30 => 30 frame per sec.
