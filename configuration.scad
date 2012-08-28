rodSize  = 10;	//10 or 8; sets linear bearing size as well.
rodSeparation = 80;	//how far between rod centers
wall = 5;	//general wall thicknesses
boltSize = 4;	//3 for m3, 4 for m4
wingLength = rodSeparation;	//how long the wing supports are for the motor
				//and idler mounts.

motorShaft = 12.5;
motorMin = 12.5;
motorMax = 16.5;

tabGap = 1;
tabWidth = 6;

rodSlop	 = 0.5;	//how much bigger to make smooth rod holes
boltSlop = 0.25;	//how much bigger to make bolt holes
nutSlop  = 0.25;	//how much bigger to make nut holes

boltDia = COURSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS[boltSize]+boltSlop;
