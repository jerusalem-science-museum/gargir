#!/bin/bash

for i in $(seq 0.5 0.05 0.95)
do
	echo "Creating $i masks..."

	# Replace COLOR with 0.0 - 1.0 gray component ratio to get several masks
	# convert -size 87x142 -fx 'xx=i/w-.5; yy=j/h-.5; rr=xx*xx+yy*yy; (1-rr*4) * (COLOR * 2) * (1-rr*4 < 0.5) + COLOR * (1-rr*4 >= 0.5)' radial-gradient: first-mask-ellipse.png
	printf -v fx "xx=i/w-.5; yy=j/h-.5; rr=xx*xx+yy*yy; (1-rr*4) * (%q * 2) * (1-rr*4 < 0.5) + %q * (1-rr*4 >= 0.5)" "$i" "$i"
	convert -size 87x142 -fx "$fx" radial-gradient: first-mask-ellipse-${i}.png

	# Replace COLOR with 0.0 - 1.0 gray component ratio to get several masks
	# convert -size 85x121 -fx 'xx=i/w-.5; yy=j/h-.5; rr=xx*xx+yy*yy; (1-rr*4) * (COLOR * 2) * (1-rr*4 < 0.5) + COLOR * (1-rr*4 >= 0.5)' radial-gradient: second-mask-ellipse-COLOR.png
	convert -size 85x121 -fx "$fx" radial-gradient: second-mask-ellipse-${i}.png

	echo "Done!"
done
