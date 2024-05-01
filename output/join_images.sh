#!/bin/bash
#

# bash join_images.sh output figs_png_0003 figs_png_0005 figs_png_0101 figs_png_0104
# bash join_images.sh output figs_png_0205 figs_png_0224 figs_png_0222
# bash join_images.sh output figs_png_0054 figs_png_0055 figs_png_0090

# output_dir=$1
# img_dir1=$2
# img_dir2=$3

# output_dir=$1
# img_dir1=$2
# img_dir2=$3
# img_dir3=$4

# output_dir=$1
# img_dir1=$2
# img_dir2=$3
# img_dir3=$4
# img_dir4=$5










# output_dir='figs_png_sediment_SOM'
# img_dir1='figs_png_0091'
# img_dir2='figs_png_0092'
# img_dir3='figs_png_0093'

# output_dir='figs_png_seagrass'
# img_dir1='figs_png_0205'
# img_dir2='figs_png_0224'
# img_dir3='figs_png_0222'

output_dir='figs_png_sediment_OCN'
img_dir1='figs_png_0054'
img_dir2='figs_png_0055'
img_dir3='figs_png_0062'

# output_dir='figs_png_ocean_physical'
# img_dir1='figs_png_0001'
# img_dir2='figs_png_0002'
# img_dir3='figs_png_0004'
# img_dir4='figs_png_0008'

# output_dir='figs_png_ocean_CHEMs'
# img_dir1='figs_png_0003'
# img_dir2='figs_png_0005'
# img_dir3='figs_png_0026'
# img_dir4='figs_png_0028'
# img_dir5='figs_png_0029'

# output_dir='figs_png_sediment_CHEMs'
# img_dir1='figs_png_0054'
# img_dir2='figs_png_0055'
# img_dir3='figs_png_0062'
# img_dir4='figs_png_0063'
# img_dir5='figs_png_0064'

# output_dir='figs_png_ocean_DOM_POM'
# img_dir1='figs_png_0401'
# img_dir2='figs_png_0402'
# img_dir3='figs_png_0403'
# img_dir4='figs_png_0404'
# img_dir5='figs_png_0405'
# img_dir6='figs_png_0406'

# output_dir='figs_png_ocean_CHEMs_plankton'
# img_dir1='figs_png_0003'
# img_dir2='figs_png_0005'
# img_dir3='figs_png_0027'
# img_dir4='figs_png_0029'
# img_dir5='figs_png_0410'
# img_dir6='figs_png_0411'







