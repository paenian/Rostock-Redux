//lm10uu specs
lm_dia = 20;
lm_height = 30;

rod_dia = 11;

wall = 2;

module lmxuu_mount(dia = lm_dia, height = lm_height){
	rad = lm_dia/2 + wall;
	height=lm_height+wall*2;
	e = 0.01;

	rotate([0,0,90])
	difference(){
		union(){
			//outer cylinder
			cylinder(r1=rad, r2=rad, h=height);
			translate([e,-rad,0])
			cube([rad, rad*2, height]);
		}
		
		//bearing hole
		translate([0,0,wall])
		cylinder(r=dia/2, h=lm_height);

		//leave just a slit top and bottom
		translate([0,0,-e])
		intersection(){	
			cylinder(r=dia/2, h=height+3*e);
			translate([-rad/2,0,height/2])
			cube([rad*2, (rad-e)*2, height+3*e],center=true);
		}

		//rod hole
		translate([0,0,-e])
		cylinder(r = rod_dia/2+.5, h = height+1);		

		//slot cut out
		translate([-(rad+2)/2, 0, (height+1)/2])
		cube([rad+2, rod_dia+wall*2, height+2],center=true);
	
		//angle the slot sides a bit
		translate([-rad+2, 0, (height+1)/2])
		rotate([0,0,45])
		cube([rad+2, rad+2, height+2],center=true);
		

		//cube front cutout
		translate([-rad,0,height/2])
		rotate([0,45,0])
		cube([rad*2+2*e,rad*2+2*e,rad*2+2*e], center=true);
	}
}

//lmxuu_mount(lm_dia, lm_height);