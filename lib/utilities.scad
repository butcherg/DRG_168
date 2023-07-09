use <Round-Anything/polyround.scad>
use <path_extrude.scad>

//used with path_extrude to make paths that have been rounded with polyRound():
function addnum(v, n) =
		[for (i = v) concat(i, n)];

//common definitions:
//screwhole_0_80=0.061; //screw width at thread edge, per spec. 
screwhole_0_80=1/16; // 0.0625, wider than spec to allow slip-in.

//makes a disk with a hex cutout to accommodate a 0-80 nut:
module nutretainer_0_80(d=(5/32)*2) {
	widthacrossflats= 5/32;
	height=3/64;
	difference() {
		cylinder(d=d, h=height*1.1);
		translate([0, 0, -height]) cylinder(d=widthacrossflats*1.2, h=height*3, $fn=6);
	}
}

module half_sphere(d=1) {
	r=d/2;
	pts = [
		[0,0,0],
		[0,r,0],
		[r,r,r],
		[r,0,0]
	];
	rotate_extrude(angle=360) polygon(polyRound(pts, 20));
}

//makes a "rope rectangle":
function addnum(v, n) =
		[for (i = v) concat(i, n)];

module rope_rectangle(l=1, w=0.5, d=0.05, f=30) {
	rect_pts = [
		[0,0,d],
		[0,l,d],
		[w,l,d],
		[w,0,d]
		//[0,0,0]
	];
	circle_pts = [
		[0,0,d/2],
		[0,d,d/2],
		[d,d,d/2],
		[d,0,d/2]
	];
	circle_pts1 = [
		[0,0],
		[0,d],
		[d,d],
		[d,0],
		[0,0]
	];
	path_pts = addnum(polyRound(rect_pts, f),0);
	shape_pts = polyRound(circle_pts,f);
	path_extrude(exPath=path_pts, exShape=shape_pts);
	translate([d,d/2,-d/2]) rotate([0,90,0]) linear_extrude(w-d*2) circle(d=d, $fn=f*4);
}




/** 
	\file utilities.scad
	\brief Contains modules useful in defining locomotive parts.
	\/verbinclude utilities.scad
*/

/**
	* \def trapezoid(ottomline, topline, toplineheight, toplineoffset, radius=0)
	* \brief	Generates a trapezoid, optionally with rounded corners
	* \param	bottomline	length of the bottom paralell line, along the X axis
	* \param	topline		length of the top line parallel to the bottom line
	* \param	toplineheight	distance between the top and bottom lines
	* \param	toplineoffset	offseet of the top line from the Y axis
	* \param	radius(optional)	if specified, the radius of the rounding of the trapezoid corners
*/
module trapezoid(bottomline, topline, toplineheight, toplineoffset, radius=0)
{
	if (radius > 0) {
		pts = [
			[0,0,radius],
			[toplineoffset, toplineheight, radius],
			[toplineoffset+topline, toplineheight, radius],
			[bottomline, 0, radius]
		];
		polygon(polyRound(pts,30));
	}
	else {
		pts = [
			[0,0],
			[toplineoffset, toplineheight],
			[toplineoffset+topline, toplineheight],
			[bottomline, 0]
		];
		polygon(pts);
	}
}

//trapezoid(10,5,5,1,1);


module wedge(x, y, z) {
	pts = [
		[0,0],
		[x,0],
		[x,z],
		[0,0]
	];
	translate([0,y/2,0]) rotate([90,0,0]) 
	linear_extrude(y) polygon(pts);
}

module wedge_angle(z, y, angle) {
	c = z/sin(angle);
	b = sqrt(c*c-z*z);
	pts = [
		[0,0],
		[b,0],
		[0,z],
		[0,0]
	];
	translate([0,y/2,0]) rotate([90,0,0]) 
	linear_extrude(y) polygon(pts);
}

module triangle(x,y,z) {
	pts = [
		[0,0],
		[x,0],
		[x/2,z],
		[0,0]
	];
	translate([0,y/2,0]) rotate([90,0,0]) 
	linear_extrude(y) polygon(pts);
}

module pie_slice(ang=30, l=1, r=1, spin=0)
{
	rotate([0,0,spin])
		difference() {
			cylinder(r=r, h=l);
			translate([-r, -r, -l/2]) 
				cube([r*2,r,l*2]);
			rotate([0,0,ang])
				translate([-r, 0, -l/2]) 
					cube([r*2,r,l*2]);
		}
}


