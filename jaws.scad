include <configuration.scad>
use <joint.scad>

r=(tubeDia*sqrt(2)+rodSlop)/2;
h = r*2+wall/2;

translate([0,0,-.1])
%cube([200,200,0.2], center=true);



//limits - it should fit in this box :-)
%translate([-r,0,r+1])
rotate([0,90,0])
joint();

forkWidth = jointInner+jointSlop;
width = forkWidth+wall*2;
forkLength = forkWidth*4;
gap = h+wall;

%cube([forkLength,20,10]);
%cube([gap,30,10]);
echo("rod offset = ",gap);


e = 0.01;

module jaws() {
  translate([0, 0, h/2])
  difference() {
    union() {
      intersection () {
        rotate([90, 0, 0]) cylinder(r=h/2/cos(30), h=width, center=true, $fn=6);
        translate([-h/2+e, 0, 0]) cube([h, width, h], center=true);
      }
      intersection() {
        translate([forkLength/2, 0, 0]) cube([forkLength, width, h], center=true);
        translate([forkLength/2, 0, 0]) rotate([0, 90, 0]) rotate([0,0,22.5])
          cylinder(r1=width*cos(50)+e, r2=h/2, h=forkLength+7, center=true, $fn=8);
      }
    }
    cube([gap+e, forkWidth, h+1], center=true);
    translate([gap/2, 0, 0])
      cylinder(r=forkWidth/2, h=forkLength, center=true, $fn=8);
    translate([gap/2, 0, h/2]) rotate([0, 45, 0])
      cylinder(r=forkWidth/2, h=forkLength, center=true, $fn=8);
    translate([gap/2, 0, -h/2]) rotate([0, -45, 0])
      cylinder(r=forkWidth/2, h=forkLength, center=true, $fn=8);
    
    //bolt hole
    rotate([90, 0, 0]) cylinder(r=boltRad, h=width+2, center=true, $fn=12);
    rotate([90, 0, 0]) translate([0,0,width-nutHeight])
      cylinder(r=nutRad, h=width, center=true, $fn=6); //nut
    rotate([90, 0, 0]) translate([0,0,-width+nutHeight])
      cylinder(r=boltDia, h=width, center=true, $fn=12);//countersink bolt

    //rod
    translate([forkLength/2+gap, 0, 0]) rotate([0, 90, 0])
      cylinder(r=r, h=forkLength, center=true, $fn=4);

    translate([forkLength/2+gap, 20, 0]) rotate([0, 90, 0])
      %cylinder(r=r, h=forkLength, center=true, $fn=4);

    //set screw/glue hole
    translate([forkLength-10,0,0]) rotate([0, 0, 0])
      cylinder(r=m3BoltRad, h=forkLength, center=true, $fn=32);
 
    *for(i=[-1,1]){
      translate([forkLength-10,0,i*h/2])
      rotate([0,45,0])
      cube([3,forkLength,3],center=true);

      //break up the base so it doesn't delaminate
      translate([gap+sqrt(2)*wall,0,i*h/2])
      rotate([0,45,0])
      cube([3,forkLength,3],center=true);
    }
  }
}

jaws();