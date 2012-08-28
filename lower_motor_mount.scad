include <mcad/nuts_and_bolts.scad>
include <configuration.scad>
use <global_functions.scad>

//mount is printed upside-down to allow for nice wings.

//local variables
mrodDia = rodSize;
mheight = 50;
mSlotCenter = (motorMin+motorMax)/2;
mSlotWidth = COURSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS[3]+boltSlop;
mSlotLength = (motorMax - motorMin+mSlotWidth)*sqrt(2);
mnutHeight = METRIC_NUT_THICKNESS[boltSize]+nutSlop;
nutRad =  METRIC_NUT_AC_WIDTHS[boltSize]/2+nutSlop;

module rodMount(motor=true){
	union(){
		for(i=[0:1]){
			translate([rodSeparation*i,0,0])
			mirror([1*i,0,0]){
				//rod clamps
				//rotate([0,0,30])
				rod_pressure_mount(10, wall, mheight, clamp=boltSize);
	
				//platform mounts inner
				translate([wall/2-1,-mrodDia/2-wall-wall-1,0])
				//rotate([0,0,60])
				//translate([-2,0,0])
				hex_nutmount(boltSize,boltSize-1,mnutHeight*3, true);

				//platform mounts wing	
				translate([wall/2-1,-mrodDia/2-wall-wall,0])
				rotate([0,0,-120])
				translate([wingLength,0,0])
				hex_nutmount(boltSize,boltSize-1,mnutHeight*3, true);
				
				//wing supports
				translate([0,-mrodDia/2-wall-wall,0])
				rotate([0,0,-120])
				translate([-wall,-nutRad-wall,0])
				difference(){	
					cube([wingLength+wall+wall, wall, mheight]);
					
					translate([wall,-.5,mheight])
					rotate([0,atan((mheight-mnutHeight*2)/(wingLength+wall)),0])	
					cube([wingLength*2,wall+1,mheight]);
				}
			}
		}

		//motor mount plate
		difference(){
			translate([0,-mrodDia/2-wall,0])
			cube([rodSeparation,wall, mheight]);
		
			//center hole
			translate([rodSeparation/2,-wall*2,mheight/2])
			rotate([90, 0, 0])
			{
				//motor shaft hole
				cylinder(r=motorShaft, h=mheight, center=true);
				translate([0, sin(45)*motorShaft,0])
				rotate([0, 0, 45])
				cube([motorShaft, motorShaft, motorShaft], center=true);
	
				//mounting holes
				for(i=[0:3]){
					rotate([0,0,90*i]){
						translate([mSlotCenter, mSlotCenter,0])
						rotate([0, 0, -45])
						cube([mSlotWidth, mSlotLength, mheight], center=true);
					}
				}
			}
		}
	}
}

//place on hex mount
module hexPlate(){
	translate([0,0,-.1])
	%cylinder(r=200, h=0.2, center=true, $fn=6);
	for(i=[0:2]){
		rotate([0,0,120*i])
		translate([-rodSeparation/2,178,0])
		rodMount(true);
	}
}

//place for printing
module printPlate(){
	translate([0,0,-.1])
	%cube([200,200,0.2], center=true);
	for(i=[0:2]){
		translate([-rodSeparation/2,40*i-wall,0])
		rodMount(true);
	}
}

printPlate();
//hexPlate();
