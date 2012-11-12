include <configuration.scad>
use <carriage.scad>

center_rad = 20;
bolt_ring_rad = 26;

//this is for a makergear groovemount
hotend_outer_rad = 15.875/2;
hotend_inner_rad = 6;
hotend_rad = 12;

top_thickness = 6;
groove_thickness = 4;

wedge_factor = .75;	//decrease this to make the slot wider, and the hotend easier to insert
groove_slot_width = hotend_inner_rad*2-wedge_factor;
top_slot_width = hotend_outer_rad*2-wedge_factor/2;

//this is for the threaded coupler
coupler_inner_rad = 4.5;

layer_height=.2;

$fn=72;

slop = .1;

//gray in the mounting holes and center space
translate([0,0,-.1])
%cylinder(r=center_rad, h=.2,center=true, $fn=32);

for (a = [0:2]) {
  rotate(a*120){
    translate([0, bolt_ring_rad, -.1])
    %cylinder(r=boltRad, h=.2, center=true, $fn=12);

    translate([0, hotend_rad, -.1])
    rotate([0,0,60])
    //translate([-10.5,0,0])
    {
      %cylinder(r=hotend_outer_rad, h=1, center=true, $fn=36);
      %cylinder(r=hotend_inner_rad, h=2, center=true, $fn=36);
    }
  }
}

module hotend_arm(){
  difference(){
    union(){
      //bolt mount
      translate([0,bolt_ring_rad,0])
      cylinder(r=nutRad+wall/2,h=groove_thickness+top_thickness-.01, $fn=36);
      
      translate([0,hotend_rad,0])
      rotate([0,0,30]){
        //hotend mount
        cylinder(r=hotend_rad-slop/2,h=groove_thickness, $fn=6);
        translate([0,0,groove_thickness-.01])
        cylinder(r=(hotend_rad-slop/2)*cos(30),h=top_thickness, $fn=72);

        //alignment peg
        translate([0,(-hotend_rad+slop)*cos(30)-groove_thickness/2+slop+slop,groove_thickness/2]){
          cube([groove_slot_width-slop*2,groove_thickness-slop*2,groove_thickness],center=true);
          for(i=[0,1]){
            mirror([i,0,0])
            translate([(groove_slot_width-slop*2)/2,1,0])
            rotate([0,45,0])
            cube([1-slop,groove_thickness-slop*2+2,1-slop],center=true);
          }
        }

        translate([0,0,groove_thickness+top_thickness-.01])
        cylinder(r=(hotend_rad-slop/2)*cos(30),h=wall/2);
        translate([0,0,groove_thickness+top_thickness])
        cylinder(r=coupler_inner_rad+wall/4,h=2);
      }
    }

    //bolt hole
    translate([0,bolt_ring_rad,0]){
      translate([0,0,nutHeight])
      cylinder(r=nutRad,h=nutHeight+10, $fn=6);
      cylinder(r=boltRad,h=groove_thickness*2, center=true, $fn=12);
    }

    //hotend hole
    translate([0,hotend_rad,-.1])
    cylinder(r=hotend_inner_rad+slop,h=groove_thickness+.2);
    translate([0,hotend_rad,groove_thickness])
    cylinder(r=hotend_outer_rad+slop,h=top_thickness);

    //coupler mounting hole & slit
    translate([0,hotend_rad,groove_thickness+top_thickness+layer_height]){
      cylinder(r=coupler_inner_rad,h=8.1);
      rotate([0,0,150])
      translate([-coupler_inner_rad/4,-hotend_outer_rad-wall,0])
      cube([coupler_inner_rad/2,20,30]);
    }
    translate([0,hotend_rad,groove_thickness+top_thickness-.01])
    rotate([0,0,150])
    translate([-20,6,0])
    cube([40,10,30]);
    
    
    //slot for groove
    rotate([0,0,60])
    translate([0,hotend_rad/2,groove_thickness/2]){
      cube([hotend_rad*2,groove_slot_width,groove_thickness+.2],center=true);
      for(i=[0,1]){
          rotate([0,0,90])
          mirror([i,0,0])
          translate([(groove_slot_width-slop*2)/2,0,0])
          rotate([0,45,0])
          cube([1,hotend_outer_rad,1],center=true);
        }
    }

    //top slot
    rotate([0,0,60])
    translate([2,hotend_rad/2,groove_thickness+top_thickness/2+.01])
    cube([top_slot_width,top_slot_width,top_thickness],center=true);
  }
}

module assembled(){
  for (a = [0:2]) {
    rotate([0,0,a*120])
    hotend_arm();
  }
}

hotend_arm();