//frame_channel() - renders a U-channel for frame construction
module frame_channel(length=3,width=0.22,height=0.32,thickness=0.02)
{
	difference() {
		cube([length, width, height]);
		translate([-.2,thickness,-thickness]) 
	cube([length+1, width-(thickness*2), height]);
	}
}

module frame_slot(framewidth=0.25, slot=0.129, axle=0.125, slotdepth=0.0, detentdepth=0.02)
{
        translate([0,-framewidth/2,0]) {
                translate([0,0,detentdepth]) {
                        cube([slot,framewidth*2,(slot/2)+slotdepth]);
                        translate([slot/2,0,(slot/2)+slotdepth]) rotate([-90,0,0]) cylinder(d=slot, h=framewidth*2);
                }
                translate([(slot-axle)/2,0,0.001]) cube([axle,framewidth*2,detentdepth]);  //detent
        }
}

// roundedbox -  makes a box with rounded vertical corners
module roundedbox(size=[1,1,1], radius=0.3, centered=false) 
{
	rx= centered? radius - size[0]/2: radius;
	ry= centered? radius - size[1]/2: radius;
	
	translate([rx, ry, 0])
	minkowski() {
		cube([size[0]-radius*2,size[1]-radius*2, size[2]/2]);
		//cube([size[0]-radius,size[1]-radius, size[2]/2]);
		cylinder(r=radius, h=size[2]/2);
	}
}

module roundedRect(size, radius, center=false) 
{
	x = size[0];
	y = size[1];
	z = size[2];
	
	translate([center?-x/2:0, center?-y/2:0, center?-z/2:0])
	linear_extrude(height=z) 
	hull() {
		translate([radius, radius, 0])
		circle(r=radius);
		
		translate([x - radius, radius, 0])
		circle(r=radius);
		
		translate([x - radius, y - radius, 0])
		circle(r=radius);
		
		translate([radius, y - radius, 0])
		circle(r=radius);
	}
}

module hollow_cylinder(od=0.6, id=0.55, ht=0.5)
{
	difference() {
		cylinder(d=od, h=ht);
		translate([0,0,-ht/2]) cylinder(d=id, h=ht*2);
	}
}


//rivet_*() - renders a rivet course.
//rivet_course() - linear course, spacing in linear measurement
//rivet_cylinder() - radial course along a diameter, spacing in degrees
//rivet_circle() - radial face along a diameter, spacing in degrees

rivet_height = 0.01;
rivet_diameter = 0.02;
rivet_top=0.005;

module rivet_cylinder(diameter=0.2, start_deg=0, end_deg=90, spacing_deg=10) 
{
	for(angle = [start_deg: spacing_deg : end_deg])
		rotate([angle, 0, 0])
			translate([0,0,diameter])
				cylinder(d1=rivet_diameter, d2=rivet_top, h=rivet_height);
}

module rivet_cylinder_rounded(diameter=0.5, start_deg=0, end_deg=90, rivet_diameter=0.05, spacing_deg=10) 
{
	for(angle = [start_deg: spacing_deg : end_deg])
		rotate([angle, 0, 0])
			translate([0,0,diameter])
				half_sphere(rivet_diameter);
}

module rivet_corner_rounded(diameter=0.5, start_deg=0, end_deg=90, rivet_diameter=0.05, spacing_deg=10) 
{
	for(angle = [start_deg: spacing_deg : end_deg])
		rotate([angle, 0, 0])
			translate([0,0,diameter])
	//			translate([0,0,rivet_diameter/2]) 
					rotate([180,0,0])
						half_sphere(rivet_diameter);
}

module rivet_circle(diameter=0.2, start_deg=0, end_deg=90, rivet_diameter=0.05, spacing_deg=10) 
{
	for(angle = [start_deg: spacing_deg : end_deg])
		rotate([angle, 0, 0])
			translate([0,0,diameter])
				rotate([0,-90,0]) cylinder(d1=rivet_diameter, d2=rivet_top, h=rivet_height);
}

module rivet_circle_rounded(diameter=0.2, start_deg=0, end_deg=90, rivet_diameter=0.05, spacing_deg=10) 
{
	for(angle = [start_deg: spacing_deg : end_deg])
		rotate([angle, 0, 0])
			translate([0,0,diameter])
				rotate([0,-90,0]) 
					//cylinder(d1=rivet_diameter, d2=rivet_top, h=rivet_height);
					half_sphere(rivet_diameter);
}

