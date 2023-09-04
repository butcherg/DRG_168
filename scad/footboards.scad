use <../lib/Round-Anything/polyround.scad>
use <../lib/utilities.scad>
//use <smokebox_boiler_firebox_assembly.scad>

//footboards are translated to their places on the model in the module, 
//in order to get the proper slant in the attachment pieces.

bracewidth=0.8;

r=0.015; 
s=0.02;
t=10;

module footboards() {
	//starboard:
	translate([0.75, 0.315, 0.52]) footboard(2.05, 0.2, 0.02, r, s, t);

	//port (around compressor):
	translate([2.08, -0.515, 0.52]) footboard(0.72, 0.2, 0.02, r, s, t);
	translate([0.75, -0.515, 0.52]) footboard(1.15, 0.2, 0.02, r, s, t);
	

	difference() {
		union() {
			translate([0.92,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
			translate([1.36,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
			translate([1.8,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
			translate([2.23,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
			translate([2.6,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
		}
		//translate([0.28,0,0.3]) smokebox_boiler_firebox($fn=90, decor=false); //carve the angle in the braces
		translate([0.7,0,0.6]) rotate([0,90,0]) cylinder(d=0.6, h=2.5); //remove remainingbrace material inside the boiler
		
	}
}

module starboard_footboard() {
	translate([0.75, 0.315, 0.52]) footboard(2.12, 0.2, 0.03, r, s, t);
	
	difference() {
		union() {
			translate([0.92,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
			translate([1.8,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
			translate([0.92+(1.8-0.92)/2,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
			translate([2.23,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
			translate([2.7,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
		}
		translate([0.28,0,0.3]) smokebox_boiler_firebox($fn=90, decor=false); //carve the angle in the braces
		//translate([0.7,0,0.6]) rotate([0,90,0]) cylinder(d=0.6, h=2.5); //remove remainingbrace material inside the boiler
		translate([0,0.285,0]) translate([0,-1,0]) cube([3,1,1]);
	}
}

module port_forward_footboard() {
	translate([0.75, -0.515, 0.52]) footboard(1.17, 0.2, 0.03, r=r, s=s, t=t);

	difference() {
		union() {
			translate([0.92,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
			translate([1.8,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
			translate([0.92+(1.8-0.92)/2,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
		}
		translate([0.28,0,0.3]) smokebox_boiler_firebox($fn=90, decor=false); //carve the angle in the braces
		//translate([0.7,0,0.6]) rotate([0,90,0]) cylinder(d=0.6, h=2.5); //remove remainingbrace material inside the boiler
		translate([0,0.717,0]) translate([0,-1,0]) cube([3,1,1]);
	}
	
}

module port_aft_footboard() {
	translate([2.08, -0.515, 0.52]) footboard(0.79, 0.2, 0.03, r, s, t);

	difference() {
		union() {
			translate([2.23,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
			translate([2.7,-bracewidth/2,0.5]) cube([0.05, bracewidth, 0.03]);
		}
		translate([0.28,0,0.3]) smokebox_boiler_firebox($fn=90, decor=false); //carve the angle in the braces
		//translate([0.7,0,0.6]) rotate([0,90,0]) cylinder(d=0.6, h=2.5); //remove remainingbrace material inside the boiler
		translate([0,0.717,0]) translate([0,-1,0]) cube([3,1,1]);
	}
	
}

$fn= $preview ? 90 : 180;
scale(25.4)
footboards();

//starboard_footboard();
//port_forward_footboard();
//port_aft_footboard();

//integration:
//translate([0.28,0,0.3]) smokebox_boiler_firebox($fn=90, decor=true); //alignment marker
//color("gray") translate([0.28,0,0.3]) smokebox_boiler_firebox($fn=90, decor=false); //alignment marker
//translate([0,0,0.302+0.61/2]) rotate([-111,0,0]) translate([0,0.005/2, 0]) cube([3, 0.005, 2 ]); //glue marker, 110 degrees off 