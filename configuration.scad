rodSize  = 10;	//10 or 8; sets linear bearing size as well.
rodSeparation = 64;	//how far between rod centers
wall = 5;	//general wall thicknesses
boltSize = 4;	//3 for m3, 4 for m4
wingLength = rodSeparation;	//how long the wing supports are for the motor
				//and idler mounts.

//generic slop specs
rodSlop  = 1.0;	//how much bigger to make smooth rod holes
boltSlop = 0.5;	//how much bigger to make bolt holes
nutSlop  = 0.6;	//how much bigger to make nut holes
jointSlop = .5;	//how much space around the joint
			//the joint itself isn't slopped, the parts that join to it are.


//lm10uu specs
lm_dia = 20;
lm_height = 30;


//joint specs
tubeDia = 6;
jointHeight=boltSize*2;
jointInner=jointHeight / cos(30);
jointOuter=jointInner+boltSize+boltSlop;


//motor/idler specs
idlerShaft = 4.5;
motorShaft = 12.5;
motorMin = 12.5;
motorMax = 16.5;

tabGap = 1;
tabWidth = 6;


m8Dia = 8+boltSlop;
m8Rad = m8Dia/2;
m8NutDia = 15+nutSlop;
m8NutRad = m8NutDia/2;

nutDia = 8.1+nutSlop;
nutRad = nutDia/2;
boltDia = 4+boltSlop;
boltRad = boltDia/2;

m3NutDia = 6.1+nutSlop;
m3NutRad = m3NutDia/2;
m3BoltDia = 3+boltSlop;
m3BoltRad = m3BoltDia/2;
