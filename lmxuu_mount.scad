//lm10uu specs
lm_dia = 16;
lm_height = 40;

rod_dia = 10;

wall = 2;

module lmxuu_mount(dia = lm_dia, height = lm_height){
	rad = lm_dia/2 + wall;
	height=lm_height+wall*2;
	e = 0.01;

	difference(){
		union(){
			//outer cylinder
			cylinder(r1=rad, r2=rad, h=height-wall-e);
			translate([e,-rad,0])
			cube([rad, rad*2, height]);
		}
		
		//bearing hole
		translate([0,0,wall])
		cylinder(r=dia/2, h=lm_height);

		//rod slot
		translate([0,0,-e]){
			cylinder(r = rod_dia/2, h = height+1);
			translate([-rad-2, -rod_dia/2, 0])
			cube([rad+2, rod_dia, height+1]);
		}

		//the top needs to be cut straight
		translate([-rad+rod_dia/2-3,-rad-.5,height-wall-e*2])
		cube([rad+3, rad*2+1, wall+e*3]);
		

		//top slot cut out extra
		translate([-rad-2, -rod_dia/2-wall, height/2])
		cube([rad+2, rod_dia+wall*2, height+1]);
	
		//angle the slot a bit
		translate([-rad+3.5, (-rad-2)/2-wall, height/2])
		rotate([0,0,45])
		cube([rad+2, rad+2, height+1]);
		

		//cube slot cutout
		translate([-rad,0,height/2])
		rotate([0,45,0])
		cube([rad*2+2*e,rad*2+2*e,rad*2+2*e], center=true);

		
		
	}
}

lmxuu_mount(lm_dia, lm_height);