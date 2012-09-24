rodSize  = 10;	//10 or 8; sets linear bearing size as well.
rodSeparation = 64;	//how far between rod centers
wall = 5;	//general wall thicknesses
boltSize = 4;	//3 for m3, 4 for m4
wingLength = rodSeparation;	//how long the wing supports are for the motor
				//and idler mounts.


idlerShaft = 4.5;

motorShaft = 12.5;
motorMin = 12.5;
motorMax = 16.5;

tabGap = 1;
tabWidth = 6;

rodSlop	 = 1.0;		//how much bigger to make smooth rod holes
boltSlop = 0.5;	//how much bigger to make bolt holes
nutSlop  = 0.6;	//how much bigger to make nut holes


m8Dia = 8+boltSlop;
m8Rad = m8Dia/2;
m8NutDia = 15+nutSlop;
m8NutRad = m8NutDia/2;

nutDia = 8.1+nutSlop;
nutRad = nutDia/2;
boltDia = 4+boltSlop;
boltRad = boltDia/2;
