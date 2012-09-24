include <configuration.scad>
include <lmxuu_mount.scad>

translate([0,0,-.1])
%cube([200,200,0.2], center=true);


width = 76;
height = 24;

offset = 25;
cutout = 13;
middle = 2*offset - width/2;


//stock rostock - credit jroscholl - only minor edits
module parallel_joints(reinforced = 16) {
  translate([0,0,4])
  difference() {
    union() {
      intersection() {
        cube([width, 20, 8], center=true);
        rotate([0, 90, 0]) cylinder(r=5, h=width, center=true);
      }
      intersection() {
        translate([0, 18, 4]) rotate([45, 0, 0])
          cube([width, reinforced, reinforced], center=true);
        translate([0, 0, 20]) cube([width, 35, 40], center=true);
      }
      translate([0, 8, 0]) cube([width, 16, 8], center=true);
    }
    rotate([0, 90, 0]) cylinder(r=1.55, h=80, center=true, $fn=12);

    for (x = [-offset, offset]) {
      translate([x, 5.5, 0])
        cylinder(r=cutout/2, h=100, center=true, $fn=24);
      translate([x, -4.5, 0])
        cube([cutout, 20, 100], center=true);
      translate([x, 0, 0]) rotate([0, 90, 0]) rotate([0, 0, 30])
        cylinder(r=3.3, h=17, center=true, $fn=6);
    }
    translate([0, 2, 0]) cylinder(r=middle, h=100, center=true);
    translate([0, -8, 0]) cube([2*middle, 20, 100], center=true);
  }
}

//this'll be updated later, or rather, we'll see how it works with synchromesh
module belt_mount() {
  difference() {
    union() {
      difference() {
        translate([8, 2, 0]) cube([4, 13, height], center=true);
        for (z = [-3.5, 3.5])
          translate([8, 5, z])
            cube([5, 13, 3], center=true);
      }
      for (y = [1.5, 5, 8.5]) {
        translate([8, y, 0]) cube([4, 1.2, height], center=true);
      }
    }
  }
}

module carriage(){
	difference(){
		union(){
			for(i=[0:1]){
				mirror([i,0,0])
				translate([rodSeparation/2,offset,0])
				rotate([0,0,180])
				lmxuu_mount();
			}

			translate([0,20+wall/2,height/2])
			belt_mount();

			translate([0,18-wall/2,lm_height/2+wall])
			cube([rodSeparation-lm_dia+0.1,wall,lm_height+wall*2],center=true);
			difference(){
				parallel_joints(16,rodSeparation+lm_dia+wall+wall);

				for(i=[0:1]){
					mirror([i,0,0])
					translate([rodSeparation/2,offset,0])
					cylinder(r=lm_dia/2+.1, h=lm_height+wall*2);
				}
			}
		}

		for(i=[0:1]){
			mirror([i,0,0]){
				translate([(rodSeparation-lm_dia-3)/2-wall,16,lm_height/2+wall])
				rotate([90,0,0])
				cylinder(r=2.5, h=height, center=true, $fn=16);
	
				translate([(rodSeparation+lm_dia+3)/2+wall,16,lm_height/2+wall])
				rotate([90,0,0])
				cylinder(r=2.5, h=height, center=true, $fn=16);
			}
		}
	}
}

carriage();

