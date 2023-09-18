include <../lib/utilities.scad>
include <../lib/globals.scad>

framelength=2.5-adjustment20230705;
framewidth=0.31;  //0.25 to accomodate the firebox overhangs, would prefer 0.29 but oh well...
frameheight=0.275;
framethickness=0.06;

rivetfn=10;

module driverslot(framewidth=0.25, slot=0.129, axle=0.125, slotdepth=0.0, detentdepth=0.02)
{
	translate([0,-framewidth/2,0]) {
		translate([0,0,detentdepth]) {
			cube([slot,framewidth*2,(slot/2)+slotdepth]);
			translate([slot/2,0,(slot/2)+slotdepth]) rotate([-90,0,0]) cylinder(d=slot, h=framewidth*2);
		}
		translate([(slot-axle)/2,0,0.001]) cube([axle,framewidth*2,detentdepth]);  //detent
	}
}

module driver_slots() {
	//-0.75 is to accommodate the new frame position...
	front=0.79-adjustment20230705;
	main=1.39-adjustment20230705;
	rear=2.37-adjustment20230705;
	slot=0.129;
	axle=0.129; //axle retention detent...
	slotdepth=0.02;

	translate([front-slot/2,-0.001,-0.002]) 
		driverslot(framewidth=framewidth, slot=slot, axle=axle, slotdepth=slotdepth, detentdepth=0.02);
	translate([main-slot/2,-0.001,-0.002])
		driverslot(framewidth=framewidth, slot=slot, axle=axle, slotdepth=slotdepth, detentdepth=0.02);
	translate([rear-slot/2,-0.001,-0.002])
		driverslot(framewidth=framewidth, slot=slot, axle=axle, slotdepth=slotdepth, detentdepth=0.02);
	
}

module frame_voids() {
	//valvegear hangar mounting slot:
	translate([0.54-adjustment20230705, -0.35, 0.19]) cube([0.02, 1, 0.1]);
	
	//frame voids:
	translate([1.53-adjustment20230705,0,0.06]) 
		//wedge(0.7, 0.7, 0.14);
		wedge(0.65, 0.7, 0.14);
	translate([0.92-adjustment20230705,-.16,.059]) cube([.33,.6,.13]);
	
	//propulsion cutout:
	//translate([0.55,framethickness,0]) cube([0.5, framewidth-framethickness*2, 0.5]); //front driver
	//main driver???
}

module furnace_bearer() {
	l=0.06;
	cylinder(d=0.037, h=0.011);
	cylinder(d=0.017, h=0.018);
	translate([l,0,0]) cylinder(d=0.037, h=0.011);
	translate([l,0,0]) cylinder(d=0.017, h=0.018);
	translate([0, -0.01,0]) cube([l, 0.02, 0.011]);
}

module furnace_bearer_plate() {
	furnace_bearer_plate_pts = [
		[0,0],
		[0,0.08],
		[0.08,0.08],
		[0.08,0.017],
		[0,0]
	];

	rotate([90,0,0])
		linear_extrude(0.02) polygon(furnace_bearer_plate_pts);
	
	translate([0.002,-0.019,0.01])
		rotate([90,-11,0])
			rivet_course_rounded(0.01, 0.07, 0.01, 0.02, $fn=rivetfn);
	translate([0.002,-0.019,0.07])
		rotate([90,0,0])
			rivet_course_rounded(0.01, 0.07, 0.01, 0.02, $fn=rivetfn);
	translate([0.002,-0.019,0.04])
		rotate([90,0,0])
			rivet_course_rounded(0.01, 0.02, 0.01, 0.02, $fn=rivetfn);
	translate([0.06,-0.019,0.045])
		rotate([90,0,0])
			rivet_course_rounded(0.01, 0.02, 0.01, 0.02, $fn=rivetfn);
}

module frame(tab=true) {
	//tablength=0.25; //extend in the cylinder block far enough to engage the screw hole...
	//K&S brass strip sku #8245, 0.064" thick, 1/4" wide, 12" long
	tabthickness=0.064;
	tabwidth=0.25;
	
	frame_offset = 0.585;
	//translate([0,-framewidth/2,0]) 
		difference() {
			translate([frame_offset,-framewidth/2,0]) cube([framelength-frame_offset, framewidth, frameheight]);
			driver_slots();
			frame_voids();
			platewidth=0.25;  //width of the K&S 1/4" bar stock
			//center channel:
			translate([0,-0.18/2,-0.001])  cube([framelength*1.1, 0.18, 0.16]);
			//driver plate channel
			translate([0,-platewidth/2,-0.001])  cube([framelength*1.1, platewidth, 0.03]);
			//spine channel: (spine is 1/16 thick, 1/15 embeds it a little more...
			translate([0,-platewidth/2,frameheight-1/15])  cube([framelength*1.1, platewidth, 0.5]);
			
		}
		

	//bottom plate fastening blocks:
	blockoffset=0.029;
	blockthickness=0.03;
	screwhole_tap=0.8; //multiplier to reduce screwhole size for tapping
	difference() {
		translate([0.985-adjustment20230705,-framewidth/2,blockoffset]) cube([0.2, framewidth, blockthickness]);
		translate([1.085-adjustment20230705, 0, 0]) cylinder(h=2, d=screwhole_0_80*screwhole_tap, $fn=90);
	}
	difference() {
		translate([1.885-adjustment20230705,-framewidth/2,blockoffset]) cube([0.2, framewidth, blockthickness]);
		translate([1.985-adjustment20230705, 0, 0]) cylinder(h=2, d=screwhole_0_80*screwhole_tap, $fn=90);
	}

	translate([1.495, -framewidth/2,0.1])
		rotate([90,-90,0])
			rivet_course_rounded(0.01, 0.15, 0.01, 0.02, $fn=rivetfn);
	translate([1.505, -framewidth/2,0.11])
		rotate([90,-90,0])
			rivet_course_rounded(0.01, 0.15, 0.01, 0.02, $fn=rivetfn);
			
	translate([1.495, framewidth/2,0.1])
		rotate([-90,-90,0])
			rivet_course_rounded(0.01, 0.15, 0.01, 0.02, $fn=rivetfn);
	translate([1.505, framewidth/2,0.11])
		rotate([-90,-90,0])
			rivet_course_rounded(0.01, 0.15, 0.01, 0.02, $fn=rivetfn);

	translate([1.50, -framewidth/2,0.1])
		rotate([90,-13,0])
			rivet_course_rounded(0.01, 0.55, 0.01, 0.02, $fn=rivetfn);
	translate([1.50, framewidth/2,0.1])
		rotate([-90,-13,0])
			rivet_course_rounded(0.01, 0.55, 0.01, 0.02, $fn=rivetfn);

	
	
	translate([1.66,-framewidth/2+0.015,0.132])
		furnace_bearer_plate();
	translate([1.66,framewidth/2-0.015,0.132])	
		mirror([1,0,0]) 
			rotate([0,0,180])
				furnace_bearer_plate();

	translate([1.7,-framewidth/2,0.12])
		rotate([90,-90,0])
			furnace_bearer();
	translate([1.7,framewidth/2,0.12])
		rotate([90,-90,180])
			furnace_bearer();
}

$fn = $preview ? 90 : 180;

scale(25.4)
	difference() {
		frame();
		//frame screw holes, with x values from globals.scad:
		translate([front_screw_hole,0,-1]) cylinder(h=2, d=screwhole_0_80, $fn=90);
		translate([rear_screw_hole,0,-1]) cylinder(h=2, d=screwhole_0_80, $fn=90);
	}
