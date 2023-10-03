include <../lib/RP25_wheels.scad>

//take the place of references to old code79 variables:
No=0.079;
To=0.023;
Wo=0.056;

module wheel() {
	rp25_tire(code_79,  (24/87)/2, 0.045);  //make a 24" 1:1 wheel, in HO inches
	cylinder(r=(24/87)/2-To, h=To*3); //fill in the center
}


module driver_set() {
	//wheels:
	gauge=((3*12)/87); //HOn3
	translate([0,-gauge/2+To,0]) rotate([90,20,0]) wheel();
	translate([0,gauge/2-To,0]) rotate([-90,75,0]) wheel();
	//axle:
	rotate([90,0,0]) translate([0,0,-(gauge+Wo*2)/2])cylinder(d=1/16,h=gauge+Wo*2);
}

$fn =  $preview ? 90 : 180;

scale(25.4)
	driver_set();
