use <Round-Anything/polyround.scad>

function contains(match, string) = search(match, string) == [0] ? true : false;

echo(contains("a", "abcdabcd"));

code_297=0;
code_250=1;
code_208=2;
code_172=3;
code_148=4;
code_125=5;
code_100=6;
code_83=7;
code_70=8;
code_55=9;
code_40=10;
code_32=11;


rp15_profiles = [
[0.297,0.250,0.125,0.050,0.083,0.062,0.016],
[0.250,0.224,0.112,0.044,0.073,0.055,0.014],
[0.208,0.188,0.094,0.038,0.063,0.047,0.012],
[0.172,0.156,0.078,0.031,0.052,0.039,0.010],
[0.148,0.132,0.066,0.026,0.044,0.033,0.009],
[0.125,0.125,0.063,0.021,0.035,0.028,0.007],
[0.100,0.090,0.045,0.018,0.030,0.023,0.006],
[0.083,0.080,0.040,0.016,0.027,0.020,0.005],
[0.070,0.070,0.035,0.014,0.023,0.017,0.004],
[0.055,0.055,0.028,0.011,0.018,0.014,0.004],
[0.040,0.040,0.020,0.008,0.013,0.010,0.003],
[0.032,0.032,0.016,0.006,0.011,0.008,0.003],
];

module rp15_polygon(code, W) {
	A = rp15_profiles[code][0];
	B = rp15_profiles[code][1];
	C = rp15_profiles[code][2];
	D = rp15_profiles[code][3];
	F = rp15_profiles[code][4];
	H = rp15_profiles[code][5];
	R = rp15_profiles[code][6];
	P = ((B/2) - (W/2)) * tan(15);  //proper slope of base-web intersection
	profile_pts = [
		[0, 0, 0],
		[0, D-R, R],
		[(B/2)-(W/2), D-R+P, R],
		[(B/2)-(W/2), A-H, R],
		[(B/2)-(C/2), A-H+(R/2), R],
		[(B/2)-(C/2), A, R],
		[(B/2)+(C/2), A, R],
		[(B/2)+(C/2), A-H+(R/2), R],
		[(B/2)+(W/2), A-H, R],
		[(B/2)+(W/2), D-R+P, R],
		[B, D-R, R],
		[B, 0, 0],
		[0, 0, 0]
	];
	polygon(polyRound(profile_pts, 30));
}

/*
rp15_rail(): makes a length of rail

parameters:
	- code: one of the code_xx variables
	- length: length of the rail segment
	- side: "left" or "right", puts the specified side of the railhead at the origin
*/
module rp15_rail(code, length, side) {
	A = rp15_profiles[code][0];
	B = rp15_profiles[code][1];
	C = rp15_profiles[code][2];
	C2 = side == "left" ? -C/2 : C/2;
	translate([0,-B/2+C2,-A])
		rotate([90,0,90])
			linear_extrude(length) 
				rp15_polygon(code, 0.015);
}

module hon3_railsegment(length=6) {
	translate([0,((3*12)/87)/2, 0]) rp15_rail(code_83, length, "right");
	translate([0,-((3*12)/87)/2, 0]) rp15_rail(code_83, length, "left");
}


