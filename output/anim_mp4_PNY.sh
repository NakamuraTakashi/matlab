#!/bin/bash
#
#name='wave'
#name='temp'
#name='mud_01'
name='Hs'


#img_dir='figs_png_panay0_wave'
#img_dir='figs_png_PNY0srf'
#img_dir='figs_png_BCY3srf'
#img_dir='figs_png_PNY1srf'
img_dir='figs_png_TGLsrf'
#img_dir='figs_png_TGLbtm'

#tag='Panay0'
#tag='Panay0_srf'
#tag='Panay1_srf'
tag='Tangalan_srf'
#tag='Tangalan_btm'

printf "file '%s'\n" ${img_dir}/${name}*.png > imglist.txt

#ffmpeg -r:v 30 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
ffmpeg -r:v 20 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
#
# -r:v 30 => 30 frame per sec.
