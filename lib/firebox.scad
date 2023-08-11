include <utilities.scad>

boilercolor = "#222224";
strapcolor = "#444444";

thick=0.02;
//pan_length=0.89;
pan_length=0.61;
pan_width=0.25;
pan_angle=11;

rivetfn=10;

/*
module firebox_sides(decor=true) {
	
	difference() {
		union() {
			translate([0,-(pan_width/2+thick),0])
				cube([0.93,thick,0.3]);
			translate([0,(pan_width/2),0])
				cube([0.93,thick,0.3]);
		}
		translate([0,0,-0.19]) 
			union() {
				////translate([.50038,-0.3,0.12778]) cube([.5,.6,.2]);
				//translate([.6,-0.3,0.12778]) cube([.5,.6,.3]);
				//translate([0.04,-0.3,0.035]) rotate([0,-12.7,0]) cube([.65,.6,.2]);
				bottomline=2;
				topline=0.2;
				translate([-0.9,0.5,0.01]) 
					rotate([90,0,0]) 
						linear_extrude(1) 
							trapezoid(bottomline=bottomline, topline=topline, toplineheight=0.4, toplineoffset=bottomline-topline);
				//translate([-0.001,-0.5,-0.3]) cube([0.5,1,0.5]);

		}
	}
	
	
	translate([0,-(pan_width/2+thick),0.2]) roundedbox([0.05,pan_width+thick*2,.1], 0.005);
	
	if (decor) {
		//firerbox rivets: 
		translate([0.12,-(pan_width/2+thick),0.27])
			rotate([90,0,0]) rivet_course(start_x= 0, end_x=0.6, spacing=0.05);
		translate([0.12,-(pan_width/2+thick),0.27-0.04])
			rotate([90,0,0]) rivet_course(start_x= 0, end_x=0.6, spacing=0.05);
		translate([0.12,-(pan_width/2+thick),0.27-0.08])
			rotate([90,0,0]) rivet_course(start_x= 0, end_x=0.5, spacing=0.05);
		translate([0.12,-(pan_width/2+thick),0.27-0.12])
			rotate([90,0,0]) rivet_course(start_x= 0, end_x=0.4, spacing=0.05);
		translate([0.12,-(pan_width/2+thick),0.27-0.16])
			rotate([90,0,0]) rivet_course(start_x= 0, end_x=0.2, spacing=0.05);
		translate([0.12,-(pan_width/2+thick),0.27-0.20])
			rotate([90,0,0]) rivet_course(start_x= 0, end_x=0.05, spacing=0.05);

		translate([0.12,pan_width/2+thick,0.27])
			rotate([-90,0,0]) rivet_course(start_x= 0, end_x=0.6, spacing=0.05);
		translate([0.12,pan_width/2+thick,0.27-0.04])
			rotate([-90,0,0]) rivet_course(start_x= 0, end_x=0.6, spacing=0.05);
		translate([0.12,pan_width/2+thick,0.27-0.08])
		rotate([-90,0,0]) rivet_course(start_x= 0, end_x=0.5, spacing=0.05);
		translate([0.12,pan_width/2+thick,0.27-0.12])
			rotate([-90,0,0]) rivet_course(start_x= 0, end_x=0.4, spacing=0.05);
		translate([0.12,pan_width/2+thick,0.27-0.16])
			rotate([-90,0,0]) rivet_course(start_x= 0, end_x=0.2, spacing=0.05);
		translate([0.12,pan_width/2+thick,0.27-0.20])
			rotate([-90,0,0]) rivet_course(start_x= 0, end_x=0.05, spacing=0.05);
	}
}
*/

module furnace_bearer() {
	l=0.06;
	cylinder(d=0.035, h=0.01);
	cylinder(d=0.015, h=0.017);
	translate([l,0,0]) cylinder(d=0.035, h=0.01);
	translate([l,0,0]) cylinder(d=0.015, h=0.017);
	translate([0, -0.01,0]) cube([l, 0.02, 0.01]);
}

module firebox_pan() {
	difference() {
		union() {
			translate([-pan_length/2,-pan_width/2,0]) 
				roundedbox([pan_length,pan_width,0.3],0.02, $fn=90);
			translate([-0.15,-(pan_width+0.01)/2,0.1])
				cube([0.06, pan_width+0.01, 0.07]);
		}
		translate([0,0,-0.123]) 
			rotate([0,-pan_angle,0])
				cube([pan_length*2, pan_width*2, 0.5], center=true);
		translate([-pan_length/2+thick, -(pan_width-thick*2)/2,0])
			roundedbox([pan_length*2,pan_width-thick*2,1],0.02, $fn=90);
	}
	
