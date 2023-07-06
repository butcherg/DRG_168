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

module driver() {
	rp25_tire((12/25.4)/2, rp25_code79_profile);
	//translate([0,0,-N])
		hollow_cylinder(od=10/25.4, id=9/25.4, ht=N*0.9);

	spokes=10;
	difference() {
		//translate([0,0,-0.04]) 
		translate([0,0,N/2])
			union() {
				//spokes:
				for(angle = [0:360/spokes:360]) 
					rotate([0,0,angle]) rotate([90,0,0]) cylinder(d=0.04, h=(9/25.4)/2);
				//
				rotate([0,0,17]) translate([0,-0.08/2,-0.06/2]) roundedbox([0.12,0.08,0.06], 0.02);
			}
		translate([0,0,-0.25]) cylinder(d=0.07, h=0.5);
	}
	
	//counterweight:
	difference() {
		translate([0,0,0.06]) pie_slice(36*4+4,N/4,(9/2)/25.4,94+30);  
		//translate([0,0,-N]) pie_slice(90,N*2,(4.5/2)/25.4);
		translate([0,0,-N/2]) cylinder(d=(9.7/2)/25.4, h=N*2);
	}
}


module driver_set() {
	gauge=((3*12)/87);
	translate([0,-gauge/2+T,0]) rotate([90,20,0]) driver();
	translate([0,gauge/2-T,0]) rotate([-90,75,0]) driver();
	rotate([90,0,0]) translate([0,0,-(gauge+W*2)/2])cylinder(d=1/8,h=gauge+W*2);
}

$fn =  $preview ? 90 : 180;

scale(25.4)
	driver_set();
