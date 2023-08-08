include <../lib/Round-Anything/polyround.scad>

module 168_plate() {
	extrudeextent = 0.03;
	
	rim_pts = [
		[0,0,0],
		[0,extrudeextent,0.01],
		[0.02, extrudeextent, 0.01],
		[0.02, 0, 0.01],
		[0,0,0]
	];

	fontpts=0.07;
	
	translate([-0.08,-fontpts/2,0]) {
		render() difference() {
			//extrudeWithRadius(extrudeextent,0,fontpts) 
			linear_extrude(extrudeextent) 
				text("1",fontpts);
			union() {
				cube([fontpts/2,fontpts/2,extrudeextent*3], center=true);
				translate([fontpts*0.8,0,0]) cube([fontpts/2,fontpts/2,extrudeextent*3], center=true);
				translate([0,fontpts*0.8,0]) cube([fontpts/2,fontpts/2,extrudeextent*3], center=true);
			}
		}
		translate([fontpts/1.6,0,0]) 
			//extrudeWithRadius(extrudeextent,0,fontpts) 
			linear_extrude(extrudeextent) 
				text("68",fontpts);
	}

	color("#ff0000") cylinder(d=0.18, h=extrudeextent/2);
	rotate_extrude(angle=360) translate([0.08,0,0]) polygon(polyRound(rim_pts, 10));
	translate([0,0,-0.09]) cylinder(d=0.03, h=0.1);
}


$fn = $preview ? 90 : 90;

scale(25.4)
	rotate([90,0,270]) 168_plate();