# case ${img_dir} in
#   'figs_png_0001')
#     name='Temperature'
#     ;;
#   'figs_png_0002')
#     name='Salinity'
#     ;;
#   'figs_png_0003')
#     name='DIC'
#     ;;
#   'figs_png_0004')
#     name='TA'
#     ;;
#   'figs_png_0005')
#     name='DO'
#     ;;
#   'figs_png_0006')
#     name='delta13C_DIC'
#     ;;
#   'figs_png_0007')
#     name='Hs'
#     ;;
#   'figs_png_0008')
#     name='pH'
#     ;;
#   'figs_png_0009')
#     name='Omega_'
#     ;;
#   'figs_png_0010')
#     name='pCO2'
#     ;;
#   'figs_png_0011')
#     name='SS'
#     ;;
#   'figs_png_0012')
#     name='Coral_Pg'
#     ;;
#   'figs_png_0013')
#     name='Coral_Pn'
#     ;;
#   'figs_png_0014')
#     name='Coral_R'
#     ;;
#   'figs_png_0015')
#     name='Coral_G'
#     ;;
#   'figs_png_0016')
#     name='Coral_org-C'
#     ;;
#   'figs_png_0017')
#     name='Coral_delta13C_org-C'
#     ;;
#   'figs_png_0018')
#     name='Sediment_thickness'
#     ;;
#   'figs_png_0019')
#     name='Coral1_zoox_density'
#     ;;
#   'figs_png_0020')
#     name='Coral_growth_rate'
#     ;;
#   'figs_png_0021')
#     name='Coral_mortality'
#     ;;
#   'figs_png_0022')
#     name='Sea_surface_elevation'
#     ;;
#   'figs_png_0023')
#     name='Phytoplankton1'
#     ;;
#   'figs_png_0024')
#     name='Phytoplankton2'
#     ;;
#   'figs_png_0025')
#     name='Phytoplankton'
#     ;;
#   'figs_png_0026')
#     name='NO3'
#     ;;
#   'figs_png_0027')
#     name='NO2'
#     ;;
#   'figs_png_0028')
#     name='NH4'
#     ;;
#   'figs_png_0029')
#     name='PO4'
#     ;;
#   'figs_png_0030')
#     name='SS_200um'
#     ;;
#   'figs_png_0031')
#     name='Chl_a'
#     ;;
#   'figs_png_0032')
#     name='Chl_a'
#     ;;
#   'figs_png_0033')
#     name='Coral2_zoox_density'
#     ;;
#   'figs_png_0034')
#     name='Coral2_zoox_density'
#     ;;
#   'figs_png_0035')
#     name='DOC'
#     ;;
#   'figs_png_0036')
#     name='Coral_mortality_rate'
#     ;;
#   'figs_png_0051')
#     name='Sediment_Temperature'
#     ;;
#   'figs_png_0052')
#     name='Sediment_Salinity'
#     ;;
#   'figs_png_0053')
#     name='Sediment_TA'
#     ;;
#   'figs_png_0054')
#     name='Sediment_DO'
#     ;;
#   'figs_png_0055')
#     name='Sediment_DIC'
#     ;;
#   'figs_png_0056')
#     name='Sediment_N2'
#     ;;
#   'figs_png_0057')
#     name='Sediment_DOC_Labile'
#     ;;
#   'figs_png_0058')
#     name='Sediment_DOC_Refractory'
#     ;;
#   'figs_png_0059')
#     name='Sediment_POC_Labile'
#     ;;
#   'figs_png_0060')
#     name='Sediment_POC_Refractory'
#     ;;
#   'figs_png_0061')
#     name='Sediment_POC_Non-degradable'
#     ;;
#   'figs_png_0062')
#     name='Sediment_NO3'
#     ;;
#   'figs_png_0063')
#     name='Sediment_NH4'
#     ;;
#   'figs_png_0064')
#     name='Sediment_PO4'
#     ;;
#   'figs_png_0065')
#     name='Sediment_DON_Labile'
#     ;;
#   'figs_png_0066')
#     name='Sediment_DON_Refractory'
#     ;;
#   'figs_png_0067')
#     name='Sediment_PON_Labile'
#     ;;
#   'figs_png_0068')
#     name='Sediment_PON_Refractory'
#     ;;
#   'figs_png_0069')
#     name='Sediment_PON_Non_degradable'
#     ;;
#   'figs_png_0070')
#     name='Sediment_DOP_Labile'
#     ;;
#   'figs_png_0071')
#     name='Sediment_DOP_Refractory'
#     ;;
#   'figs_png_0072')
#     name='Sediment_POP_Labile'
#     ;;
#   'figs_png_0073')
#     name='Sediment_POP_Refractory'
#     ;;
#   'figs_png_0074')
#     name='Sediment_POP_Non_degradable'
#     ;;
#   'figs_png_0075')
#     name='Sediment_Mn2'
#     ;;
#   'figs_png_0076')
#     name='Sediment_MnO2'
#     ;;
#   'figs_png_0077')
#     name='Sediment_Fe2'
#     ;;
#   'figs_png_0078')
#     name='Sediment_FeS'
#     ;;
#   'figs_png_0079')
#     name='Sediment_FeS2'
#     ;;
#   'figs_png_0080')
#     name='Sediment_FeOOH'
#     ;;
#   'figs_png_0081')
#     name='Sediment_FeOOH_PO4'
#     ;;
#   'figs_png_0082')
#     name='Sediment_H2S'
#     ;;
#   'figs_png_0083')
#     name='Sediment_SO4'
#     ;;
#   'figs_png_0084')
#     name='Sediment_S0'
#     ;;  
#   'figs_png_1001')
#     name='Air_temperature'
#     ;;
#   'figs_png_1002')
#     name='Air_pressure'
#     ;;
#   'figs_png_1003')
#     name='Humidity'
#     ;;
#   'figs_png_1004')
#     name='Rain_fall_rate'
#     ;;
#   'figs_png_1005')
#     name='Cloud_fraction'
#     ;;
#   *)
#     printf "\nfolder not found\n"
#     exit
#     ;;
# esac



