#!/bin/bash
#
#

name=$1
figs_dir_0='figs_png_'${name}

output_fig_dir='joined'

FILES=($figs_dir_0/*)


convert ${FILES[0]} -crop 936x2486+180+218 cropped_0.png
convert ${FILES[1]} -crop 936x2486+180+218 cropped_1.png
convert ${FILES[2]} -crop 936x2486+180+218 cropped_2.png
convert ${FILES[3]} -crop 936x2486+180+218 cropped_3.png
convert ${FILES[4]} -crop 936x2486+180+218 cropped_4.png
convert ${FILES[5]} -crop 936x2486+180+218 cropped_5.png
convert ${FILES[6]} -crop 936x2486+180+218 cropped_6.png
convert ${FILES[7]} -crop 936x2486+180+218 cropped_7.png
convert ${FILES[8]} -crop 936x2486+180+218 cropped_8.png
convert ${FILES[9]} -crop 936x2486+180+218 cropped_9.png
convert ${FILES[10]} -crop 936x2486+180+218 cropped_10.png
convert ${FILES[11]} -crop 936x2486+180+218 cropped_11.png

# convert \( \( cropped_0.png cropped_1.png cropped_2.png  -gravity South +append \) \( cropped_3.png cropped_4.png cropped_5.png  -gravity South +append \) -append \) cropped_title.png -gravity Center +append $output_fig_dir/${name}_'paneled.png'
convert \( \( cropped_0.png cropped_1.png cropped_2.png cropped_3.png cropped_4.png cropped_5.png -gravity South +append \) \( cropped_6.png cropped_7.png cropped_8.png cropped_9.png cropped_10.png cropped_11.png  -gravity South +append \) -append \)  $output_fig_dir/${name}_'paneled.png'
