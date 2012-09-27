include <configuration.scad>

boltRad = (boltSize+boltSlop)/2;

//limits - it will fit in this box :-)
//translate([-jointOuter/2,-jointInner/2,0])
//cube([jointOuter, jointInner, jointHeight]);

module stumpy(rad = 6, length = 5) {
  rotate([0, 90, 0]) rotate([0, 0, 30]) intersection() {
    cylinder(r=rad, h=length, center=true, $fn=6);
    union(){
      for(i=[0:1]){
        mirror([0,0,i])
        translate([0,0,length/2-rad])
        sphere(r=rad+1, $fn=24);
      }
    }
  }
}

module middle() {
  difference() {
    union() {
      stumpy(jointInner/2, jointOuter);
      rotate([0, 0, 90]) stumpy(jointInner/2, jointInner);
    }
    rotate([90, 0, 0]) cylinder(r=boltRad, h=30, center=true, $fn=12);
    rotate([0, 90, 0]) cylinder(r=boltRad, h=30, center=true, $fn=12);
  }
}

translate([0, 0, jointHeight/2]) middle();