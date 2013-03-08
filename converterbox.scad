include <configuration.scad>

con_l = 65;
con_w = 48;
con_h = 28;

wall = 2.5;
gap = 1;

in_l = con_l + gap;
in_w = con_w + gap;
in_h = con_h + gap;

out_l = in_l+wall*2;
out_w = in_w+wall*2;
out_h = in_h+wall*2;

//connectors
wire_l = 7;
wire_w = 20;
wire_h = 12;
wire_h_offset = 7.5;

board_hole_w = 26;
board_hole_l = 58;
board_hole_l_offset = 3.5;

fan_holes = 40;
fan_center = 47;

$fn=36;

module converterbox(){
    difference(){
	union(){
	    difference(){
		translate([0,1,1]) minkowski(){
		    cube([out_l, out_w-2, out_h-2]);
		    rotate([0,90,0]) cylinder(r=1,h=.001);
		}
		//inside
		translate([wall,wall,wall]) cube([in_l+wall+1, in_w, in_h]);
	    }

	    //mounting lugs
	   translate([0,1,1]) minkowski(){
	       translate([0, -boltRad*3-wall, -wall]) cube([out_l, boltRad*3+wall*2-2, wall*2-1]);
	      rotate([0,90,0]) cylinder(r=1,h=.001);
	   }
	   translate([0,1,1]) minkowski(){
	       translate([0, out_w-wall, -wall]) cube([out_l, boltRad*3+wall*2-2, wall*2-1]);
	      rotate([0,90,0]) cylinder(r=1,h=.001);
	   }

	    //wire block
	    translate([0,out_w/2-wire_w/2-wall,wire_h_offset+wire_h]) cube([wire_l+wall,wire_w+wall*2,out_h - (wire_h_offset+wire_h+.1)]);
	}

	 //mounting lug holes
   	translate([boltRad+wall/2+1, -boltRad-wall, 0]) cylinder(r=boltRad, h=wall*3+1, center=true);
  	translate([boltRad+wall/2+1, out_w+boltRad+wall, 0]) cylinder(r=boltRad, h=wall*3+1, center=true);
	translate([out_l-boltDia-wall+boltRad+wall/2-1, -boltRad-wall, 0]) cylinder(r=boltRad, h=wall*3+1, center=true);
  	translate([out_l-boltDia-wall+boltRad+wall/2-1, out_w+boltRad+wall, 0]) cylinder(r=boltRad, h=wall*3+1, center=true);

	//wire cutout
	translate([-.01,out_w/2-wire_w/2,wire_h_offset]) cube([wire_l,wire_w,out_h]);

	//board mount holes
	translate([board_hole_l_offset+wall,out_w/2,0]){
	    for(i=[0,1]) mirror([0,i,0]) {
		translate([0,board_hole_w/2,0]) cylinder(r=1.75,h=20,center=true);
		translate([board_hole_l,board_hole_w/2,0]) cylinder(r=1.75,h=20,center=true);
	    }
	}

	//fan mount holes
	translate([out_l/2, out_w/2, out_h]){
	    cylinder(r=fan_center/2, h=wall*3, center=true);
	    for(i=[0:90:359]) rotate([0,0,i])
		translate([fan_holes/2, fan_holes/2,0]) cylinder(r=1.75, h=wall*3, center=true);
	}

	//side vents
	for(i=[13.5:15:out_w+5]){
		translate([i, out_w/2, 11]) rotate([90,30,0]) cylinder(r=7, h=out_w*2, center=true, $fn=6);
	}
    }

}

//rotate for printing
rotate([0,-90,0]) converterbox();