module rivet_course(start_x= 0, end_x=1, spacing=0.1) 
{
	for(pos = [start_x: spacing : end_x])
			translate([pos, 0, 0])
				cylinder(d1=rivet_diameter, d2=rivet_top, h=rivet_height);
}

module rivet_course_rounded(start_x= 0, end_x=1, rivet_diameter = 0.05, spacing=0.1) 
{
	for(pos = [start_x: spacing : end_x])
			translate([pos, 0, 0])
				half_sphere(rivet_diameter);
}

module stanchion(height=0.05, base=0.03, ball=0.04, hole=0.025) 
{
	rotate([0,0,90])
	difference() {
		union() {
			cylinder(h=base/4, d=base+base*0.3);
			cylinder(d1=base, d2=base/2, h=height);
			translate([0,0,height]) sphere(d = ball);
		}
		translate([0,0,height]) rotate([90,0,0])cylinder(d=hole, center=true);
	}
}

module snifter_valve() 
{
scale([1/87, 1/87, 1/87]) {
	$fn=90;
	//body:
	sphere(d=3.08);
	
	//top:
	cylinder(d=2.49, h=1.7);
	
	//"hat":
	translate([0,0,1.1]) //moves the hat to the top of the valve body
		difference() { //drills the holes in the hat
			cylinder(d=2.8, h=0.89); //hat body
			for (angle = [0 : 36 : 360]) {  //increment of 36 makes 10 holes
				translate([0,0,0.89/2])
					rotate([0,90,angle]) 
						cylinder(d=0.3, h=3); //defines the hat holes
			}
		}
		
	//top nut:
	translate([0,0,1.9]) cylinder(d=1.5, h=0.7, $fn=6);
	cylinder(d=0.7, h=2.7);
		
	//interface nut:
	translate([1.4,0,0]) rotate([0,90,0]) cylinder(d=2, h=1, $fn=6);
}
}

module catwalk(size=[1, 1, 1], radius=0.05)
{
	/*
	difference() {
		roundedbox(size, radius*2);
		translate([size[2]/2,size[2]/2,size[2]/2]) roundedbox([size[0]-size[2], size[1]-size[2], size[2]], radius*2);
	}
	*/
	
	pts = [	[0, 0, radius],
			[0, size[1], radius],
			[size[0], size[1], radius],
			[size[0], 0, radius]
		   ];
	
	diffpts = [	[size[2], size[2], radius],
				[size[2], size[1]-size[2]*2, radius],
				[size[0]-size[2]*2, size[1]-size[2]*2, radius],
				[size[0]-size[2]*2, size[2], radius]
			];

	difference() {
		linear_extrude(size[2]) polygon(polyRound(pts, 20));
		translate([size[2]/2,size[2]/2,size[2]/2])linear_extrude(size[2]) polygon(polyRound(diffpts, 20));
	}
	
	//polyRoundExtrude(pts, size[2]/2, radius, radius, $fn=50);
	
	spacing=0.02;
	for (row = [spacing:spacing:size[0]-spacing]) {
		for (run = [spacing:spacing:size[1]-spacing]) {
			translate([row, run, size[2]/3])
				sphere(radius/3, $fn=50);
		}
	}
	
	for (row = [spacing/2:spacing:size[0]-spacing/2]) {
		for (run = [spacing/2:spacing:size[1]-spacing/2]) {
			translate([row, run, size[2]/3])
				sphere(radius/3, $fn=50);
		}
	}
}

//catwalk([0.86,0.2,0.002],0.003);


module halfsphere(r) {
	difference() {
		sphere(r);
		translate([-r,-r,-r]) 
		cube([r*2,r*2,r]);
	}
}


//footboard(length=5,width=2, platformthickness=0.05, borderdiameter=0.07, cornerradius=0.5, treadspacing=0.5);

module footboard_old(l=1, w=0.25, h=0.02, r=0.01, s=0.03) {
	
	//outer rim polygon:
	pts1 = [
		[0,0,r],
		[0,w,r],
		[l,w,r],
		[l,0,r]
	];
	//subtract void from outer rim
	pts2 = [
		[r,r,r],
		[0,w-r*2,r],
		[l-r*2,w-r*2,r],
		[l-r*2,r,r]
	];
	