	//firebox floor:
	translate([0,0,0.142]) 
		rotate([0,-pan_angle,0]) 
			cube([pan_length, pan_width-thick,thick], center=true);

	//firebox back: (commented out, resin drainage...
	//translate([0.2949,0,0.245])
	//	cube([thick,pan_width-thick*2, 0.11], center=true);
	
	//rivets:
	//port front corner
	translate([-0.27, -pan_width/2, 0.1])
		rotate([90,-90,0])
			rivet_course_rounded(0.01, 0.18, 0.01, 0.02, $fn=rivetfn);
	translate([-0.27, pan_width/2, 0.1])
		rotate([-90,-90,0])
			rivet_course_rounded(0.01, 0.18, 0.01, 0.02, $fn=rivetfn);
	
	//starboard front corner
	translate([-0.26, -pan_width/2, 0.11])
		rotate([90,-90,0])
			rivet_course_rounded(0.01, 0.18, 0.01, 0.02, $fn=rivetfn);
	translate([-0.26, pan_width/2, 0.11])
		rotate([-90,-90,0])
			rivet_course_rounded(0.01, 0.18, 0.01, 0.02, $fn=rivetfn);

	//bottom edges
	translate([-0.27, -pan_width/2, 0.09])
		rotate([90,-11,0])
			rivet_course_rounded(0.01, 0.55, 0.01, 0.02, $fn=rivetfn);
	translate([-0.27, pan_width/2, 0.09])
		rotate([-90,-11,0])
			rivet_course_rounded(0.01, 0.55, 0.01, 0.02, $fn=rivetfn);
	
	//furnace bearer plate:
	translate([-0.14, -pan_width/2-0.005, 0.11])
		rotate([90,-90,0])
			rivet_course_rounded(0.01, 0.06, 0.01, 0.02, $fn=rivetfn);
	translate([-0.12, -pan_width/2-0.005, 0.11])
		rotate([90,-90,0])
			rivet_course_rounded(0.01, 0.06, 0.01, 0.02, $fn=rivetfn);
	translate([-0.10, -pan_width/2-0.005, 0.11])
		rotate([90,-90,0])
			rivet_course_rounded(0.01, 0.06, 0.01, 0.02, $fn=rivetfn);
	translate([-0.12,-(pan_width+0.01)/2,0.14]) 
		rotate([90,90,0]) 
			furnace_bearer($fn=90);
	
	
	translate([-0.14, pan_width/2+0.005, 0.11])
		rotate([-90,-90,0])
			rivet_course_rounded(0.01, 0.06, 0.01, 0.02, $fn=rivetfn);
	translate([-0.12, pan_width/2+0.005, 0.11])
		rotate([-90,-90,0])
			rivet_course_rounded(0.01, 0.06, 0.01, 0.02, $fn=rivetfn);
	translate([-0.10, pan_width/2+0.005, 0.11])
		rotate([-90,-90,0])
			rivet_course_rounded(0.01, 0.06, 0.01, 0.02, $fn=rivetfn);
	translate([-0.12,(pan_width+0.01)/2,0.14]) 
		rotate([-90,90,0]) 
			furnace_bearer($fn=90);
}


module firebox_course(decor=true) {
	translate([0,0,0.65/2]) {   //bottom on x axis
		difference() {
			union() {
				boilercourse(0.65, 1.4, 0.05);  //third course
				if (decor) {
					boilercourse(0.66, 0.04, 0.04);  //strap
					translate([0.52,0,0]) 
						boilercourse(0.66, 0.04, 0.04);  //strap
				}
			}
			translate([.52,-(pan_width/2),-0.45]) 
				cube([1,pan_width,0.27]); //smokebox cutout
		}
		
		//stanchions:
		//rotate([ 42.1,0,0]) translate([0.06,0,0.65/2]) stanchion(height=0.044);
		//rotate([-42.1,0,0]) translate([0.06,0,0.65/2]) stanchion(height=0.044);
	}
}


module firebox(decor=true) {
	firebox_course(decor=decor);
	translate([pan_length/2+0.515,0,-0.25]) 
		firebox_pan();
}

$fn = $preview ? 90 : 360;
scale(25.4)
firebox(decor=false);

//firebox_pan();


