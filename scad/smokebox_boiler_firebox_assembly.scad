use <../lib/smokebox.scad>
use <../lib/boiler.scad>
use <../lib/firebox.scad>

use <../lib/smokestack.scad>
use <../lib/sanddome.scad>
use <../lib/steamdome.scad>

use <footboards.scad>

module smokebox_boiler_firebox(decor=true) {
	smokebox(decor);
	translate([0.6,0,0]) boiler(decor);
	translate([1.48,0,0]) firebox(decor);
}

$fn =  $preview ? 90 : 180;

scale(25.4) {
	smokebox_boiler_firebox();
	translate([0.3,0,0.58]) smokestack();
	translate([0.805,0,0.52]) sanddome();
	translate([1.76,0,0.565]) steamdome();
	translate([-0.23,0,-0.29]) footboards();
}
