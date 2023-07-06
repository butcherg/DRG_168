include <../lib/Round-Anything/polyround.scad>
include <../lib/utilities.scad>

//for integration:
//use <../lib/separate_courses/firebox.scad>


backhead = [
[0.0000,0.0000,0.0000],
[0.0000,0.100,0.0000],
[0.3000,0.100,0.0400],
[0.3000,0.0000,0.0000]
];	

door= [
[0.0000,0.0000,0.0000],
[0.0000,0.0500,0.0000],
[0.0800,0.0500,0.0200],
[0.0840,0.0300,0.0000],
[0.1340,0.0300,0.0050],
[0.1380,0.0000,0.0000]
];

module firebox_backhead() {

	translate([0.1,0,0]) rotate([0,90,0]) 
	rotate_extrude() {
		polygon(polyRound(backhead, 30));
	}
	
	translate([0.18,0,-0.12]) rotate([0,90,0]) {
		rotate_extrude() {
			polygon(polyRound(door, 30));
		}
		
		//hinges:
		translate([-0.05,0.013,0.056]) rotate([0,90,0]) roundedbox([0.031,0.09,0.02],0.015);
		translate([0.03,0.013,0.056]) rotate([0,90,0]) roundedbox([0.031,0.09,0.02],0.015);
		
		//hinge pivots:
		translate([-0.06,0.073,-0.005]) rotate([90,0,90]) roundedbox([0.031,0.06,0.02],0.015);
		translate([0.04,0.073,-0.005]) rotate([90,0,90]) roundedbox([0.031,0.06,0.02],0.015);
		
		//hinge shaft:
		translate([-0.05,0.09,0.040]) rotate([90,0,90]) cylinder(d=0.015, h=0.1);
		
	}

	difference() {
		boilercourse(0.6, 0.1, 0.03);
		translate([-0.001, -0.1, -0.3]) cube([0.3, 0.2, 0.3]);
	}
	
	//backhead base:
	basewidth=0.19;
	baseheight=0.08;
	/*
	translate([-0.1,-basewidth/2,-0.39]) 
		difference() {
			cube([0.3,basewidth,0.16]);
			union() {
				translate([-0.001,basewidth/2,0.39]) rotate([0,90,0]) cylinder(h=basewidth, d=0.57); //cuts channel flush with firebox circumference
				translate([-0.001, 0.02, 0.03]) cube([0.3, 0.2, 0.3]); //channel
				translate([0.11, basewidth/2, -1]) cylinder(h=2, d=screwhole_0_80, $fn=90);  //screw hole
			}
		}
	*/

	//base:
	translate([0.09, -basewidth/2, -0.34]) cube([0.1, basewidth, baseheight]); 
	difference() {
		translate([0.19,-basewidth/2,-0.26]) rotate([0,180,0]) frame_channel(length=0.33, width=basewidth, height=baseheight);
		translate([-0.04, 0, -1]) cylinder(h=2, d=screwhole_0_80, $fn=90);  //screw hole
	}
		
	
	translate([0.15,0,0]) rivet_cylinder(diameter=0.3, start_deg=210, end_deg=360, spacing_deg=10);
	translate([0.15,0,0]) rivet_cylinder(diameter=0.3, start_deg=10, end_deg=150, spacing_deg=10);
		
	translate([-0.045,0,-0.33]) nutretainer_0_80(d=(5/32)*1.3);
}

scale(25.4)
	firebox_backhead($fn=360);

//for integration:
//firebox();