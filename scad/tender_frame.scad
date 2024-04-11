
use <../lib/Round-Anything/polyround.scad>
use <../lib/utilities.scad>
include <../lib/globals.scad>

/*
// for integration:
use <cistern.scad>  //for cistern spacers
use <tender_truck.scad>

*/

frame_length=2.85;  //from Pruitt
frame_width=0.77;  //from DSZ_1511
frame_height=0.10; //from DSZ_1511
frame_member_width=0.06; //guesstimate...

plank_thickness=0.023;
plank_width=0.12;
plank_spacing=0.02;

module plank(length) {
	plank_pts = [
		[0,0,0],
		[0,plank_thickness,plank_thickness/10],
		[plank_width, plank_thickness, plank_thickness/10],
		[plank_width, 0,0],
		[0,0,0]
	];
	translate([0,length/2,0])
	rotate([90,0,0])
	linear_extrude(length) polygon(polyRound(plank_pts, 10));
}

module tender_frame() {
	
	//sills:
	translate([0,(frame_width/2)-frame_member_width,0]) 
		cube([frame_length,frame_member_width, frame_height]);
	translate([0,(frame_width/4)-frame_member_width*1.5,0]) 
		cube([frame_length,frame_member_width, frame_height]);
	translate([0,-frame_width/4+frame_member_width,0]) 
		cube([frame_length,frame_member_width, frame_height]);
	translate([0,-frame_width/2,0]) 
		cube([frame_length,frame_member_width, frame_height]);
	
	//endbeams:
	translate([frame_length-frame_member_width,-frame_width/2,0]) 
		cube([frame_member_width, frame_width, frame_height]);
	translate([0,-frame_width/2,0]) 
		cube([frame_member_width, frame_width, frame_height]);
		
	//planks:
	translate([0, 0,frame_height])
		plank(frame_width);
	translate([plank_width+0.001, 0,frame_height])
		plank(frame_width);
	translate([(plank_width+0.001)*2, 0,frame_height])
		plank(frame_width-0.08);
	translate([(plank_width+0.001)*3, 0,frame_height])
		plank(frame_width-0.08);
	
	for (i=[(plank_width+0.001)*4 : plank_width*1.2 : frame_length-0.25]) {
		translate([i,0,frame_height]) plank(0.83);
	}
	
	translate([(frame_length-plank_width), 0,frame_height])
		plank(frame_width);
	translate([(frame_length-plank_width*2), 0,frame_height])
		plank(frame_width);
		
	//truck bolsters:
	translate([0.705,0,0.045])
		truck_bolster(width=frame_width, height=frame_height, thick=0.07, pad=0.1, padheight=0.03);
	translate([2.405,0,0.045])
		truck_bolster(width=frame_width, height=frame_height, thick=0.07, pad=0.1, padheight=0.03);
	
	//cistern positioning keys:
	rear_key_length=frame_width-0.06;
	translate([frame_length-0.345,-rear_key_length/2,frame_height]) 
		cube([0.1, rear_key_length, 0.1]);
	translate([0.5, (-0.09/2)+frame_width/2-0.047, frame_height]) 
		cube([0.5, 0.09, 0.09]);
	translate([0.5, (-0.09/2)-frame_width/2+0.047, frame_height]) 
		cube([0.5, 0.09, 0.09]);
}

scale(25.4) {
	//translate(tender_frame_position) 
		tender_frame();
	/*
	translate(cistern_position) 
		difference() {
			cistern();
			translate([-0.1,-frame_width,0.1])cube([frame_length,frame_width*2,1]);
		}
	*/
	/*
	tender_truck_z=-0.08;
	translate([3.2,0,tender_truck_z]) color("green") tender_truck();
	translate([4.9,0,tender_truck_z]) color("green") tender_truck();
	*/
}