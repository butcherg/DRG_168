

include <utilities.scad>


crownofst=0.008;

module steamcylinder() {
	translate([-0.025,0,0.02]) rotate([0,90,0]) difference() {
		union() {
			//cylinder(h=0.35,d=.25);
			cylinder(h=0.40,d=.25);
			cylinder(h=0.025,d=.259);
			//translate([0, 0, 0.35-0.025]) cylinder(h=0.025,d=.259);
			translate([0, 0, 0.40-0.025]) cylinder(h=0.025,d=.259);
		}
	}
}

module steamblock() {
	rotate([0,-90,0]) {
	//main block, 0.68 is the critical measure for cylinder centers:
	translate([0, -0.68/2, 0]) cube([0.12, 0.68, 0.3]);
	
	//boiler saddle:
	saddleoffset=0.21;
	verticaloffset=0.06;
	translate([0.12,0,0]) {
		difference() {
			translate([0, -0.33/2, 0]) cube([0.27, 0.33, 0.3]);
			translate([verticaloffset+0.34,0,-.01]) cylinder(d=0.61, h=0.40);
			translate([verticaloffset+0.01, saddleoffset,-0.001]) cylinder(h=0.5, d=0.14);
			translate([verticaloffset+0.01,-saddleoffset,-0.001]) cylinder(h=0.5, d=0.14);
		}
	}
}
}

module steamchest() {
	rotate([180,0,90]) {
		//base:
		roundedbox(size=[0.2,0.32,0.15], radius=0.03, centered=true);
		//base lid:
		translate([0,0,-0.002]) 
			roundedbox(size=[0.21,0.33,0.018], radius=0.03, centered=true);
		//chest:
		translate([0,0,-.068]) 
			roundedbox(size=[0.19,0.30,0.09], radius=0.03, centered=true);
		//chest lid:
		hull() { //cover:
			translate([0,0,-.09]) 
				roundedbox(size=[0.2,0.32,0.03], radius=0.03, centered=true);
			translate([0,0,-.10]) 
				roundedbox(size=[0.18,0.30,0.01], radius=0.03, centered=true);
		}
	}
}

module cylinderchest1() {

	//main block:
	//translate([0.3,0,0]) steamblock();
	translate([0.33,0,0]) steamblock();

	//chests:
	translate([0.18,  0.68/2, .145]) steamchest();
	translate([0.18, -0.68/2, .145]) steamchest();

	//cylinders:
	translate([0.0,  0.68/2,-0.025]) steamcylinder();
	translate([0.0, -0.68/2,-0.025]) steamcylinder();
	

	//snifter valves:
	translate([0,-0.34,0.17]) snifter_valve();
	translate([0, 0.34,0.17]) snifter_valve();

	//chest tab:
	translate([-0.005, -0.01,0.1]) cube([0.1,0.02,0.07]);

	translate([0.01,0.035/2,0.158]) {
		rotate([90,0,0]) cylinder(d=0.02, h=0.035, $fn=6);
		translate([0,-0.015,0]) rotate([90,0,0]) 
			cylinder(d=0.01, h=0.022, $fn=90);
	}
	translate([0.01,0.035/2,0.135]) {
		rotate([90,0,0]) cylinder(d=0.02, h=0.035, $fn=6);
		translate([0,-0.015,0]) rotate([90,0,0]) 
			cylinder(d=0.01, h=0.022, $fn=90);
	}
	translate([0.01,0.035/2,0.112]) {
		rotate([90,0,0]) cylinder(d=0.02, h=0.035, $fn=6);
		translate([0,-0.015,0]) rotate([90,0,0]) 
			cylinder(d=0.01, h=0.022, $fn=90);
	}

}

//removes screw hole and frame cutout in cylinderchest:
module cylinderchest() {
	tabslop=0.01; //add to the tab width and thickness 
	tablength=0.25;
	//K&S brass strip sku #8245, 0.064" thick, 1/4" wide, 12" long
	tabthickness=0.064+tabslop;
	tabwidth=0.25+tabslop;
	
