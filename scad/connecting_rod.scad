use <../lib/utilities.scad>


bearing_distance=1.01;
rod_width=0.03;
rod_height=0.04;
bearing_hole=0.03;

module crosshead_bearing() {
	length=0.13;
	width=0.035;
	height=0.05;
	bearing_offset=0.04;
	bearing_fillet=0.1;
	
	translate([-bearing_offset,0,0])
	hull() {
		translate([0, -width/2, -height/2]) 
			cube([length, width, height]);
		translate([0, -rod_width/2, -rod_height/2]) 
			cube([length*(1+bearing_fillet), rod_width, rod_height]);
	}
}

module crankpin_bearing() {
	length=0.17;
	width=0.035;
	height=0.07;
	bearing_offset=0.11;
	bearing_fillet=0.1;
	bearing_flange=1.7;
	
	translate([-bearing_offset,0,0])
	hull() {
		translate([0, -width/2, -height/2]) 
			cube([length, width, height]);
		translate([-length*bearing_fillet, -rod_width/2, -rod_height/2]) 
			cube([length*(1+bearing_fillet), rod_width, rod_height]);
		
	}
	
	//bearing flange:
	translate([0,(rod_width*1.3)/2])
		rotate([90,0,0]) 
			cylinder(d=bearing_hole*bearing_flange, h=rod_width*1.3);
	
	//bolts:
	translate([-0.1,0,-(height*1.3)/2]) 
		cylinder(d=rod_width*0.7, h=height*1.3, $fn=6);
	translate([-0.07,0,-(height*1.3)/2]) 
		cylinder(d=rod_width*0.7, h=height*1.3, $fn=6);
	translate([-0.04,0,-(height*1.3)/2]) 
		cylinder(d=rod_width*0.7, h=height*1.3, $fn=6);
	
	//lubricator
	bearing_lubricator(rod_width*0.7, 0.07);
}

module connecting_rod_blank() {
	rod(bearing_distance, rod_width, rod_height);
	crosshead_bearing();
	translate([bearing_distance,0,0]) crankpin_bearing();
}



module connecting_rod() {
	difference() {
		connecting_rod_blank();
		crankpin_hole(bearing_hole, rod_width);
		translate([bearing_distance,0,0]) crankpin_hole(bearing_hole, rod_width);
	}
}

$fn = $preview ? 90 : 180;

scale(25.4)
	translate([-bearing_distance,0,0]) connecting_rod();
	//crankpin_bearing();