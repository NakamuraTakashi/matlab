#!/bin/bash
#
#name='wave'
#name='temp'
#name='mud_01'
#name='Hs'
name='flt'

#img_dir='figs_png_Palau1_srf_2024'
#img_dir='figs_png_Palau2_srf'
#img_dir='figs_png_Palau2_srf_Zoom'
#img_dir='figs_png_Palau2_flt'
img_dir='figs_png_Palau2_flt_ROMSPath'

#tag='Palau1_2024_srf'
#tag='Palau2_202401_srf'
tag='Palau2_202401_flt_romspath'

printf "file '%s'\n" ${img_dir}/${name}*.png > imglist.txt

#ffmpeg -r:v 30 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
#ffmpeg -r:v 20 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
ffmpeg -r:v 10 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
#
# -r:v 30 => 30 frame per sec.
