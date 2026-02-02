#!/bin/bash
#
#name=('temp' 'salt' 'NO3_01' 'DIN_01' 'PO4_01' 'PhyCtot_01' 'oyster_dw' 'DIC_01' 'TA' 'pH' 'Omega_arg')
name=('temp' 'flt')

img_dir='figs_png_Palau2_flt_v2/202306'
tag='Palau2_202306_v2'

for var in ${name[@]}
do
  printf "file '%s'\n" ${img_dir}/${var}*.png > imglist.txt

# ffmpeg -r:v 30 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
  ffmpeg -r:v 10 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${var}.mp4
#
# -r:v 30 => 30 frame per sec.
done
