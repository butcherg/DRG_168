use <Round-Anything/polyround.scad>
//include <cab_support_flange_pts.scad>
use <utilities.scad>

cab_support_flange_pts = [ [0.0000,0.0000,0.0000],
[0.0000,0.2200,0.0000],
[0.3200,0.2200,0.0000],
[0.3200,0.2100,0.0000],
[0.2410,0.1850,0.2000],
[0.2020,0.1600,0.2000],
[0.1730,0.1100,0.2000],
[0.1720,0.0670,0.2000],
[0.1960,0.0200,0.0000],
[0.2450,0.0200,0.0000],
[0.2450,0.0000,0.0000] ];

module cab_rear_support(invert=true) {
	fillposition = invert? 0.0 : 0.02;
	translate([0,0.010,0])
	{
		//flange outline:
		translate([0,0.006,0]) rotate([90,0,0]) {
			linear_extrude(.04)
			polygon(
				polyRound(beamChain(cab_support_flange_pts, offset1=-0.005, offset2=0.005),30)
			);

			//fill:
			translate([0,0,fillposition])
				linear_extrude(.02)polygon(polyRound(cab_support_flange_pts,30));
		}

		translate([0.0,-0.037,0]) roundedbox([0.27,0.045, 0.015],0.015, $fn=90);
		translate([0.23,-0.015,0]) {
			cylinder(d=0.035, h=0.03, $fn=90);
			cylinder(d=0.02, h=0.035, $fn=6);
		}
		
		//bolts:
		if (invert) {
			translate([0.05, -0.025, 0]) cylinder(d=0.015, h=0.02, $fn=6);
			translate([0.15, -0.025, 0]) cylinder(d=0.015, h=0.02, $fn=6);
		}
		else {
			translate([0.05, 0.0, 0]) cylinder(d=0.015, h=0.02, $fn=6);
			translate([0.15, 0.0, 0]) cylinder(d=0.015, h=0.02, $fn=6);
		}
		
	}
}

cab_rear_support();