
mount_sep = 50;
mount_rad = 2.3;
center_rad = 18/2;

//distance from center hole to back
mount_offset = 40;

wall = 7;
plate = 20;
spine = 15;
spine_height = 50;



difference(){
	union(){
		//make the base plate
		translate([0,0,wall/2])
		cube([plate,mount_sep,wall], center=true);
	
		for(i=[-1,1]){
			translate([0,mount_sep/2*i,0])
			cylinder(r=plate/2, h=wall);
		}

		//vertical spine
		translate([mount_offset-wall,0,spine_height/2])
		cube([wall, spine, spine_height], center=true);
		
		difference(){
			translate([0,0,mount_offset*2/sqrt(2)/2-2])
			rotate([0,0,45])
			cube([mount_offset*2/sqrt(2)-4, mount_offset*2/sqrt(2)-4,mount_offset*2/sqrt(2)-4], center=true);

			translate([0,0,54])
			rotate([0,45,0])
			cube([mount_offset*2,mount_offset*2,mount_offset*2],center=true);
	
			translate([-mount_offset*2,0,0])
			cube([mount_offset*4,mount_offset*4,mount_offset*4],center=true);
			
			translate([mount_offset-.01,0,spine_height/2-.1])
			cube([wall, spine, spine_height], center=true);
		}
		
	}

	//base holes
	translate([0,0,-.1]){
		//mount holes
		for(i=[-1,1]){
			translate([0,mount_sep/2*i,0])
			cylinder(r=mount_rad, h=wall+1);
		}

		//center hole
		cylinder(r=center_rad, h=wall*wall);
	}

	//mount holes
	translate([mount_offset-wall*1.5,0,spine_height/2])
	for(j=[0,1]){
		mirror([0,0,j])
		translate([0,0,spine_height/4])
		rotate([0,90,0]){
			cylinder(r=2.25, h=wall*2, $fn=12);
			translate([0,0,-.1])
			cylinder(r1=2.25*2, r2=2.25,h=wall/2, $fn=12);
			translate([0,0,-wall*4])
			cylinder(r1=2.25*2, r2=2.25*2,h=wall*4+.01, $fn=12);
		}
	}
}