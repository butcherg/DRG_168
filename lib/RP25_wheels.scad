/*
NMRA RP25 wheek profile approximation

The module rp25_tire produces a wheel roughly conformant to the NMRA RP-25 profile.
The profile is implemented in the function rp25_polygon, which uses the parameters
for the specified profile pulled from teh rp25_profiles array.  The rail codes and
profile parameters are indexed with the code_* and letter variables provided.

The polygon is rounded to the profile radii using the polyRound() module from 
Round-Anything/polyround.scad.  polyRound() uses a third number to specify the 
radius to be made at that point, and produces a two-number array for the OpenSCAD
polygon() function.

The table lookups obfuscate the polygon definition, so here it is in NMRA parameter 
terms (TT is an added variable to specify the tire width, to close out the polygon):

rp25_code79_profile= [
	[0, TT, 0.0],
	[N, TT, 0.0],
	[N, D-P, 0.0],
	[N-T/2, 0.0, R3],
	[N-T-R1/2, D-P, R1],
	[N-T-R1, D, R1],
	[0, D+0.001, 0.003]
];

*/


use <../lib/Round-Anything/polyround.scad>
use <../lib/utilities.scad>

code_175=0;
code_145=1;
code_126=2;
code_116=3;
code_110=4;
code_93=5;
code_88=6;
code_79=7;
code_72=8;
code_54=9;

N=0;
T=1;
W=2;
D=3;
P=4;
R1=5;
R2=6;
R3=7;

//from "RP-25 2009.07.pdf":
rp25_profiles = [
[0.175,0.048,0.127,0.045,0.015,0.025,0.028,0.028],
[0.145,0.039,0.106,0.036,0.013,0.021,0.023,0.023],
[0.126,0.036,0.090,0.028,0.012,0.018,0.021,0.021],
[0.116,0.031,0.085,0.026,0.011,0.014,0.018,0.018],
[0.110,0.030,0.080,0.025,0.010,0.014,0.018,0.018],
[0.093,0.026,0.067,0.020,0.009,0.009,0.017,0.017],
[0.088,0.025,0.063,0.023,0.009,0.012,0.015,0.015],
[0.079,0.023,0.056,0.020,0.008,0.011,0.014,0.014],
[0.072,0.020,0.052,0.020,0.008,0.010,0.012,0.012],
[0.054,0.014,0.040,0.016,0.007,0.008,0.009,0.009],
];

function rp25_polygon(code=code_79, tire_width=0.045) = [
	[0, tire_width, 0.0],
	[rp25_profiles[code][N], tire_width, 0.0],
	[rp25_profiles[code][N], rp25_profiles[code][D]-rp25_profiles[code][P], 0.0],
	[rp25_profiles[code][N]-rp25_profiles[code][T]/2, 0.0, rp25_profiles[code][R3]],
	[rp25_profiles[code][N]-rp25_profiles[code][T]-rp25_profiles[code][R1]/2,  rp25_profiles[code][D]-rp25_profiles[code][P], rp25_profiles[code][R1]],
	[rp25_profiles[code][N]- rp25_profiles[code][T]-rp25_profiles[code][R1],  rp25_profiles[code][D], rp25_profiles[code][R1]],
	[0, rp25_profiles[code][D]+0.001, 0.003]
];


module rp25_tire(code, radius=0.5, tire_width=0.045) {
	translate([0,0,rp25_profiles[code][N]]) 
		rotate_extrude() 
			translate([-radius, 0, 0]) 
				rotate([0,0,-90]) 
					polygon(polyRound(rp25_polygon(code, tire_width), 30));
}