	//construct outer rim:
	difference() {
		polyRoundExtrude(pts1, h, r, r);
		translate([r/2,r/2,-0.001]) polyRoundExtrude(pts2, h*1.1, -r*1.1, -r*1.1);
	}
	
	//floor:
	translate([r/2, r/2, r*0.1]) roundedbox([l-r,w-r,h/2],r);
	
	//rows of tread dots:
	for (run = [s:s*2:l-s]) {
		for (row = [s:s*2:w-s]) {
			translate([run, row, r])
				sphere(r/2);
		}
	}
	
	//alternate staggered tread dots:
	for (run = [s*2:s*2:l-s]) {
		for (row = [s*2:s*2:w-s]) {
			translate([run, row, r])
				sphere(r/2);
		}
	}
	
}

module footboard(l=1, w=0.25, h=0.03, r=0.01, s=0.03, t=0) {
	sp=3;
	//lip:
	translate([0,0,r*2]) rope_rectangle(l=w, w=l, d=r*2);
	
	//floor:
	translate([r/2, r/2, r*0.1]) roundedbox([l-r,w-r,h/2],r);
	
	//if (tread > 0) {
		//rows of tread dots:
		for (run = [s:s*2:l-s]) {
			for (row = [s:s*2:w-s]) {
				translate([run, row, h/2])
					sphere(s/sp, $fn=t);
			}
		}
	
		//alternate staggered tread dots:
		for (run = [s*2:s*2:l-s]) {
			for (row = [s*2:s*2:w-s]) {
				translate([run, row, h/2])
					sphere(s/sp, $fn=t);
			}
		}
	//}
}
 
//# boiler routinesre

module boilercourse(diameter, length, thickness)
{
	rotate([0,90,0])
	difference() {
		cylinder(d=diameter, h=length);
		translate([0,0,-length*0.01]) cylinder(d=diameter-thickness, h=length+length*0.02);
	}
}

module taperedcourse(diameter1, diameter2, length, thickness)
{
	rotate([0,90,0])
	difference() {
		cylinder(d1=diameter1, d2=diameter2, h=length);
		translate([0,0,-length*0.01]) cylinder(d1=diameter1-thickness, d2=diameter2-thickness, h=length+length*0.02);
	}
}

//# cab routines

module cab_roof(arc=90, radius=30, length=20, thickness=1) {
	translate([length,0,-radius]) rotate([0,-90,0]) {
		difference() {
			pie_slice(ang=arc, l=length, r=radius, spin=-arc/2);
			translate([0,0,-0.1]) pie_slice(ang=arc+2, l=length+1, r=radius-thickness, spin=-(arc+2)/2);
		}
		rotate([0,0,-arc/2]) translate([radius-thickness/2,0,0]) cylinder(d=thickness, h=length);
		rotate([0,0,arc/2]) translate([radius-thickness/2,0,0]) cylinder(d=thickness, h=length);
	}
}

//# sidrod routines

//## rod
//- length
//- width
//- height
//
module rod(length, width, height) {
	translate([0,-width/2, -height/2]) cube([length, width, height]);
}

//## crankpin_hole
//
//Makes a cylinder for differenceing a crankpin hole
//
//- bearing_hole: diameter of hole
//= rod_width: width of rod
//
module crankpin_hole(bearing_hole, rod_width) {
	translate([0,rod_width,0])
	rotate([90,0,0])
	cylinder(d=bearing_hole, h=rod_width*2);
}

//## bearing_lubricator
//
//- diameter
//- height
//
module bearing_lubricator(diameter, height) {
	cylinder(d=diameter, h=height);
	cylinder(d=diameter*0.9, h=height*1.1, $fn=6);
	cylinder(d=diameter*0.6, h=height*1.2);
}

//# truck routines

//## truck_bolster
//
//- width: sill-to-sill
//- height: vertical height
//- thick: front-to-back
//- pad: truck mount pad width at bolster center
//- padheight: pad distance from bolster bottom, makes tapered edges
//
module truck_bolster(width, height, thick, pad, padheight) {
	bolster_pts = [
		[0, padheight],
		[0, height+padheight],
		[width, height+padheight],
		[width, padheight],
		[width/2+pad/2, 0],
		[width/2-pad/2, 0],
		[0, padheight]
	];
	
	rotate([0,-90,0])
		rotate([0,0,-90])
			translate([-width/2,-(height+padheight)/2,-thick/2])
				linear_extrude(thick) polygon(bolster_pts);
}


truck_bolster(10,1,1,2,0.5);

