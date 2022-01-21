#!/bin/bash
#
#name='mud_01'
#name='NO3'
name='temp_2015'

img_dir='figs_png_Y3btm2015S'
tag='Y3'
#
convert -layers optimize -delay 10 ${img_dir}/${name}*.png anim/${tag}_${name}.gif
