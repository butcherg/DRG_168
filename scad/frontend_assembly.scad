use <../lib/frontend.scad>
use <../lib/168_pilot.scad>
use <../lib/crossheadguide_hangar.scad>

$fn =  $preview ? 90 : 180;

scale(25.4) {
	frontend();
	translate([-0.365,0,-0.11-0.05]) pilot();
	translate([1.3,0,-0.16]) crossheadguide_hangar();
}
