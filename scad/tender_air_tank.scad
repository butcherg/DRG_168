
use <../lib/utilities.scad>

l = 0.66;

module tender_air_tank()
{
	od = 0.28;
	id = 0.24;
	t = 0.02;
	indent = 0.04;
	boilercourse(od,l,t);
	translate([indent,0,0]) 
		rotate([0,90,0]) 
			cylinder(d=od, h=l-indent*2);

	//rivets:
	translate([0.02,0,0]) 
		rivet_cylinder_rounded(diameter=0.137, start_deg=0, end_deg=360, rivet_diameter=0.02, spacing_deg=10);
	translate([l-0.02,0,0]) 
		rivet_cylinder_rounded(diameter=0.137, start_deg=0, end_deg=360, rivet_diameter=0.02, spacing_deg=10);
	
	translate([indent,0,-0.06])
		rotate([0,-90,0]) {
			rivet_course_rounded(start_x= 0, end_x=0.15, rivet_diameter = 0.02, spacing=0.06);
			translate([0,0.07,0]) rivet_course_rounded(start_x= 0, end_x=0.15, rivet_diameter = 0.02, spacing=0.06);
			translate([0,-0.07,0]) rivet_course_rounded(start_x= 0, end_x=0.15, rivet_diameter = 0.02, spacing=0.06);
	}
	
	translate([l-indent,0,-0.06])
		rotate([0,-90,180]) {
			rivet_course_rounded(start_x= 0, end_x=0.15, rivet_diameter = 0.02, spacing=0.06);
			translate([0,0.07,0]) rivet_course_rounded(start_x= 0, end_x=0.15, rivet_diameter = 0.02, spacing=0.06);
			translate([0,-0.07,0]) rivet_course_rounded(start_x= 0, end_x=0.15, rivet_diameter = 0.02, spacing=0.06);
	}

	//rivet_cylinder_rounded(diameter=0.5, start_deg=0, end_deg=90, rivet_diameter=0.05, spacing_deg=10);
	
	//plumbing:
	translate([0,0,0.1])
		rotate([90,0,180])
			elbow(piperadius=0.015, elbowradius=0.03);
	translate([-0.03,0,-0.143])
		cylinder(d=0.02, h=0.22);
	translate([-0.03,0,0]) {
		cylinder(d=0.03, h=0.05, $fn=6);
		translate([0,0,0.025]) sphere(d=0.04);
	}
	translate([-0.03,0,-0.08]) 
		cylinder(d=0.03, h=0.02, $fn=6);
	translate([0,0,0.1])
		rotate([0,90,0])
			cylinder(d=0.02, h=0.04);

	translate([-0.03,-0.01,-0.143])
		cube([0.04, 0.02,0.01]);

	translate([l,0,0])
	rotate([0,0,180]) {
		translate([0,0,0.1])
			rotate([90,0,180])
				elbow(piperadius=0.015, elbowradius=0.03);
		translate([-0.03,0,-0.143])
			cylinder(d=0.02, h=0.22);
		translate([-0.03,0,0]) {
			cylinder(d=0.03, h=0.05, $fn=6);
			translate([0,0,0.025]) sphere(d=0.04);
		}
		translate([-0.03,0,-0.08]) 
			cylinder(d=0.03, h=0.02, $fn=6);
		translate([0,0,0.1])
			rotate([0,90,0])
				cylinder(d=0.02, h=0.04);
		translate([-0.03,-0.01,-0.143])
			cube([0.04, 0.02,0.01]);
	}

}

scale(25.4)
	translate([0,-l/2,0])
		rotate([0,0,90])
			tender_air_tank($fn=90);