#!/bin/bash
#
#name='temp'
#name='Hs'
#name='vel'
name='mort27oC'
#name='Zoox_31oC'
#
anim_dir='figs_png_'${name}
echo ${anim_dir}
#cp -r figs_png ${anim_dir}
#rm figs_png/*.png
#
#echo 'copy fin.'
#
#convert -layers optimize -delay 10 figs_png_${name}/*.png anim/anim_${name}.gif
#convert -layers optimize -delay 2 figs_png_${name}/*.png -q 10 anim/anim_${name}.mp4
#ffmpeg -r 30 -i figs_png_${name}/t01_%04d.png -vcodec libx264 -pix_fmt yuv420p -r 60 anim/anim_${name}.mp4
#ffmpeg -r 30 -i figs_png_${name}/t01_%04d.png -pix_fmt yuv420p -r 60 -an anim/anim_${name}.mp4
ffmpeg -pattern_type glob -i "figs_png_${name}/t01_*.png" -q 5 -r 30 -an anim/anim_${name}.mp4

#-start_number
