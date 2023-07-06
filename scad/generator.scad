use <../lib/Round-Anything/polyround.scad>
use <../lib/utilities.scad>

function brkt_pts(brht=1, brwd=1, brtb=0.1, brtboff=0) = [
	[-brtb, -brtboff, 0],
	[0, 0, 0],
	[0, brht, 0],
	[brwd, brht, 0],
	[brwd, 0, 0],
	[brwd+brtb, -brtboff, 0]
];

generator_cap_pts1 = [
[0.0000,0.0000,0.000],
[0.0700,0.0000,0.0000],
[0.0700,0.0230,0.0050],
[0.0550,0.0230,0.0000],
[0.0518,0.0458,0.0150],
[0.0000,0.0500,0.0000]
];

generator_cap_pts2 = [
[0.000,0.000,0.000],
[0.070,0.000,0.000],
[0.070,0.023,0.020],
[0.065,0.023,0.020],
[0.065,0.020,0.015],
[0.020,0.022,0.007],
[0.020,0.040,0.002],
[0.006,0.042,0.000],  //had to take radius out, made an invalid mesh...
[0.000,0.042,0.000]
];

generator_stack_pts = [
[0.0000,0.0000,0.000],
[0.0133,0.0000,0.0000],
[0.0130,0.0050,0.0150],
[0.0180,0.0050,0.0020],
[0.0180,0.0210,0.0020],
[0.0110,0.0210,0.0150],
[0.0090,0.0270,0.0000],
[0.0070,0.0260,0.0000],
[0.0070,0.0210,0.0000],
[0.0000,0.0206,0.0000]
];

generator_mount_pts =  [
[0.000,0.000,0.000],
[0.000,0.120,0.000],
[0.098,0.119,0.000],
[0.226,0.269,0.000],
[0.729,0.269,0.000],
[0.881,0.111,0.000],
[0.981,0.111,0.000],
[0.981,0.000,0.000],
[0.881,0.000,0.000],
[0.729,0.124,0.000],
[0.226,0.124,0.000],
[0.098,0.000,0.000]
];


module generator_bracket(ht=1, wd=1, tb=0.1, tboff=0.015) {
	translate([0, -wd/2, 0])
		rotate([90,0,90]) 
			linear_extrude(0.035) polygon(polyRound(beamChain(brkt_pts(ht, wd, tb, tboff), 	  offset1=0.005+0.005, offset2=-0.008),20));
	translate([0.017, -wd/2-tb/1.6, 0])rotate([15,0,0])cylinder(d=tb*0.7, h=tb/4, $fn=6);
	translate([0.017, wd/2+tb/1.6, 0])rotate([-15,0,0])cylinder(d=tb*0.7, h=tb/4, $fn=6);
}

module generator_end() {
	translate([0,0,0.015]) cylinder(d=0.1, h=0.015);
	cylinder(d=0.12, h=0.015);
}

module generator() {
	bracketht=0.06;
	bracketwd=0.2;
	generator_bracket(bracketht, bracketwd, 0.03, 0.01);
	translate([0.1,0,0]) generator_bracket(bracketht, bracketwd, 0.03, 0.01);
	
	//translate([0.07, -0.1, 0.15])rotate([90,0,0]) rotate_extrude(angle=360) polygon(polyRound(generator_cap_pts1, 30));
	//translate([0.07, 0.1, 0.15])rotate([-90,0,0]) rotate_extrude(angle=360) polygon(polyRound(generator_cap_pts2, 30));
	
	cylinderwd=0.15;
	//well-formed:
	translate([0.07, -cylinderwd/2, bracketht+0.08])rotate([90,0,0]) rotate_extrude(angle=360) polygon(polyRound(generator_cap_pts1, 20)); //port cap
	translate([0.07, cylinderwd/2, bracketht+0.08])rotate([-90,0,0]) rotate_extrude(angle=360) polygon(polyRound(generator_cap_pts2, 20)); //starboard cap
	//starboard cap nuts:
	translate([0.057,0.109,0.149]) rotate([-90,0,0]) cylinder(d=0.007, h=0.01, $fn=6);
	translate([0.083,0.109,0.149]) rotate([-90,0,0]) cylinder(d=0.007, h=0.01, $fn=6);
	translate([0.057,0.109,0.131]) rotate([-90,0,0]) cylinder(d=0.007, h=0.01, $fn=6);
	translate([0.083,0.109,0.131]) rotate([-90,0,0]) cylinder(d=0.007, h=0.01, $fn=6);
	//stack:
	translate([0.1,0.086,0.2]) {
		cylinder(h=0.02, d=0.022);
		translate([0,0,0.013]) cylinder(h=0.003, d=0.025);
		translate([0,0,0.017]) cylinder(h=0.003, d=0.025);
		cylinder(h=0.03, d=0.019);
		translate([0,0,0.025]) rotate_extrude(angle=360) polygon(polyRound(generator_stack_pts, 30));
	}
	
	//coarse:
	//translate([0.07,-0.075,bracketht+0.08]) rotate([90,0,0]) generator_end();
	//translate([0.07,0.076,bracketht+0.08]) rotate([-90,0,0]) generator_end();
	
	difference() {
		translate([0.07,cylinderwd/2,bracketht+0.08]) rotate([90,0,0]) cylinder(d=0.08, h=cylinderwd);
		translate([0,0,0.13]) cube([0.05, 0.06, 0.02]);
		translate([0.03,0.01,0.1225]) rotate([-90,-90,0]) triangle(0.035, 0.04, 0.04);
	}
	
	translate([0,0.095,bracketht+0.0]) rotate([90,0,0]) scale(0.137) linear_extrude(0.14) polygon(polyRound(generator_mount_pts, 30));
	translate([0,-0.075,bracketht+0.0]) rotate([90,0,0]) scale(0.137) linear_extrude(0.14) polygon(polyRound(generator_mount_pts, 30));
	
	bolty=0.085;
	translate([0.007,0.085,bracketht+0.01]) cylinder(d=0.01, h=0.01, $fn=6);
	translate([0.007,-bolty,bracketht+0.01]) cylinder(d=0.01, h=0.01, $fn=6);
	translate([0.127,bolty,bracketht+0.01]) cylinder(d=0.01, h=0.01, $fn=6);
	translate([0.127,-bolty,bracketht+0.01]) cylinder(d=0.01, h=0.01, $fn=6);
}

$fn =  $preview ? 90 : 180;

scale(25.4)
	generator($fn=90);

//pts1 = polyRound(generator_cap_pts1, 30);
//translate([0.07, -cylinderwd/2, bracketht+0.08])
//	rotate([90,0,0]) 
//		rotate_extrude(angle=360) polygon(pts1); //port cap

//pts2 = polyRound(generator_cap_pts2, 5);
//echo(pts2);
//translate([0.07, cylinderwd/2, bracketht+0.08]) 
//	rotate([-90,0,0]) 
//		rotate_extrude(angle=360) polygon(pts2); //starboard cap
 