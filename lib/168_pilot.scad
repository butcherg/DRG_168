use <../lib/utilities.scad>
use <../lib/Round-Anything/polyround.scad>

pilotwidth=0.7;
pilotheight=0.2;
pilotdepth=0.30;
	
pilotbeamdepth=0.1;
pilotbeamheight=0.1;
pilotbeamtruncation=0.06;

module pilotbase(size=[0.5, 0.5, 0.1], r=0.02) {
	pts = [
		[0,0,r],
		[size[0], size[1]/2, r],
		[size[0], -size[1]/2, r]
	];
	linear_extrude(size[2]) polygon(polyRound(pts, 30));
}

module pilottines(h=0.1, d=0.1) {
	difference() {
		translate([pilotdepth-pilotbeamdepth/2, 0, pilotheight+pilotbeamheight/2])
			difference() {
				union() {
					rotate([0,39.34,0]) translate([0,0.06,-0.5]) cube([0.04, 0.02, 0.5]);
					rotate([0,35,0]) translate([0,0.10,-0.5]) cube([0.04, 0.02, 0.5]);
					rotate([0,30.1,0]) translate([0,0.14,-0.5]) cube([0.04, 0.02, 0.5]);
					rotate([0,24.7,0]) translate([0,0.18,-0.5]) cube([0.04, 0.02, 0.5]);
					rotate([0,18.8,0]) translate([0,0.22,-0.5]) cube([0.04, 0.02, 0.5]);
					rotate([0,12.42,0]) translate([0,0.26,-0.5]) cube([0.04, 0.02, 0.5]);
			
					rotate([0,41.3,0]) translate([0,-0.06,-0.5]) cube([0.04, 0.02, 0.5]);
					rotate([0,37,0]) translate([0,-0.10,-0.5]) cube([0.04, 0.02, 0.5]);
					rotate([0,32.5,0]) translate([0,-0.14,-0.5]) cube([0.04, 0.02, 0.5]);
					rotate([0,27.3,0]) translate([0,-0.18,-0.5]) cube([0.04, 0.02, 0.5]);
					rotate([0,21.6,0]) translate([0,-0.22,-0.5]) cube([0.04, 0.02, 0.5]);
					rotate([0,15.42,0]) translate([0,-0.26,-0.5]) cube([0.04, 0.02, 0.5]);
				}
				union() {
					translate([-0.5,-0.5,-0.65]) cube([1,1,0.4]); //truncate bottoms
				}
			}
				rotate([0,5,-37]) translate([-0.05,0,-0.002]) cube([0.05, 0.37, 0.23]);
				//rotate([0,21,-37]) translate([-0.05,0,-0.004]) cube([0.05, 0.17, 0.23]);
				rotate([0,7.3,37]) translate([-0.05,-0.36,-0.002]) cube([0.05, 0.36, 0.23]);
	}
}

module pilotbeam() {
	difference() {
		translate([0, -pilotwidth/2, 0]) roundedbox([pilotbeamdepth, pilotwidth, pilotbeamheight], 0.02);
		translate([pilotbeamdepth/2, -pilotwidth, -0.01]) cube([0.2, pilotwidth*2, 0.2]);
	}
}

module pilot() {
	pilottines();
	translate([pilotdepth-pilotbeamdepth/2, 0, pilotheight-pilotbeamheight/2]) pilotbeam();
	translate([0,0,-0.035]) pilotbase([pilotdepth, pilotwidth+0.1, 0.035]);
}

$fn = $preview ? 90 : 180;

scale(25.4)
	pilot();

