include <configuration.scad>
use <lmxuu_mount.scad>
use <joint.scad>

translate([0,0,-.1])
%cube([200,200,0.2], center=true);


width = 76;
height = jointOuter+jointSlop+nutRad+wall*2;

offset = 25;
cutout = 13;
middle = 2*offset - width/2;

////////

armHeight = nutRad*2+wall/3;

//reworked.
module parallel_joints(support=0) {
  for(i=[0:1]){
    mirror([i,0,0])
    translate([-jointSeparation/2-mountWidth/2,0,0])
    difference(){
      //support arms
      union(){
        translate([0,-jointOffset,0])
        cube([mountWidth,jointOffset,armHeight]);

        translate([0,-jointOffset,nutRad])
        rotate([0,90,0])
        intersection(){
          cylinder(r=nutRad+wall/3,h=mountWidth,$fn=32);
          translate([-nutRad-wall/3,-nutRad-wall/2,0])
          cube([armHeight,armHeight,mountWidth]);
        }

        if(support==1){
          translate([0,-jointOffset,0])
          difference(){
            cube([mountWidth,jointOffset,mountWidth]);
            translate([-.1,0,mountWidth])
            rotate([0,90,0])
	  cylinder(r=(mountWidth-armHeight),h=mountWidth+1);
          }
        }
      }

      //cutout center
      translate([mountWidth/2,-(jointOuter+jointSlop)/2,-.1])
      cylinder(r=(jointOuter+jointSlop)/2,h=mountWidth+1);
      translate([mountWidth/2-(jointOuter+jointSlop)/2,-(jointOuter+jointSlop)/2-mountWidth,-.1])
      cube([jointOuter+jointSlop,mountWidth,100]);

      //nut & bolt holes
      translate([mountWidth/2,-jointOffset,nutRad])
      rotate([0,90,0]){
        rotate([0,0,30])
        cylinder(r=nutRad, h=(jointOuter+jointSlop)+nutHeight*2, $fn=6,center=true);
        cylinder(r=boltRad, h=mountWidth+wall, center=true, $fn=16);
      }
    }
  }
}

//this'll be updated.
//I'm thinking two screw clamps, one top and one bottom; m4 for consistency.
module belt_mount() {
  echo(mountWidth);
  translate([mountWidth/2-wall,wall-.01,0])
  union(){
    for(i=[0:beltPitch:mountWidth-beltPitch]){
      translate([0,0,i])
      rotate([45,0,0])
      cube([wall*2, beltPitch,beltPitch]);
    }
  }
}

module carriage(support=0){
	difference(){
		union(){
			for(i=[0:1]){
				mirror([i,0,0])
				translate([rodSeparation/2,lmMountSize/2,0])
				rotate([0,0,180])
				lmxuu_mount();
			}

			belt_mount();

			translate([0,wall/2,mountWidth/2])
			cube([rodSeparation-lm_dia+0.1,wall,mountWidth],center=true);
			difference(){
				parallel_joints(support);

				for(i=[0:1]){
					mirror([i,0,0])
					translate([rodSeparation/2,lmMountSize/2,0])
					cylinder(r=lm_dia/2+.1, h=lm_height+wall*2);
				}
			}
			
			//stiffening bars
			for(i=[0:1]){
				translate([0,0,sqrt(2)*wall/2+i*(mountWidth-sqrt(2)*wall)])
				rotate([45,0,0])
				#cube([rodSeparation-mountWidth,wall,wall],center=true);
			}
		}

		//belt zip ties
		translate([0,-2,beltPitch*sqrt(2)*2+sqrt(2)])
		for(i=[0:1]){
			mirror([0,0,i]){
				translate([mountWidth/2,wall+.5,beltPitch])
				scale([1,1.5,1])
				rotate_extrude(convexity = 10,$fn=32){
					translate([beltPitch,0,0])
					square([2,3],center=true);
				}
			}
		}

		//lm10uu zip ties
		for(i=[0:1]){
			mirror([i,0,0]){
				translate([rodSeparation/2,lmMountSize/2,lm_height/2+wall/2])
				rotate_extrude(convexity = 10,$fn=32){
					translate([lmMountSize/2+2,0,0])
					square([3,4],center=true);
				}
			}
		}

		//hole in the middle
		translate([0,0,mountWidth/2])
		rotate([90,0,0])
		cylinder(r=mountWidth/4,h=mountWidth,center=true);
	}
}

carriage(support=1);

%translate([-jointSeparation/2,-jointOffset,0])
joint();