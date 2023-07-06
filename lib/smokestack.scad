include <Round-Anything/polyround.scad>

/*
difference() {
	difference() {
		difference() {
			group() {
			cylinder(d1=.5, d2=0, h=3);
			translate([0,0,1.7]) rotate([180,0,0]) cylinder(d1=.5, d2=0, h=5);
			}
			translate([-.5,-.50,-3]) cube([1, 1, 3]);
		}
		translate([-.5,-.50,5]) cube([1, 1, 3]);
	}
	translate([-.5,0,-.4]) rotate([0,90,0]) cylinder(d=1, h=1);
}
*/

/*
//solid:
smokestack_pts = [
[0.000,0.000,0.000],
[0.000,0.470,0.000],
[0.095,0.470,0.000],
[0.080,0.186,0.500],
[0.095,0.000,0.000]
];
*/

//hollow:
smokestack_pts = [
[0.000,0.000,0.000],
[0.000,0.013,0.000],
[0.081,0.015,0.000],
[0.065,0.184,0.000],
[0.079,0.473,0.000],
[0.095,0.470,0.000],
[0.080,0.186,0.500],
[0.095,0.000,0.000]
];

base_pts = [
[0.0000,0.0000,0.0000],
[0.0000,0.0900,0.0000],
[0.1000,0.0900,0.0000],
[0.1000,0.0500,0.0200],
[0.1350,0.0370,0.0200],
[0.1350,0.0000,0.0000]
];

height=0.02;
tabdiameter=0.03;
tabheight=0.03;
boltdiameter=0.024;
boltheight = 0.075;
radius=0.103;


module smokestack() {
	translate([0,0,0.04])
		rotate_extrude()
			polygon(polyRound(smokestack_pts,30));
	
	difference() {
		union() {
			rotate_extrude()
				polygon(polyRound(base_pts,30));
			//base tabs:
			rotate([0,0,0+45]) translate([radius, 0, 0.06]) cylinder(d=tabdiameter, h=tabheight);
			rotate([0,0,90+45]) translate([radius, 0, 0.06]) cylinder(d=tabdiameter, h=tabheight);
			rotate([0,0,180+45]) translate([radius, 0, 0.06]) cylinder(d=tabdiameter, h=tabheight);
			rotate([0,0,270+45]) translate([radius, 0, 0.06]) cylinder(d=tabdiameter, h=tabheight);
			//stack tabs:
			rotate([0,0,0+45]) translate([radius, 0, 0.092]) cylinder(d=tabdiameter, h=tabheight);
			rotate([0,0,90+45]) translate([radius, 0, 0.092]) cylinder(d=tabdiameter, h=tabheight);
			rotate([0,0,180+45]) translate([radius, 0, 0.092]) cylinder(d=tabdiameter, h=tabheight);
			rotate([0,0,270+45]) translate([radius, 0, 0.092]) cylinder(d=tabdiameter, h=tabheight);
			//bolts (run through both tabs):
			rotate([0,0,0+45]) translate([radius, 0, 0.055]) cylinder(d=boltdiameter, h=boltheight, $fn=6);
			rotate([0,0,90+45]) translate([radius, 0, 0.055]) cylinder(d=boltdiameter, h=boltheight, $fn=6);
			rotate([0,0,180+45]) translate([radius, 0, 0.055]) cylinder(d=boltdiameter, h=boltheight, $fn=6);
			rotate([0,0,270+45]) translate([radius, 0, 0.055]) cylinder(d=boltdiameter, h=boltheight, $fn=6);
		}

		translate([-0.26,0,-0.61/2+0.03]) rotate([0,90,0]) cylinder(d=0.61, h=0.5);
	}
}

$fn =  $preview ? 90 : 180;

scale(25.4)
	smokestack($fn=90);