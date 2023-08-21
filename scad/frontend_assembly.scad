use <../lib/frontend.scad>
use <../lib/168_pilot.scad>
use <../lib/crossheadguide_hangar.scad>
include <../lib/utilities.scad>
include <../lib/globals.scad>

module frontend_assembly() {
	translate(-frontend_assembly_position) {
		//drills the front screw hole through the whole thing:
		difference() {
			translate(frontend_assembly_position) frontend();
			translate([front_screw_hole,0,-1]) cylinder(h=2, d=screwhole_0_80, $fn=90);
		}
		//adds the pilot truck pillar:
		translate([front_screw_hole,0,0.03]) hollow_cylinder(id=screwhole_0_80, od=screwhole_0_80*1.3, ht=0.05); //  cylinder(h=2, d=screwhole_0_80, $fn=90);	//smokebox-cylinderchest-frame hole

	}
	translate([-0.365,0,-0.11-0.05]) pilot();  //a bridge too far to print...
	//translate([1.3-0.05,0,-0.16]) crossheadguide_hangar();
}

$fn =  $preview ? 90 : 180;

scale(25.4) 
	frontend_assembly();
