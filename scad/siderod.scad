use <../lib/utilities.scad>

leadcenter=1.54-0.75;
maincenter=2.14-0.75;
rearcenter=3.12-0.75;

module rod_bearing(diameter=5, hole=3, thickness=2) {
	bearing_flange=1.4;
	rotate([90,0,0])
		union() {
			hull () {
				cylinder(d=diameter, h=thickness, center=true);
				translate([0,bearing_offset,0]) 
					cube([thickness,diameter*1.1,thickness], center=true);
			}
			translate([0,bearing_offset,0]) 
				cube([thickness,diameter*1.2,thickness], center=true);
		}
		
		translate([0,(rod_width*1.3)/2])
		rotate([90,0,0]) 
			cylinder(d=bearing_hole*bearing_flange, h=rod_width*1.3);
			
		bearing_lubricator(thickness*0.7, 0.07);
}

rod_width=0.03;
rod_height=0.05;
bearing_diameter=0.07;
bearing_hole=0.029;
bearing_offset=0.005;

module siderod_blank() {
	translate([leadcenter,0,0])
		rod_bearing(bearing_diameter, bearing_hole, rod_width);
	translate([maincenter,0,0])
		rod_bearing(bearing_diameter, bearing_hole, rod_width);
	translate([rearcenter,0,0])
		rod_bearing(bearing_diameter, bearing_hole, rod_width);

	translate([leadcenter,0,0])
		rod(rearcenter-leadcenter, rod_width, rod_height);
}

module siderod() {
	difference() {
		siderod_blank();
		translate([leadcenter,0,0])
			crankpin_hole(bearing_hole, rod_width);
		translate([maincenter,0,0])
			crankpin_hole(bearing_hole, rod_width);
		translate([rearcenter,0,0])
			crankpin_hole(bearing_hole, rod_width);
	}
}


$fn = $preview ? 90 : 180;

scale(25.4)
	siderod();