include <utilities.scad>

boilercolor = "#222224";
strapcolor = "#444444";

thick=0.02;
//pan_length=0.89;
pan_length=0.61;
pan_width=0.29;
pan_angle=11;

rivetfn=10;

module firebox_pan() {
	difference() {
		translate([-pan_length/2,-pan_width/2,0.125]) 
			roundedbox([pan_length,pan_width,0.085],0.02, $fn=90);
		translate([-pan_length/2+thick, -(pan_width-thick*2)/2,0])
			roundedbox([pan_length*2,pan_width-thick*2,1],0.02, $fn=90);
	}
	
	//firebox floor:
	translate([-pan_length/2,-pan_width/2,0.125])
		roundedbox([pan_length,pan_width,0.02],0.02, $fn=90);

	//port front corner
	translate([-0.27, -pan_width/2, 0.12])
		rotate([90,-90,0])
			rivet_course_rounded(0.01, 0.05, 0.01, 0.02, $fn=rivetfn);
	translate([-0.27, pan_width/2, 0.12])
		rotate([-90,-90,0])
			rivet_course_rounded(0.01, 0.05, 0.01, 0.02, $fn=rivetfn);
	
	//starboard front corner
	translate([-0.26, -pan_width/2, 0.13])
		rotate([90,-90,0])
			rivet_course_rounded(0.01, 0.04, 0.01, 0.02, $fn=rivetfn);
	translate([-0.26, pan_width/2, 0.13])
		rotate([-90,-90,0])
			rivet_course_rounded(0.01, 0.04, 0.01, 0.02, $fn=rivetfn);
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
	}
}


module firebox(decor=true) {
	firebox_course(decor=decor);
	translate([pan_length/2+0.515,0,-0.15]) 
		firebox_pan();
}

$fn = $preview ? 90 : 360;
scale(25.4)
	firebox();



