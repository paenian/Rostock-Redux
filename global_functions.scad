include <mcad/nuts_and_bolts.scad>
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

module rod_pressure_mount(size=10, wall=4, height=60, top=true){
	outer = (size/2 + wall)*2/sqrt(3);
	inner = size/2;
	e = .01;
	numTabs = round(height/20);
	tabSep = wall;
	tabLength = (height-tabSep*2)/numTabs-tabSep;

	gap = tabGap;
		
	union(){
		//hex post
		difference(){
			//outer
			cylinder(r1=outer, r2=outer, h=height, $fn=6);

			//inner
			if(top)
				translate([0,0,-wall])
			cylinder(r1=inner, r2=inner, h=height+e, $fn=32);		

			//cut out slot for the pressure mount tabs
			for(j=[0:1]){
				rotate([0,0,120*j-60])
				for(i=[0:numTabs-1]){
					translate([-tabWidth/2,1,tabSep+(tabLength+tabSep)*i])
					cube([tabWidth,size,tabLength]);
				}
			}
		}
		
		//pressure tabs
		for(j=[0:1]){
			rotate([0,0,120*j-60])
	
			intersection(){
				cylinder(r1=outer, r2=outer, h=height, $fn=6);
				for(i=[0:numTabs-1]){
					translate([0,0,tabSep+(tabLength+tabSep)*i-gap])
					difference(){
						translate([-tabWidth/2+gap,0,0])
						cube([tabWidth-2*gap,size, tabLength]);

						translate([0,0,-e])	
						cylinder(r1=inner, r2=inner-gap, h=tabLength+2*e, $fn=32);
					}
				}
			}
		}
	}
}
rod_pressure_mount();

module rod_bolt_mount(size=10, wall=4, height=20, clamp=0, bottom=false){
	outer = (size/2 + wall)*2/sqrt(3);
	e = .01;
	tabOuter = METRIC_NUT_AC_WIDTHS[clamp]+2;
	nutThickness = METRIC_NUT_THICKNESS[clamp];
	numBolts = round(height/15);
	
	union(){
		//hex hole
		difference(){
			//outer
			cylinder(r1=outer, r2=outer, h=height, $fn=6);
			translate([0,0,-.5])

			//inner
			cylinder(r1=size/2, r2=size/2, h=height+1, $fn=32);

			//slot
			if(clamp > 0){
				rotate([0,0,90])
				translate([0,0,-.5])
				cube([size*2,outer/4,height+1]);
			}
		}

		//clamp with an m3 bolt
		if(clamp > 0){
			difference(){
				union(){
					//nut wall
					translate([0,outer*sqrt(3)/2-e,0])
					cube([outer/2,tabOuter,height]);

					//bolt wall
					translate([-outer/2,outer*sqrt(3)/2-e,0])
					cube([outer/4,tabOuter,height]);
				}
				for(i=[0:numBolts-1]){
					//bolt hole
					translate([-outer,(outer*sqrt(3)+tabOuter)/2,((height-tabOuter)/(numBolts-1))*i+tabOuter/2])
					rotate([0,90,0])
					boltHole(clamp, "mm", outer*2, boltSlop, proj=-1, $fn=12);

					//nut hole
					translate([outer/2-nutThickness+e,(outer*sqrt(3)+tabOuter)/2,((height-tabOuter)/(numBolts-1))*i+tabOuter/2])
					rotate([0,90,0])
					rotate([0,0,180/6])
					nutHole(clamp, "mm", nutSlop, proj=-1);
				}
			}
		}
	}
}

module hex_nutmount(size = 3, wall = 3, height = 20, screw=false){
	e = .01;
	nutRad =  METRIC_NUT_AC_WIDTHS[size]/2+nutSlop;
	boltDia = COURSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS[size]+boltSlop;
	outer = (nutRad + wall)*2/sqrt(3);
	nutThickness = METRIC_NUT_THICKNESS[size];

	union(){
		//hex hole
		difference(){
			//outer
			cylinder(r1=outer, r2=outer, h=height, $fn=6);

			//inner bolt hole
			translate([0,0,-.5])
			cylinder(r1=boltDia/2, r2=boltDia/2, h=height+1, $fn=18);
			
			if(screw){
				//tapered screw support
				translate([0,0,nutThickness])
				cylinder(r1=boltDia/2, r2=boltDia/2+nutThickness, h=nutThickness+e, $fn=18);
				translate([0,0,nutThickness*2])
				cylinder(r1=boltDia/2+nutThickness, r2=boltDia/2+nutThickness, h=height+e, $fn=18);

			}else{
				//inner nut trap
				translate([0,0,nutThickness])
				cylinder(r1=nutRad, r2=nutRad, h=height+1, $fn=6);
			}
		}
	}
}

//hex_nutmount(4, 4, 10, false);

//teardrop(5,10);
