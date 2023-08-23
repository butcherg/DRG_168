use <../lib/Round-Anything/polyround.scad>
use <../lib/utilities.scad>

module top_plate(d=10) {

	t=d*0.1;
	difference() {
		cylinder(h=d*.1, d=d);
		translate([0,0,-0.01]) pie_slice(ang=90, l=d,r=d*2);
	}
	translate([t*3.75,0,0]) cylinder(h=t*1.5, d=t*2.5);
	translate([0, t*3.75,0]) cylinder(h=t*1.5, d=t*2.5);
	translate([t*-3.75, 0,0]) cylinder(h=t*1.5, d=t*2.5);
	translate([0, t*-3.75,0]) cylinder(h=t*1.5, d=t*2.5);
	cylinder(h=t*1.5, d=t*4.5);
	cylinder(h=t*2, d=t*2);

}

module fitting() {
	difference() {
		cylinder(h=0.015, d=0.035, $fn=6);
		translate([0,0,0.005]) cylinder(h=0.015, d=0.023);
	}
}

module pipe_assembly(length) {
	translate([0,0,0.015]) cylinder(h=length-0.015, d=0.03);
	translate([0,0,0.015]) rotate([180,0,0]) fitting();
	translate([0,0,length]) fitting();
	//difference() {
	//	translate([0,0,0.19]) cylinder(h=0.015, d=0.035, $fn=6);
	//	translate([0,0,0.195]) cylinder(h=0.015, d=0.023);
	//}
	//difference() {
	//	translate([0,0,-0.003]) cylinder(h=0.015, d=0.035, $fn=6);
	//	translate([0,0,-0.004]) cylinder(h=0.015, d=0.023);
	//}

}

module compressor() {
	//cylinder:

	//main body:
	cylinder(d=0.13, h=0.17);

	//top and bottom caps:
	cylinder(d=0.15, h=0.02);
	cylinder(d=0.157, h=0.01);
	translate([0,0,0.15]) {
		cylinder(d=0.15, h=0.02);
		translate([0,0,0.01]) cylinder(d=0.157, h=0.01);
	}

	//fins:
	for (i = [ 0.03 : 0.01 : 0.14 ]) {
		translate([0,0,i]) cylinder(d=0.15, h=0.002);
	}

	//bisector:
	translate([-0.15/2, -0.005, 0]) cube([0.15, 0.01, 0.17]);


	//standoff:
	translate([0,0,0.17]) {
		difference() {
			cylinder(d=0.10, h=0.10);
			translate([-.1,0,.04]) 
				rotate([0,90,0]) cylinder(d=0.08, h=0.2);
				//cube([.1, .08, .07]);
		}
		translate([0.035, 0.035, 0]) cylinder(d=0.02, h=0.10);
		translate([-0.035, 0.035, 0]) cylinder(d=0.02, h=0.10);
		translate([0.035, -0.035, 0]) cylinder(d=0.02, h=0.10);
		translate([-0.035, -0.035, 0]) cylinder(d=0.02, h=0.10);
	}

	//piston:
	translate([0,0,0.25]) {
		cylinder(d=0.14, h=0.17);
		cylinder(d=0.145, h=0.01);
		translate([0,0,0.17]) {
			cylinder(d=0.145, h=0.01);
		}
	}


	//top:
	translate([0.03,0,.48]) {
		hull() {
			rotate([90,0,0]) 
				translate([0,-0.026,-0.02]) 
					cylinder(d=0.05, h=0.04);
			translate([-0.025, -0.02, -0.07]) 
				cube([0.05, 0.04, 0.05]);
		}
	}
	
	pts = [
		[0.0000,0.0000,0.0000],
		[0.0000,0.05000,0.0000],
		[0.01250,0.05000,0.0000],
		[0.01800,0.03500,0.5000],
		[0.01800,0.01600,0.5000],
		[0.01120,0.0000,0.0000]
	];