	//cuts out the screw hole and frame tab:
	difference() {
		cylinderchest1();
		//translate([0.33/2-0.04/2,0,-0.001]) cylinder(h=2, d=screwhole_0_80, $fn=90);	//smokebox-cylinderchest-frame hole
		//translate([0.33/2,0,-0.001]) cylinder(h=2, d=screwhole_0_80, $fn=90);	//smokebox-cylinderchest-frame hole
		translate([0.33-tablength+0.001, -tabwidth/2, 0.1]) cube([tablength, tabwidth, tabthickness]);
	}
	
	//adds the pilot truck pillar:
	//translate([0.33/2,0,-0.05]) hollow_cylinder(id=screwhole_0_80, od=screwhole_0_80*1.3, ht=0.05); //  cylinder(h=2, d=screwhole_0_80, $fn=90);	//smokebox-cylinderchest-frame hole
	
	//use to visualize tab in slot:
	//translate([0.3-tablength+0.001, -(tabwidth-tabslop)/2, 0.105]) cube([tablength, tabwidth-tabslop, tabthickness-tabslop]);
}

module wedge(x, y, z) {
	a = x; 
	b = z;
	c = sqrt(x*x + z*z);
	difference() {
		cube([x,y,z]);
		rotate([0,asin(a/c),0]) translate([0,-y/2,0]) cube([x,y*2,sqrt(b*b + a*a)]);
	}
}

module frontend() {
	framelength=3.59;
	framewidth=0.25;
	frameheight=0.167;
	framethickness=0.05;
	frontend_offset=-0.05;
	
	translate([0.45, 0, 0]) cylinderchest();
	
	//front frame rails w/#168 extension modeled as a slanted drop:
	difference() {
		union() {
			translate([0, (0.25/2)-0.04, 0.11+frontend_offset]) cube([0.48, 0.04, 0.06]);
			translate([0, -(0.25/2),     0.11+frontend_offset]) cube([0.48, 0.04, 0.06]);
			
			//footplate supports:
			translate([0, (0.31/2)-0.07, 0.07+frontend_offset]) cube([0.48, 0.07, 0.04]);
			translate([0, -(0.31/2),     0.07+frontend_offset]) cube([0.48, 0.07, 0.04]);
		}
		translate([-0.01, -0.2, 0.147+frontend_offset]) {
			translate([0.0,0.5,0])
			rotate([90,0,0]) 
				linear_extrude(0.5) trapezoid(0.15, 0.25, 0.2, 0);
		}
	}

	//frame extension bolt heads:
	//starboard:
	translate([0.20,(framewidth/2)-(framethickness/2),frameheight+frontend_offset]) cylinder(d=0.02, h=0.01, $fn=6);
	translate([0.23,(framewidth/2)-(framethickness/2),frameheight+frontend_offset]) cylinder(d=0.02, h=0.01, $fn=6);
	translate([0.33,(framewidth/2)-(framethickness/2),frameheight+frontend_offset]) cylinder(d=0.02, h=0.01, $fn=6);
	translate([0.43,(framewidth/2)-(framethickness/2),frameheight+frontend_offset]) cylinder(d=0.02, h=0.01, $fn=6);
	//port:
	translate([0.20,-(framewidth/2)+(framethickness/2),frameheight+frontend_offset]) cylinder(d=0.02, h=0.01, $fn=6);
	translate([0.23,-(framewidth/2)+(framethickness/2),frameheight+frontend_offset]) cylinder(d=0.02, h=0.01, $fn=6);
	translate([0.33,-(framewidth/2)+(framethickness/2),frameheight+frontend_offset]) cylinder(d=0.02, h=0.01, $fn=6);
	translate([0.43,-(framewidth/2)+(framethickness/2),frameheight+frontend_offset]) cylinder(d=0.02, h=0.01, $fn=6);

	//front beam:
	translate([-0.07,-0.95/2,frameheight-0.17+frontend_offset]) roundedbox([0.07,0.95,0.15], 0.03);

	//footboard:
	translate([-0.02,0.13,0.1+frontend_offset])  footboard(0.446, 0.3, 0.03, 0.015, 0.015, 6); //footboard orig x=0.43, extended to touch cylinder for printing
	translate([-0.02,-0.42,0.1+frontend_offset]) footboard(0.446, 0.3, 0.03, 0.015, 0.015, 6);
}

$fn = $preview ? 90 : 180;

//steamblock();
//steamchest();
//cylinderchest();

//frontend();

//for print, render and export to .stl:
scale(25.4)
	frontend();

