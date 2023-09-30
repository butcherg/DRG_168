include <../lib/RP25_wheels.scad>

module driver() {
	rp25_tire((12/25.4)/2, rp25_code79_profile);  //make a 12mm driver, in inches
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
	difference() {
		union() {
			translate([0,-gauge/2+T,0]) rotate([90,20,0]) driver();
			translate([0,gauge/2-T,0]) rotate([-90,75,0]) driver();
			//axle:
			rotate([90,0,0]) translate([0,0,-(gauge+W*2)/2])cylinder(d=1/8,h=gauge+W*2);
		}
		//siderod pins:
		translate([0.091,-0.15,-0.003]) rotate([90,0,0]) cylinder(d=0.03, h=0.12);
		translate([-0.004,0.15,-0.091]) rotate([-90,0,0]) cylinder(d=0.03, h=0.12);
	}
}

$fn =  $preview ? 90 : 180;

scale(25.4)
	driver_set();
