include <configuration.scad>
use <joint.scad>

r=(tubeDia*sqrt(2)+rodSlop)/2;
h = r*2+2;

translate([0,0,-.1])
%cube([200,200,0.2], center=true);

//limits - it should fit in this box :-)
%translate([-r+.75,0,r+1])
rotate([0,90,0])
joint();

forkWidth = jointInner+jointSlop;
forkLength = 35;

e = 0.01;

module jaws() {
  translate([0, 0, h/2])
  difference() {
    union() {
      intersection () {
        rotate([90, 0, 0]) cylinder(r=h/2, h=forkWidth+wall, center=true, $fn=24);
        translate([-h/2+e, 0, 0]) cube([h, forkWidth+wall, h], center=true);
      }
      intersection() {
        translate([forkLength/2, 0, 0]) cube([forkLength, forkWidth+wall, h], center=true);
        translate([forkLength/2, 0, 0]) rotate([0, 90, 0])
          cylinder(r1=h+2, r2=r+2, h=forkLength, center=true, $fn=4);
      }
    }
    translate([-1.8, 0, 0]) cube([h, forkWidth, h+1], center=true);
    translate([4, 0, 0]) rotate([0, 0, 30])
      cylinder(r=forkWidth/2, h=forkLength, center=true, $fn=6);
    translate([4, 0, 6]) rotate([0, 45, 0])
      rotate([0, 0, 30]) cylinder(r=forkWidth/2, h=forkLength, center=true, $fn=6);
    translate([4, 0, -6]) rotate([0, -45, 0])
      rotate([0, 0, 30]) cylinder(r=forkWidth/2, h=forkLength, center=true, $fn=6);
    rotate([90, 0, 0]) cylinder(r=boltRad, h=40, center=true, $fn=12);
    translate([forkLength/2+10, 0, 0]) rotate([0, 90, 0])
      cylinder(r=r, h=forkLength, center=true, $fn=4);

    //set screw/glue hole
    translate([forkLength-10,0,0]) rotate([0, 0, 0])
      cylinder(r=m3BoltRad, h=forkLength, center=true, $fn=32);
  }
}

jaws();