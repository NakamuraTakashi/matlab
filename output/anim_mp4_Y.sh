#!/bin/bash
#
name=''

#img_dir='figs_png_Y1srf2'
#img_dir='figs_png_Y2btm'
#img_dir='figs_png_Y2srf'
#img_dir='figs_png_Y3btm'
#img_dir='figs_png_Y3srf'
#img_dir='figs_png_Y3btm2015S'
#img_dir='figs_png_cbl2016_temp_btm'
img_dir='figs_png_cbl2016_temp_btm'

#tag='Y1srf'
#tag='Y2btm'
#tag='Y2srf'
#tag='Y3btm'
#tag='Y3srf'
tag='Y2_cbl_temp_2016'

printf "file '%s'\n" ${img_dir}/${name}*.png > imglist.txt

#ffmpeg -r:v 40 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -an anim/${tag}_${name}.mp4
#ffmpeg -r:v 30 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
ffmpeg -r:v 10 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
#
# -r:v 30 => 30 frame per sec.
