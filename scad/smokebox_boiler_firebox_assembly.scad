use <../lib/smokebox.scad>
use <../lib/boiler.scad>
use <../lib/firebox.scad>

use <../lib/smokestack.scad>
use <../lib/sanddome.scad>
use <../lib/steamdome.scad>

include <../lib/utilities.scad>
include <../lib/globals.scad>

use <footboards.scad>

//for placement dimples :
//use <compressor.scad>
//use <generator.scad>

module smokebox_boiler_firebox(decor=true) {
	translate(-smokebox_boiler_firebox_position) {
		difference () {
			translate(smokebox_boiler_firebox_position) smokebox(decor);
			translate([front_screw_hole,0,0]) cylinder(h=2, d=screwhole_0_80, $fn=90);
		}
		translate([front_screw_hole,0,0.325]) nutretainer_0_80(d=0.21);
	}
	
	translate([0.6,0,0]) boiler(decor);

	difference() { //placement dimples
		translate([1.48,0,0]) firebox(decor);
		//compressor dimples, top:
		translate([1.672,0,0.65/2])
			rotate([62.5,0,0])
				translate([0,-0.03/2,0.65/2-0.005]) 
					cube([0.035,0.03,0.5]);
		translate([1.797,0,0.65/2])
			rotate([62.6,0,0])
				translate([0,-0.03/2,0.65/2-0.005]) 
					cube([0.035,0.03,0.5]);
		//generator dimples, front:
		translate([2.37,0,0.65/2])
			rotate([-19,0,0])
				translate([0,-0.03/2,0.65/2-0.005]) 
					cube([0.035,0.03,0.5]);
		translate([2.37,0,0.65/2])
			rotate([19,0,0])
				translate([0,-0.03/2,0.65/2-0.005]) 
					cube([0.035,0.03,0.5]);
	}
}

module smokebox_boiler_firebox_assembly() {
	smokebox_boiler_firebox();
	translate([0.3,0,0.58]) smokestack();
	translate([0.805,0,0.52]) sanddome();
	translate([1.76,0,0.565]) steamdome();
	translate([-0.23,0,-0.29]) footboards();
}

$fn =  $preview ? 90 : 180;

scale(25.4) { 
	smokebox_boiler_firebox_assembly();
	//translate(compressor_position-smokebox_boiler_firebox_position)rotate([0,0,90])compressor();
	//translate(generator_position-smokebox_boiler_firebox_position)generator();
}
