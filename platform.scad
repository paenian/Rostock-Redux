include <configuration.scad>
use <carriage.scad>

h=platform_thickness;
armHeight = nutRad*2+wall/3;

outer_rad_bot = 32.8;
outer_rad_top = 31;
center_rad_bot = 23.5;
center_rad_top = 20;
bolt_ring_rad = 26;

echo(platform_thickness);

$fn = 64;

module platform() {
  difference() {
    union() {
      difference(){
        for (a = [0,120,240]) {
          rotate([0, 0, a]) {
            translate([0, -platform_hinge_offset, 0]) parallel_joints();
            // Close little triangle holes.
            translate([0, 28, 0]) rotate([0,0,-30]) cylinder(r=15, h=armHeight,$fn=3);
	//  translate([0, 39.8, h-6]) rotate([-12,0,0]) cube([wall/2,22,h/2], center=true);
          }
        }
        translate([0,0,h-.5]) cylinder(r1=22,r2=30.5+10,h=armHeight-h+.6,$fn=64);
      }
      difference(){
	union(){
		cylinder(r1=outer_rad_bot, r2=outer_rad_top, h=h);
		for (a = [0:2]) {
		    rotate([0,0,a*120]) translate([0, -bolt_ring_rad, h-.1]) rotate([0,0,180/16]) cylinder(r1=boltRad+2.8, r2=boltRad+2, h=5, $fn=16);
		}
	}
	for(a=[0:120:360]){
              rotate([0,0,a]) translate([0,outer_rad_top-7,h-(h-armHeight)/2+.75]) rotate([4,0,0]) cube([41,11,h-armHeight],center=true);
	}
    }
    }
    translate([0,0,-.1])
    cylinder(r1=center_rad_bot, r2=center_rad_top, h=h+1);
    for (a = [0:2]) {
      rotate([0,0,a*120]) {
        translate([0, -bolt_ring_rad, -.1]){
          translate([0,0,wall+.5]) cylinder(r=boltRad, h=h+2);
          cylinder(r=washRad, h=wall);
        }
      }
    }
  }
}

platform();