mkdir ${output_dir}

cd ${img_dir1}

rm cropped_time.png
rm cropped_1.png
rm cropped_2.png
rm cropped_3.png
rm cropped_4.png
rm cropped_5.png
rm cropped_6.png


crop_position=100
echo "$crop_position"

# For each file "f" in A
for f in *.png; do

    printf "Joining $f\n"

    convert "$f" -gravity South -crop 0x${crop_position}+0+0 cropped_time.png

    # 1st pic
    height=`convert "$f" -ping -format "%h" info:`
    cropped_height=$(($height-$crop_position))
    convert "$f" -gravity North -crop 0x${cropped_height}+0+0 cropped_1.png

    # 2nd pic
    height=`convert ../${img_dir2}/"$f" -ping -format "%h" info:`
    cropped_height=$(($height-$crop_position))
    convert ../${img_dir2}/"$f" -gravity North -crop 0x${cropped_height}+0+0 cropped_2.png

    # 3rd pic
    height=`convert ../${img_dir3}/"$f" -ping -format "%h" info:`
    cropped_height=$(($height-$crop_position))
    convert ../${img_dir3}/"$f" -gravity North -crop 0x${cropped_height}+0+0 cropped_3.png

    # # 4th pic
    # height=`convert ../${img_dir4}/"$f" -ping -format "%h" info:`
    # cropped_height=$(($height-$crop_position))
    # convert ../${img_dir4}/"$f" -gravity North -crop 0x${cropped_height}+0+0 cropped_4.png

    # # 5th pic
    # height=`convert ../${img_dir5}/"$f" -ping -format "%h" info:`
    # cropped_height=$(($height-$crop_position))
    # convert ../${img_dir5}/"$f" -gravity North -crop 0x${cropped_height}+0+0 cropped_5.png

    # # 6th pic
    # height=`convert ../${img_dir6}/"$f" -ping -format "%h" info:`
    # cropped_height=$(($height-$crop_position))
    # convert ../${img_dir6}/"$f" -gravity North -crop 0x${cropped_height}+0+0 cropped_6.png


    # Append corresponding file from img_dir2 and write to output_dir

    # convert -gravity South \( cropped_1.png cropped_2.png +append \) cropped_time.png -append ../${output_dir}/"$f"
    convert -gravity South \( cropped_1.png cropped_2.png cropped_3.png +append \) cropped_time.png -append ../${output_dir}/"$f"
    # convert -gravity South \( cropped_1.png cropped_2.png cropped_3.png cropped_4.png +append \) cropped_time.png -append ../${output_dir}/"$f"
    # convert -gravity South \( cropped_1.png cropped_2.png cropped_3.png cropped_4.png cropped_5.png +append \) cropped_time.png -append ../${output_dir}/"$f"
    # convert -gravity South \( cropped_1.png cropped_2.png cropped_3.png cropped_4.png cropped_5.png cropped_6.png +append \) cropped_time.png -append ../${output_dir}/"$f"

done

rm cropped_time.png
rm cropped_1.png
rm cropped_2.png
rm cropped_3.png
rm cropped_4.png
rm cropped_5.png
rm cropped_6.png

cd ../
