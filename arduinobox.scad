include <configuration.scad>

ard_x = 111;
ard_y = 62;
ard_z = 42;

clip_x = 20;
clip_z = 14.5+1;

poff_x = 18;
poff_y =6;
plat_x = 65;
plat_y = 40;
plat_z = 3;

air_r = 5;
air_x = 16+air_r;
air_z = 18+air_r;

fan_holes = 50;
fan_size = 60;
fan_w = 10;
%translate([ard_x/2, ard_y/2+wall, ard_z+wall+fan_w/2]) cube([fan_size,fan_size,fan_w], center=true);
echo("height", ard_z+wall+fan_w);


wall=3;
pcb=1.75;

$fn=32;

module arduinobox(){
	union(){
	    difference(){
	          cube([ard_x+wall*2, ard_y+wall*2+1, ard_z+wall*2+plat_z]);

		//hollow it out
		translate([wall, wall, wall]) cube([ard_x+.1, ard_y+1, ard_z+plat_z+wall+.1]);
		translate([wall*2, wall, wall+plat_z+pcb]) cube([ard_x+.1, ard_y+1, ard_z+plat_z+wall+.1]);

		//cutout for clips
		for(i=[0:1]) translate([0,i*(ard_y+wall*2),0]) mirror([0,i,0]){
		    translate([ard_x/2-wall/2-clip_x/2, -wall/2, wall*2]) cube([clip_x+wall, wall*2, clip_z+plat_z-wall]);
	    	}

		//some air holes
		for(i=[wall+air_x:air_r*3:ard_x-air_x]){
		    translate([i,-1,wall+plat_z+air_z]) rotate([-90,0,0]) cylinder(r=air_r, h=ard_x, $fn=6);
		}

		//zip tie holes to mount fan
		for(i=[ard_x/2-wall-fan_holes/2:fan_holes:ard_x]){
		    translate([i,-1,ard_z+wall+plat_z]) rotate([-90,0,0]) cube([5,2.5,ard_x]);
		}
	    }

	    //clips
	    for(i=[0:1]) translate([0,i*(ard_y+wall*2),0]) mirror([0,i,0]){
	       translate([ard_x/2, wall-.1, clip_z+plat_z]) rotate([45,0,0]) cube([clip_x, wall, wall], center=true);
	       translate([ard_x/2-clip_x/2, 0, 0]) cube([clip_x, wall, clip_z+plat_z]);
	    }

	    //platform
	    translate([poff_x+wall, poff_y+wall, wall-.01]) difference(){ 
		cube([plat_x, plat_y, plat_z]);
		translate([wall*2, wall*2, 0]) cube([plat_x-wall*4, plat_y-wall*4, plat_z+.01]);
	    }
	    
	     //mounting lugs
	    for(i=[0,1]) translate([i*(ard_x+wall*2),ard_y/2+wall, 0]) mirror([1*i,0,0]){
		difference() {
		    cylinder(r=boltDia*2, h=wall);
		    translate([-boltDia,0,-.1]) cylinder(r=boltRad, h=wall+1);
		}
	    }
	}
}

//rotate for printing
arduinobox();