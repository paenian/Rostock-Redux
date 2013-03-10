holeHeight  = 14;
holeDia = 4.2;
holeRad = holeDia/2;

$fn=17;

%translate([0,0,-.1]) cube([100,100,0.2], center=true);

difference(){
	union(){
		translate([0,0,1]) minkowski(){
			rotate([0,90,0]) cylinder(r=1,h=.1);
			cube([4.8,8,holeHeight+holeRad]);
		}
		translate([1,0,4.8]) minkowski(){
			cylinder(r=1,h=.1);
			rotate([0,90,0]) cube([4.8,8,holeHeight+holeRad]);
		}

		translate([4.8,-1,4.8]) difference(){
			cube([6,10,6]);
			translate([6,0,6]) rotate([90,0,0]) cylinder(r=6.1,h=30,center=true, $fn=36);
		}
	}
	
	translate([0,4,holeHeight]) rotate([0,90,0]) cylinder(r=holeRad, h=50, center=true);
	translate([holeHeight,4,-1]) cylinder(r=holeRad, h=50, center=true);
}