include <configuration.scad>
use <carriage.scad>

h=platform_thickness;
armHeight = nutRad*2+wall/3;

outer_rad = 32;
center_rad = 20;
bolt_ring_rad = 26;

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
          }
        }
        translate([0,0,h-.5]) cylinder(r1=22,r2=30.5+10,h=armHeight-h+.6,$fn=64);
      }
      cylinder(r=outer_rad, h=h);
    }
    translate([0,0,-.1])
    cylinder(r=center_rad, h=h+12);
    for (a = [0:2]) {
      rotate(a*120) {
        translate([0, -bolt_ring_rad, -.1])
          cylinder(r=boltRad, h=h+1);
      }
    }
  }
}

platform();
