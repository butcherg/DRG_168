include <Round-Anything/polyround.scad>

$fn=180;

//solid:
/*
pts = 
[
[0.000,0.000,0.000],
[0.000,0.110,0.000],
[0.037,0.110,0.020],
[0.042,0.032,0.050],
[0.065,0.016,0.040],
[0.067,0.000,0.000]
];
*/

pts = [
[0.000,0.000,0.000],
[0.000,0.100,0.000],
[0.037,0.100,0.020],
[0.042,0.032,0.050],
[0.065,0.016,0.040],
[0.067,0.000,0.000]
];

//hollow:
pts1 = 
[
[0.000,0.101,0.000],
[0.000,0.110,0.000],
[0.021,0.108,0.040],
[0.037,0.095,0.040],
[0.041,0.075,0.000],
[0.043,0.042,0.040],
[0.068,0.015,0.040],
[0.070,0.000,0.000],
[0.067,-0.001,0.000],
[0.056,0.013,0.000],
[0.035,0.040,0.000],
[0.031,0.088,0.000],
[0.020,0.098,0.000]
];

module bell() {
	difference() {
		rotate_extrude()
			polygon(polyRound(pts1,30));
		translate([0,0,0.09]) cylinder(d=0.023, h=0.03);
	}
}

bell($fn=90);