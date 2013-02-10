width=60;
height=12;
length=15;

fitting_rad=5;

screw_sep=50;

fil_facets = 18;

center_offset = 3.5;


difference(){
	union(){
		translate([height/2,length/2,height/2])
		cube([width+height, length, height], center=true);

		//mount block
		translate([width/2+height/2-.01,length/2,width/2+height-.01])
		cube([height, length, width], center=true);
	}

	//mount holes
	translate([width/2,length/2,width/2+height])
	for(j=[0,1]){
		mirror([0,0,j])
		translate([0,0,width/4])
		rotate([0,90,0]){
			cylinder(r=2.25, h=height, $fn=12);
			translate([0,0,-.1])
			cylinder(r1=height/2, r2=2.25,h=height/2, $fn=12);
		}
	}

	for(i=[0,1]) mirror([i,0,0]){
		//motor mount screw holes
		translate([screw_sep/2,length/2,4]) cylinder(r=2.2/cos(180/6), h=50,center=true, $fn=12);
	}
	
	translate([-center_offset,length/2,0]){
			//filament hole
			cylinder(r=1.8/cos(180/fil_facets),h=50,center=true, $fn=fil_facets);

			//conic guide
			translate([0,0,-.01])
			cylinder(r1=5, r2=1.8/cos(180/fil_facets), h=4, $fn=fil_facets);
	
			//bowden mount hole
			translate([0,0,5])
			cylinder(r=fitting_rad/cos(180/fil_facets), h=height, $fn=fil_facets);
		}
}
