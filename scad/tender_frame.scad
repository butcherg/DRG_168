
use <../lib/Round-Anything/polyround.scad>

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
	

}

scale(25.4) {
	tender_frame();
}