include <../lib/globals.scad>
include <../lib/rp15_rail.scad>


import("frame.stl");

//brass frame spine:
difference() {
	translate([-0.25,-1/8,0.27-1/16]*25.4) cube([2.425+0.25,1/4,1/16]*25.4);
	translate([front_screw_hole*25.4,0,0]) cylinder(d=0.125*25.4, h=1*25.4, $fn=90);
	translate([rear_screw_hole*25.4,0,0]) cylinder(d=0.125*25.4, h=1*25.4, $fn=90);
	//translate(crossheadguide_hangar_position*25.4) import("crossheadguide_hangar.stl"); //make the notch for the crossheadguide hangar
}

translate(frontend_assembly_position*25.4) import("frontend_assembly.stl");

translate(smokebox_boiler_firebox_position*25.4) import("smokebox_boiler_firebox_assembly.stl");
translate(smokebox_front_position*25.4) import("smokebox_front.stl");
translate(168_plate_position*25.4) import("168_plate.stl");
translate(headlamp_position*25.4) import("headlamp.stl");

translate(bell_hangar_assembly_position*25.4) rotate([0,0,90]) import("bell_hangar_assembly.stl");
translate(generator_position*25.4) import("generator.stl");
translate(compressor_position*25.4) import("compressor.stl");

translate(cab_position*25.4) import("cab.stl");
translate(firebox_backhead_position*25.4)  import("firebox_backhead.stl");

translate([front_driver,0,0.09]*25.4) import("driver_set.stl");
translate([main_driver,0,0.09]*25.4) import("driver_set.stl");
translate([rear_driver,0,0.09]*25.4) import("driver_set.stl");

translate(crossheadguide_hangar_position*25.4) import("crossheadguide_hangar.stl");

translate(port_crosshead_position*25.4) import("crosshead.stl");
translate(starboard_crosshead_position*25.4) import("crosshead.stl");
translate(port_siderod_position*25.4) import("siderod.stl");
translate(starboard_siderod_position*25.4) import("siderod.stl");
translate(port_connecting_rod_position*25.4) rotate([0,-0.5,0]) import("connecting_rod.stl");
translate(starboard_connecting_rod_position*25.4) rotate([0,4.2,0]) import("connecting_rod.stl");

translate(cistern_position*25.4) import("cistern.stl");
translate(tender_frame_position*25.4) import("tender_frame.stl");

tender_truck_z=-0.07;
translate([3.2,0,tender_truck_z]*25.4) import("tender_truck.stl");
translate([4.9,0,tender_truck_z]*25.4) import("tender_truck.stl");

translate([3.256,0,tender_truck_z+0.06]*25.4) import("wheel_set.stl");
translate([3.256+0.564,0,tender_truck_z+0.06]*25.4) import("wheel_set.stl");
translate([4.95,0,tender_truck_z+0.06]*25.4) import("wheel_set.stl");
translate([4.95+0.564,0,tender_truck_z+0.06]*25.4) import("wheel_set.stl");

//positioning aids:

//handrails:
translate([-0.4,0.248,0.905]*25.4) 
	rotate([0,90,0]) {
		cylinder(d=0.02*25.4, h=2.48*25.4, $fn=90);
		sphere(0.017*25.4, $fn=90);
	}
translate([-0.4,-0.248,0.905]*25.4) 
	rotate([0,90,0]) {
		cylinder(d=0.02*25.4, h=2.48*25.4, $fn=90);
		sphere(0.017*25.4, $fn=90);
	}

module front_handrail() {
	rotate_extrude(angle=90, convexity=10, $fn=90) 
		translate ([(0.61/2)*25.4,0,0]) 
			circle(d=0.02*25.4, $fn=90);
	rotate([0,0,-2])
		translate ([(0.61/2)*25.4,0,0])
			sphere(0.017*25.4, $fn=90);
	rotate([0,0,93])
		translate ([(0.61/2)*25.4,0,0])
			sphere(0.017*25.4, $fn=90);
}

translate([-0.615*25.4,0,0.585*25.4])
	rotate([0,90,0])
		rotate([0,0,90+45])
			front_handrail();

translate([-40,0,-3.2]) scale(25.4) hon3_railsegment(8);