	//upper pipes (steam)
	translate([0.04,0.125,0.33]) 
		rotate([90,0,0]) {
			translate([0,0,0.04]) cylinder(h=0.15, d=0.03);
			translate([0,0,0.05]) cylinder(h=0.015, d=0.035, $fn=6);
			difference() {
				translate([0,0,0.19]) cylinder(h=0.015, d=0.035, $fn=6);
				translate([0,0,0.195]) cylinder(h=0.015, d=0.023);
			}
			difference() {
				translate([0,0,-0.003]) cylinder(h=0.015, d=0.035, $fn=6);
				translate([0,0,-0.004]) cylinder(h=0.015, d=0.023);
			}
			translate([0,0,0.006]) rotate_extrude() polygon(polyRound(pts,20));
			
			
			translate([0,0.024,0.032]) rotate([90,0,0]) cylinder(h=0.008, d=0.03);
			translate([0,0.032,0.031]) rotate([90,0,0]) cylinder(h=0.008, d=0.025, $fn=6);
			translate([0,0.047,0.031]) rotate([90,0,0]) cylinder(h=0.015, d1=0.023, d2=0.018);
			translate([0,0.082,0.031]) rotate([90,0,0]) cylinder(h=0.035, d=0.015);
			translate([0,0.082,0.031]) rotate([90,0,0]) sphere(d=0.015);
			translate([0,0.039,0.015]) cylinder(h=0.015, d=0.013);
			difference() {
				translate([0,0.039,0.009]) cylinder(h=0.009, d=0.017, $fn=6);
				translate([0,0.039,0.005]) cylinder(h=0.009, d=0.013);
			}
		}
		
	//lower pipes (air):
	translate([0.04,0.0827,0.07]) 
		rotate([90,0,0])
			pipe_assembly(0.15);
			
	//mounting studs:
	translate([0.088,-0.18/2,0.055]) rotate([0,-90,0]) roundedbox([0.03, 0.18, 0.02], 0.01);
	translate([0.088,-0.18/2,0.315]) rotate([0,-90,0]) roundedbox([0.03, 0.18, 0.02], 0.01);
	
	//mounting brackets:
	function brkt_pts(brht=1, brwd=1, brtb=0.05, brtboff=0) = [
		[-brtb, -brtboff, 0],
		[0, 0, 0],
		[0, brht, 0],
		[brwd, brht, 0],
		[brwd, 0, 0],
		[brwd+brtb, -brtboff, 0]
	];
	bracket_pts = [
		//[-0.01, -0.015, 0],
		[0, 0, 0], [0, 0.1, 0], 
		[0.29, 0.1, 0], 
		[0.34, 0, 0]
		//[0.3, -0.015, 0]
	 ];
	
	ht=.1; wd=.29; tb=0.01; tboff=0.015;
	difference() {
		union() {
			translate([0.19,-0.045,0.057])
				rotate([0,-90,90])
					//linear_extrude(0.035) polygon(polyRound(beamChain(brkt_pts(ht, wd, tb, tboff), offset1=0.005+0.005, offset2=-0.008),20));
					linear_extrude(0.035) polygon(polyRound(beamChain(bracket_pts, offset1=0.005+0.005, offset2=-0.008),20));
					translate([0.19,0.08,0.057])
				rotate([0,-90,90])
					//linear_extrude(0.035) polygon(polyRound(beamChain(brkt_pts(ht, wd, tb, tboff), offset1=0.005+0.005, offset2=-0.008),20));
					linear_extrude(0.035) polygon(polyRound(beamChain(bracket_pts, offset1=0.005+0.005, offset2=-0.008),20));
		}
		translate([0.44,0.5,0.25]) rotate([90,0,0]) cylinder(d=0.65, h=1);
	}
	translate([0.03,0.02,0.455]) rotate([-90,0,0]) rotate([0,0,45]) top_plate(0.05);
	translate([0.03,-0.02,0.455]) rotate([-90,0,180]) rotate([0,0,45]) top_plate(0.05);

}

$fn = $preview ? 90 : 180;

scale(25.4)
	rotate([0,0,90])
		compressor();
