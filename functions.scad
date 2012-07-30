include <nuts_and_bolts.scad>
include <configuration.scad>

module nut(d,h,horizontal=true){
	cornerdiameter =  (d / 2) / cos (180 / 6);
	cylinder(h = h, r = cornerdiameter, $fn = 6);
	if(horizontal){
		for(i = [1:6]){
			rotate([0,0,60*i]) translate([-cornerdiameter-0.2,0,0]) rotate([0,0,-45]) cube(size = [2,2,h]);
		}
	}
}

// Based on nophead research
module polyhole(d,h) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

module roundcorner(diameter){
	difference(){
		cube(size = [diameter,diameter,99], center = false);
		translate(v = [diameter, diameter, 0]) cylinder(h = 100, r=diameter, center=true);
	}
}

module teardrop (r=4.5,h=20)
{
	rotate([-270,0,90])
	linear_extrude(height=h)
	{
		circle(r=r, $fn = 25);
		polygon(points=[[0,0],[r*cos(30),r*sin(30)],[0.5*r,r],[-0.5*r,r],[-r*cos(30),r*sin(30)]],
				paths=[[0,1,2,3,4]]);
	}
}

module hex_mount(size=10, wall=4, height=20, clamp="none", bottom=false){
	outer = size/2 + wall;
	e = .01;
	tabOuter = METRIC_NUT_AC_WIDTHS[3]+2;
	nutThickness = METRIC_NUT_THICKNESS[3];
	
	union(){
		//hex hole
		difference(){
			//outer
			cylinder(r1=outer, r2=outer, h=height, $fn=6);
			translate([0,0,-.5])

			//inner
			cylinder(r1=size/2, r2=size/2, h=height+1, $fn=32);

			//slot
			if(clamp != "none"){
				rotate([0,0,90])
				translate([0,0,-.5])
				cube([size*2,outer/4,height+1]);
			}
		}

		//clamp with an m3 bolt
		if(clamp == "m3"){
			difference(){
				union(){
					//nut wall
					translate([0,outer*sqrt(3)/2-e,0])
					cube([outer/2,tabOuter,height]);

					//bolt wall
					translate([-outer/2,outer*sqrt(3)/2-e,0])
					cube([outer/4,tabOuter,height]);
				}
				//bolt hole
				translate([-height/2,outer*sqrt(3)/2+tabOuter/2,height/2])
				rotate([0,90,0])
				boltHole(3, "mm", outer*2, boltSlop, proj=-1, $fn=12);

				//nut hole
				translate([outer/2-nutThickness+e,outer*sqrt(3)/2+tabOuter/2,height/2])
				rotate([0,90,0])
				rotate([0,0,180/6])
				nutHole(3, "mm", nutSlop, proj=-1);
			}
		}
	}

}

rod_diameter = 10.5;
wall = 4;

//hex_mount(rod_diameter, wall, height=20, clamp="m3");
//teardrop(5,10);
