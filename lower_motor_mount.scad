include <configuration.scad>
use <global_functions.scad>

//mount is printed upside-down to allow for nice wings.

//local variables
mrodDia = rodSize+rodSlop;
mrodRad = mrodDia/2;
mheight = 50;
mSlotCenter = (motorMin+motorMax)/2;
mSlotWidth = 3 +boltSlop;
mSlotLength = (motorMax - motorMin+mSlotWidth)*sqrt(2);
mnutHeight = nutRad/2;
mStiff = 3;
smoothRodOffset = 225;

module rodMountHoles(){
	for(i=[0:1]){
		translate([rodSeparation*i,0,0])
		mirror([1*i,0,0]){
			//rod holes
			cylinder(r=mrodRad, h=mheight,$fn=32);
		
			//bolt holes center
			translate([wall/2-1,-mrodDia/2-wall-wall-1,0])
			cylinder(r=boltRad, h=mheight, $fn=32);

			//bolt holes wing	
			translate([wall/2-1,-mrodDia/2-wall-wall,0])
			rotate([0,0,-120])
			translate([wingLength,0,0])
			cylinder(r=boltRad, h=mheight, $fn=32);
		}
	}
}

module rodMount(motor=true){
	union(){
		for(i=[0:1]){
			translate([rodSeparation*i,0,0])
			mirror([1*i,0,0]){
				//rod clamps
				//rotate([0,0,30])
				rod_pressure_mount(mrodDia, wall, mheight, clamp=boltSize);
	
				//platform mounts inner
				translate([wall/2-1,-mrodDia/2-wall-wall-1,0])
				#hex_nutmount(boltSize,boltSize-1,mnutHeight*3, false);

				//platform mounts wing	
				translate([wall/2-1,-mrodDia/2-wall-wall,0])
				rotate([0,0,-120])
				translate([wingLength,0,0])
				hex_nutmount(boltSize,boltSize-1,mnutHeight*3, false);
				
				//wing supports
				translate([0,-mrodDia/2-wall-wall,0])
				rotate([0,0,-120])
				translate([-wall,-nutRad-wall,0])
				difference(){	
					cube([wingLength+wall+wall, wall, mheight]);
					
					translate([wall,-.5,mheight])
					rotate([0,atan((mheight-mnutHeight*2)/(wingLength+wall)),0])	
					cube([wingLength*2,wall+1,mheight]);

					translate([wingLength+wall+mnutHeight,0,mheight])
					rotate([90,0,0])
					scale([1,(mheight-wall-mnutHeight)/wingLength,1])
					cylinder(h=wall*4, r=wingLength,center=true,$fn=63);
				}
			}
		}

		//motor mount plate
		difference(){
			union(){
				translate([0,-mrodDia/2-wall,0])
				cube([rodSeparation,wall, mheight]);

				//stiffeners
				for(i=[0:2]){
					translate([rodSeparation/2,-mrodDia/2,(mheight/2-mStiff/sqrt(2))*i+mStiff/sqrt(2)])
					rotate([0,90,0])
					rotate([0,0,45])
					cube([mStiff,mStiff,rodSeparation-mrodDia],center=true);
				}

				//support for the idler bolt
				if(motor==false){
					translate([rodSeparation/2,-mrodDia/2,mheight/2])
					rotate([90, 0, 0])
					{
						translate([0,0,wall-.01])
						difference(){
							//idler shaft hole
							cylinder(r1=m8NutDia+2, r2=m8NutRad, h=m8NutRad);

							translate([0,0,.02])
							cylinder(r=m8NutRad, h=m8NutRad, $fn=6);
						}
					}
				}
			}
		
			if(motor){
				//center hole
				translate([rodSeparation/2,-mrodDia/2,mheight/2])
				rotate([90, 0, 0])
				{
					//motor shaft hole
					cylinder(r=motorShaft, h=mheight, center=true);
	
					//mounting holes
					for(i=[0:3]){
						rotate([0,0,90*i]){
							translate([mSlotCenter, mSlotCenter,0])
							rotate([0, 0, -45])
							cube([mSlotWidth, mSlotLength, mheight], center=true);
						}
					}
				}
			}else{
				//center hole
				translate([rodSeparation/2,-mrodDia/2,mheight/2])
				rotate([90, 0, 0])
				{
					//idler shaft hole
					cylinder(r=m8Rad, h=mheight, center=true);
					
					//washer area
					translate([0,0,-wall/2-.005])
					cylinder(r=motorShaft, h=wall, center=true);
				}
			}
		}
	}
}

//make the hex plate
module hexPlate(motor=true){
	difference(){
		translate([0,0,wall/2])
		cylinder(r=(smoothRodOffset+wall+mrodRad)/cos(30), h=wall, center=true, $fn=6);
		echo("Hex flat-to-flat distance = ",(smoothRodOffset+wall+mrodRad)*2);
		echo("Hex point-to-point distance = ",(smoothRodOffset+wall+mrodRad)/cos(30)*2);
		cylinder(r=2.5,h=mheight,center=true,$fn=32);

		for(i=[0:2]){
			rotate([0,0,120*i]){
				translate([-rodSeparation/2,smoothRodOffset,-1])
				rodMountHoles();
			
				//cut out slot for drive cable
				translate([0,smoothRodOffset+wall+mrodRad,-1])
				scale([(rodSeparation-mrodDia)/2-wall,mrodDia+wall,1])
				cylinder(r=1, h=mheight, $fn=64);
			}
		}
	}
}

//place for printing
module printPlate(motor=true){
	translate([0,0,-.1])
	%cube([200,200,0.2], center=true);
	for(i=[0:2]){
		rotate([0,0,90])
		translate([-rodSeparation/2,45*i-wall*2,0])
		rodMount(motor);
	}
}

//rodMount(true);

//printPlate(false);
rotate([0,0,60])
hexPlate(true);
translate([0,(smoothRodOffset+wall+mrodRad)*2+.25*25.4,0])
hexPlate(false);

//rodMount(true);
//rodMountHoles();
