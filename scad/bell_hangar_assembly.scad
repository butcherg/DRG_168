use <../lib/bell.scad>
use <../lib/bellhangar.scad>

$fn =  $preview ? 90 : 180;

scale(25.4) {
	translate([0, 0, 0.02]) bell();
	bellhangar();
}