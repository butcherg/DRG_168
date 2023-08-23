include <../lib/Round-Anything/polyround.scad>
use <../lib/utilities.scad>
use <../lib/cab_floor.scad>

include <../lib/utilities.scad>
include <../lib/globals.scad>

front_pts1 = [ 
[0.0000,0.0000,0.0000],
[0.0000,0.7200,0.0000],
[0.5000,0.86500,26.0000],
[1.0300,0.7200,0.0000],
[1.0300,0.0000,0.0000]
];

side_pts1 = [
[0.0000,0.0000,0.0000],
[0.0000,0.7200,0.0000],
[1.1500,0.7200,0.0000],
[1.1500,0.7000,0.0000],
[0.7940,0.6580,0.07000],
[0.7800,0.6300,0.0000],
[0.7500,0.6300,0.0000],
[0.7500,0.6300,0.0000],
[0.7500,0.0000,0.0000]
];

rear_pts = [
[0.000,0.000,0.000],
[0.000,0.720,0.000],
[0.500,0.865,26.000],
[1.030,0.720,0.000],
[1.030,0.000,0.000],
[0.730,0.000,0.000],
[0.730,0.708,0.020],
[0.500,0.730,1.000],
[0.300,0.708,0.020],
[0.300,0.000,0.000]
];


module cab_roof(arc=90, radius=30, length=20, thickness=1) 
{
	translate([length,0,-radius-thickness]) rotate([0,-90,0]) {
		
		//roof:
		difference() {
			pie_slice(ang=arc, l=length, r=radius+thickness, spin=-arc/2, $fn=360);
			translate([0,0,-length/2]) pie_slice(ang=arc*2, l=length*2, r=radius, spin=-(arc*2)/2, $fn=360);
		}
		
		//roof edges:
		rotate([0,0,-arc/2]) translate([radius+thickness/2,0,0]) cylinder(d=thickness, h=length);
		rotate([0,0,arc/2]) translate([radius+thickness/2,0,0]) cylinder(d=thickness, h=length);
	}
}

module cab_side() {
	difference() {
		linear_extrude(.04) polygon(polyRound(side_pts1, 20)); //side overall shape
		union() {
			translate([-0.0001,-0.001,0.03]) 
				cube([1,0.63,0.39]); // crown offset
			translate([0.06, 0.07, 0.02]) 
				cube([0.6, 0.1, 1]);  //number board inset
			translate([0.06,0.24,0.02]) 
				cube([0.28,0.38, 1]);  //forward window inset
			
			panewidth=0.11;
			paneheight=0.16;
			translate([0.08,0.26,-0.01]) 
				cube([panewidth, paneheight, 1]);  //forward window pane
			translate([0.21,0.26,-0.01]) 
				cube([panewidth, paneheight, 1]);  //forward window pane
			translate([0.08,0.44,-0.01]) 
				cube([panewidth, paneheight, 1]);  //forward window pane
			translate([0.21,0.44,-0.01]) 
				cube([panewidth, paneheight, 1]);  //forward window pane

			translate([0.39,0.24,-0.5])
				cube([0.28,0.38, 1]);  //rearward window
		}
	}
	
	translate([0.38,0.24,0]) cube([0.3,0.02,0.05]); //window sill

}

module cabshell() {
	
	port_handrail_position = [0.01,-0.243,0.408];
	starboard_handrail_position = [0.01,0.253,0.408];
	
	//front wall:
	difference() {
		union() {
			rotate([0,0,90]) translate([-0.50,0,0]) rotate([ 90,0,0]) linear_extrude(.03) polygon(polyRound(front_pts1));

			//cab penetration grommets
			translate(starboard_handrail_position) rotate([0,-90,0]) cylinder(d=0.04, h=0.02);
			translate(port_handrail_position) rotate([0,-90,0]) cylinder(d=0.04, h=0.02);
			
		}
		union () {
			//front doors:
			//translate([-0.25,-0.47,0.08]) cube([1,0.12,0.53]);
			//translate([-0.25,0.375,0.08]) cube([1,0.12,0.53]);
			
			difference() { //left front door outline
				translate([-0.0001,-0.47,0.08]) cube([0.02,0.12,0.53]);
				translate([-0.0001,-0.46,0.09]) cube([0.02,0.10,0.51]);
			}
			difference() { //right front door outline:
				translate([-0.0001,0.37,0.08])  cube([0.02,0.12,0.53]);
				translate([-0.0001,0.38,0.09])  cube([0.02,0.10,0.51]);
			}
			
			//front door windows:
			translate([-0.0001,-0.445,0.38]) cube([0.1,0.07,0.2]);
			translate([-0.0001,0.395,0.38]) cube([0.1,0.07,0.2]);
			
			//front door insets:
			translate([-0.0001,-0.445,0.13]) cube([0.01,0.07,0.2]);
			translate([-0.0001,0.395,0.13]) cube([0.01,0.07,0.2]);
			
			//front windows:
			translate([-0.25,-0.27,0.51]) cube([1,0.14,0.1]);
			translate([-0.25,0.15,0.51]) cube([1,0.14,0.1]);
			
			//firebox opening:
			translate([-0.001,0,0.16]) rotate([0,90,0]) cylinder(d=0.65, h=1);
			cube([1, 0.65, 0.4], center=true);
			
			//cab penetration holes:
			translate([0.03,0,0]) translate(starboard_handrail_position) rotate([0,-90,0]) cylinder(d=0.02, h=0.08);
			translate([0.03,0,0]) translate(port_handrail_position) rotate([0,-90,0]) cylinder(d=0.02, h=0.08);
		}
	}
		
	//rear wall:
	difference() {
		translate([0.72,-0.5,0]) rotate([ 90,0,90]) linear_extrude(.03) polygon(polyRound(rear_pts));
		union() {
			translate([0,-0.43,0.44]) cube([1,0.16,0.23]);
			translate([0,0.3,0.44]) cube([1,0.16,0.23]);
			
			translate([0.74,-0.43,0.1]) cube([1,0.16,0.25]);
			translate([0.74,0.3,0.1]) cube([1,0.16,0.25]);
		}
	}
	translate([0, -0.49, 0]) rotate([90,0,0]) cab_side();
	translate([0, 0.5, 0]) rotate([90,0, 180]) mirror([1,0,0]) cab_side();

	translate([-0.02,0,0.81]) cab_roof(arc=36, radius=1.75517, length=1.2, thickness=0.02);

	hatchsize=0.25;
	translate([0.25,-hatchsize/2,0.79]) { //roof hatch
		cube([hatchsize,hatchsize,0.03]);  
		translate([-0.005,-0.005,0.03]) cube([hatchsize+0.01,hatchsize+0.01,0.01]); 
	}

}

module cab() {
	translate([0.01,-0.005,0.205]) cabshell();
	cab_floor();
}

$fn =  $preview ? 90 : 180;

scale(25.4)
	translate(-cab_position)
	difference () {
		translate(cab_position) cab($fn=90);
		translate([rear_screw_hole,0,0]) cylinder(h=1, d=screwhole_0_80, $fn=90);
		
	}
