use <../lib/Round-Anything/polyround.scad>
use <../lib/utilities.scad>

//Code 79:
N=0.079;
T=0.023;
W=0.056;
D=0.020;
P=0.008;
R1=0.011;
R2=0.014;
R3=0.014;

TT=0.045; //tire width

rp25_code79_profile= [
	[0, TT, 0.0],
	[N, TT, 0.0],
	[N, D-P, 0.0],
	[N-T/2, 0.0, R3],
	[N-T-R1/2, D-P, R1],
	[N-T-R1, D, R1],
	[0, D+0.001, 0.003]
];

module rp25_profile(profile) {
	polygon(polyRound(profile, 30));
}

module rp25_tire(radius=0.5, profile) {
	translate([0,0,N]) 
		rotate_extrude() 
			translate([-radius, 0, 0]) 
				rotate([0,0,-90]) 
					polygon(polyRound(profile, 30));
}

