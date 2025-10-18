#!/bin/bash
#
name=''

#img_dir='figs_png_S1srf_25h_ave_flow_2022'
#img_dir='figs_png_S2srf_25h_ave_flow_2022'
#img_dir='figs_png_S3btm_25h_ave_flow_2022'
#img_dir='figs_png_S3srf_25h_ave_flow_2022'
#img_dir='figs_png_S3prof_2022'
#img_dir='figs_png_S3btm_2022'
#img_dir='figs_png_S3srf_2022'
img_dir='figs_png_S3btm_25h_ave_flow_noaqdrag'
#img_dir='figs_png_SZ3noaqdrag_srf'

#tag='S1srf_25h_ave_flow_2022'
#tag='S2srf_25h_ave_flow_2022'
#tag='S3btm_25h_ave_flow_2022'
#tag='S3srf_25h_ave_flow_2022'
#tag='S3prof_temp_2022'
#tag='S3btm_temp_2022'
#tag='S3srf_temp_2022'
tag='S3btm_noaqdrag_15h_ave_flow_2023'
#tag='S3srf_noaqdrag_2023'

printf "file '%s'\n" ${img_dir}/${name}*.png > imglist.txt

#ffmpeg -r:v 30 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
ffmpeg -r:v 20 -f concat -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4
#
# -r:v 30 => 30 frame per sec.
