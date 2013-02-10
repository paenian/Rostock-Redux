

//just a stack of cylinders, to hold my bowden tube in place vertically.

$fn=36;
difference(){
	
	union(){
		cylinder(r=8, h=4);
		translate([0,0,3.99]) cylinder(r1=8, r2=6.5, h=1.01);
		translate([0,0,4.99]) cylinder(r=6.5, h=5.01);
		translate([0,0,9.99]) cylinder(r1=6.5, r2=4.25, h=1.01);
		translate([0,0,10.99]) cylinder(r=4.25, h=10);
	}

	translate([0,0,-.01])
	union(){
		cylinder(r=12.5/2, h=3, $fn=6);
		translate([0,0,2.99]) cylinder(r1=13/2, r2=4, h=1.01, $fn=6);
		translate([0,0,3.74]) cylinder(r=9/2, h=5);
		translate([0,0,8.73]) cylinder(r1=9/2, r2=2.1, h=1.01);
		translate([0,0,9.73]) cylinder(r=2.2, h=15);
	}

	translate([0,5, 10.01]) cube([3,10,30],center=true);
}