include <configuration.scad>

h = 8;
//r = h/2 / cos(30);
r=(tubeDia+rodSlop)/2;

module jaws() {
  difference() {
    union() {
      intersection () {
        rotate([90, 0, 0]) cylinder(r=5, h=14, center=true, $fn=24);
        translate([-4, 0, 0]) cube([10, 14, h], center=true);
      }
      intersection() {
        translate([10, 0, 0]) cube([26, 14, h], center=true);
        translate([10, 0, 0]) rotate([0, 90, 0]) rotate([0, 0, 0])
          cylinder(r1=10+2, r2=r+2, h=26, center=true, $fn=4);
      }
    }
    translate([-1.5, 0, 0]) cube([10, 8.4, 10], center=true);
    translate([3.5, 0, 0]) rotate([0, 0, 30])
      cylinder(r=4.2, h=10, center=true, $fn=6);
    translate([4, 0, 4]) rotate([0, 45, 0])
      rotate([0, 0, 30]) cylinder(r=4.2, h=8, center=true, $fn=6);
    translate([4, 0, -4]) rotate([0, -45, 0])
      rotate([0, 0, 30]) cylinder(r=4.2, h=8, center=true, $fn=6);
    rotate([90, 0, 0]) cylinder(r=1.55, h=40, center=true, $fn=12);
    translate([19, 0, 0]) rotate([0, 90, 0])
      rotate([0,0,0])
      cylinder(r=r, h=20, center=true, $fn=4);
  }
}

translate([0, 0, h/2]) jaws();