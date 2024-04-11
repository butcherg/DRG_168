include <Round-Anything/polyround.scad>


module brake_cylinder() {
	cylinder_pts = [
[0.000,0.000,0.000],
[0.000,0.176,0.000],
[0.019,0.176,0.000],
[0.024,0.123,0.010],
[0.05,0.110,0.000],
[0.05,0.000,0.000]
	];
	//rotate([0,90,180]) 
		rotate_extrude(angle=360) polygon(polyRound(cylinder_pts, 20));
	cylinder(d=0.11, h=0.005);
	translate([0,0,0.007]) cylinder(d=0.11, h=0.005);
	translate([0,0,0.1]) cylinder(d=0.11, h=0.005);
	translate([0,0,0.107]) cylinder(d=0.11, h=0.005);
}

module brake_assembly() {
	mountplate_pts = [
[0.150,0.000,0.050],
[0.000,0.350,0.020],
[0.143,0.350,0.000],
[0.168,0.291,0.020],
[0.187,0.291,0.000],
[0.310,0.000,0.020]
	];
	translate([0.3,0,0])
		rotate([90,0,180]) 
			linear_extrude(0.015) polygon(polyRound(mountplate_pts, 20));
	
	translate([0.277,0.063,0.33])
		rotate([0,-90,0])
			brake_cylinder();		

	crank_pts = [
[0.000,0.000,0.030],
[0.030,0.68,0.015],
[0.060,0.000,0.030]
	];
	translate([0,0.07,0])
		rotate([90,0,0])
			linear_extrude(0.015) polygon(polyRound(crank_pts, 20));

	//crank parts
	translate([0.028,0,0.025]) 
		rotate([-90,0,0]) 
			cylinder(d=0.035, h=0.076);
	translate([0.03,0.05,0.33]) 
		rotate([-90,0,0]) 
			cylinder(d=0.02, h=0.025);
	translate([0.029,0.05,0.325]) 
		cube([0.1, 0.025, 0.01]);

	//bolts:
	translate([0.13,0,0.24]) rotate([-90,0,0]) cylinder(d=0.02, h=0.03, $fn=6);
	translate([0.17,0,0.25]) rotate([-90,0,0]) cylinder(d=0.02, h=0.03, $fn=6);
	translate([0.21,0,0.26]) rotate([-90,0,0]) cylinder(d=0.02, h=0.03, $fn=6);
	
	translate([0.09,0,0.1]) rotate([-90,0,0]) cylinder(d=0.02, h=0.03, $fn=6);
	translate([0.125,0,0.1]) rotate([-90,0,0]) cylinder(d=0.02, h=0.03, $fn=6);
	translate([0.16,0,0.1]) rotate([-90,0,0]) cylinder(d=0.02, h=0.03, $fn=6);

}

scale(25.4)
	brake_assembly($fn=90);

