#!/bin/bash
#
#name='Y2_MS1000_COTS'
name='Y2_MS1000_CBL'


#img_dir='figs_Y2_MS1000_COTS'
img_dir='figs_Y2_MS1000_CBL'

#
convert -layers optimize -delay 100 ${img_dir}/${name}*.png anim/${name}.gif
