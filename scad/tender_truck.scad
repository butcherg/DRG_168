use <../lib/utilities.scad>
use <../lib/Round-Anything/polyround.scad>

//frame bars:
bar_end=0.11;
bar_bend=0.12;
bar_center=0.22;

module truck_center() {
	thick=0.015;
	radius=0.005;
	difference() {
		cube([0.17, 0.1, thick]);
		translate([0.06,0.035,-0.5])
			cube([0.05, 0.03, 1]);
	}
	difference() {
		cube([0.17, 0.1, thick*3]);
		translate([0.01,0.01,-0.5])
			cube([0.15, 0.08, 1]);
	}
	translate([0,0,thick])
	difference() {
		cube([0.17, 0.1, thick]);
		
		//top row voids:
		translate([0.01,0.07,0]) 
			trapezoid(bottomline=0.04, topline=0.02, toplineheight=0.02, toplineoffset=0, radius);
		translate([0.06,0.07,0]) 
			trapezoid(bottomline=0.02, topline=0.04, toplineheight=0.02, toplineoffset=-0.02, radius);
		translate([0.09,0.07,0]) 
			trapezoid(bottomline=0.02, topline=0.04, toplineheight=0.02, toplineoffset=0, radius);
		translate([0.12,0.07,0]) 
			trapezoid(bottomline=0.04, topline=0.02, toplineheight=0.02, toplineoffset=0.02, radius);
		
		//middle voids:
		translate([0.01,0.037,-0.5])
			cube([0.04, 0.025, 1]);
		translate([0.06,0.035,-0.5])
			cube([0.05, 0.03, 1]);
		translate([0.12,0.037,-0.5])
			cube([0.04, 0.025, 1]);
		
		//bottom voids
		translate([0.01,0.01,0]) 
			trapezoid(bottomline=0.02, topline=0.04, toplineheight=0.02, toplineoffset=0, radius);
		translate([0.04,0.01,0]) 
			trapezoid(bottomline=0.04, topline=0.02, toplineheight=0.02, toplineoffset=0.02, radius);
		translate([0.09,0.01,0]) 
			trapezoid(bottomline=0.04, topline=0.02, toplineheight=0.02, toplineoffset=0, radius);
		translate([0.14,0.01,0]) 
			trapezoid(bottomline=0.02, topline=0.04, toplineheight=0.02, toplineoffset=-0.02, radius);
			
	}

}

module truck_center() {
	thick=0.015;
	radius=0.003;
	width=bar_center-0.03;
	height=bar_bend;
	center_width=width/2;
	center_height=height/2;
	
	//outer border
	difference() {
		cube([width, height, thick], center=true);
		cube([width-0.02, height-0.02, 1], center=true);
	}

	//inner plate with hole
	translate([0,0,-thick])
	difference() {
		cube([width, height, thick], center=true);
		cube([center_height, center_height, 1], center=true);
	}

	//ropes:
	rope_diameter=0.01;
	rope_halfdiameter= rope_diameter/2;
	//center:
	translate([-center_height/2-rope_halfdiameter,-(center_height/2)-rope_halfdiameter,0.0])
		rope_rectangle(l=center_height+0.01, w=center_height+0.01, d=rope_diameter, f=30);

	//12 o'clock:
	translate([0,center_height/2+rope_halfdiameter/2,-rope_halfdiameter])
		rotate([0,90,90])
			cylinder(d=rope_diameter, h=0.02);
	
	//1 o'clock
	translate([center_height/2,center_height/2,-rope_halfdiameter])
		rotate([0,90,45])
			cylinder(d=rope_diameter, h=0.035);

	//2 o'clock:
	translate([center_height/2,(center_height/2)-rope_halfdiameter,-rope_halfdiameter])
		rotate([0,90,0])
			cylinder(d=rope_diameter, h=0.06);
	//4 o'clock:
	translate([center_height/2,-(center_height/2)+rope_halfdiameter,-rope_halfdiameter])
		rotate([0,90,0])
			cylinder(d=rope_diameter, h=0.06);
	
	//5 o'clock
	translate([center_height/2,-center_height/2,-rope_halfdiameter])
		rotate([0,90,-45])
			cylinder(d=rope_diameter, h=0.035);

	//6 o'clock:
	translate([0,-center_height/2-rope_halfdiameter/2,-rope_halfdiameter])
		rotate([0,90,-90])
			cylinder(d=rope_diameter, h=0.02);
	
	//7 o'clock
	translate([-center_height/2,-center_height/2,-rope_halfdiameter])
		rotate([0,90,-135])
			cylinder(d=rope_diameter, h=0.035);

	//8 o'clock:
	translate([-center_height/2,-(center_height/2)+rope_halfdiameter,-rope_halfdiameter])
		rotate([0,90,180])
			cylinder(d=rope_diameter, h=0.05);
	//10 o'clock:
	translate([-center_height/2,(center_height/2)-rope_halfdiameter,-rope_halfdiameter])
		rotate([0,90,180])
			cylinder(d=rope_diameter, h=0.05);
	
	//11 o'clock
	translate([-center_height/2,center_height/2,-rope_halfdiameter])
		rotate([0,90,-225])
			cylinder(d=rope_diameter, h=0.035);

}

module truck_frame() {

	top_bar_offset=0.02;
	top_bar_pts = [	
		[0,0.0001,0],
		[bar_end, 0.00, 0],
		[bar_end+bar_bend, top_bar_offset, 0],
		[bar_end+bar_bend+bar_center, top_bar_offset, 0],
		[bar_end+bar_bend+bar_center+bar_bend, 0,00, 0],
		[bar_end+bar_bend+bar_center+bar_bend+bar_end, 0.00, 0]
	];
	
	middle_bar_offset=-0.1;
	middle_bar_pts = [	
		[0,0.0001,0],
		[bar_end, 0.00, 0],
		[bar_end+bar_bend, middle_bar_offset, 0],
		[bar_end+bar_bend+bar_center, middle_bar_offset, 0],
		[bar_end+bar_bend+bar_center+bar_bend, 0,00, 0],
		[bar_end+bar_bend+bar_center+bar_bend+bar_end, 0.00, 0]
	];

	//frame bars:
	translate([0,0.18,0])
		linear_extrude(0.04)
			polygon(polyRound(beamChain(top_bar_pts, offset1=0.01, offset2=-0.01), 20));
	translate([0,0.18-0.02,0])
		linear_extrude(0.04)
			polygon(polyRound(beamChain(middle_bar_pts, offset1=0.01, offset2=-0.01), 20));
	linear_extrude(0.04)
			polygon(polyRound(beamChain(top_bar_pts, offset1=0.01, offset2=-0.01), 20));

	
}

module truck_journal() {
	hull() {
		translate([0,0.02,0]) cube([0.07,0.05,0.06]);
		translate([0,0,0.04]) rotate([0,90,0]) cylinder(d=0.08, h=0.07);
	}
	
	pts = [
		[0.018,0.000,0.000],
		[0.015,0.018,0.000],
		[0.000,0.018,0.000],
		[0.000,0.032,0.200],
		[0.014,0.032,0.050],
		[0.014,0.048,0.000],
		[0.088,0.048,0.000],
		[0.088,0.033,0.500],
		[0.110,0.033,0.000],
		[0.110,0.017,0.000],
		[0.088,0.017,0.500],
		[0.088,0.000,0.000]
	];

	//bearing cover:
	translate([-0.018,0.01,0.075])
		rotate([-18,0,0]) 
		linear_extrude(0.01)
			polygon(polyRound(pts, 20));
	
	translate([0.025,0.035,0.073])
	hull() {
		sphere(d=0.02);
		translate([0.02,0,0]) sphere(d=0.02);
	}
	
	
}

module tender_truck_side() {
	truck_frame();
	translate([0.34,0.13, 0.023]) truck_center();
	
	//journal supports:
	translate([0.01,0,0]) 
		cube([0.09, 0.15, 0.04]);
	translate([bar_end+bar_bend+bar_center+bar_bend+0.01,0,0]) 
		cube([0.09, 0.15, 0.04]);

	//journals:
	journal_elevation=0.065;
	journal_embed=0.01;
	translate([0.02,journal_elevation,journal_embed])
		truck_journal();
	translate([bar_end+bar_bend+bar_center+bar_bend+0.02,journal_elevation,journal_embed])
		truck_journal();
	
	//mid-bottom frame spacers:
	translate([bar_end+bar_bend,0.03,0])
		cube([0.06, 0.02, 0.04]);
	translate([bar_end+bar_bend+bar_center-0.06,0.03,0])
		cube([0.06, 0.02, 0.04]);
	
	//center bolt heads:
	//bottom:
	translate([bar_end+bar_bend+0.01,0,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	translate([bar_end+bar_bend+0.05,0,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	translate([bar_end+bar_bend+bar_center-0.01,0,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	translate([bar_end+bar_bend+bar_center-0.05,0,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	
	//top:
	translate([bar_end+bar_bend+0.01,0.21,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	translate([bar_end+bar_bend+0.05,0.21,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	translate([bar_end+bar_bend+bar_center-0.01,0.21,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	translate([bar_end+bar_bend+bar_center-0.05,0.21,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
			
	//bolt shafts:
	translate([bar_end+bar_bend+0.01,0.02,0.02])
		rotate([-90,0,0])
			cylinder(d=0.012, h=0.2);
	translate([bar_end+bar_bend+bar_center-0.01,0.02,0.02])
		rotate([-90,0,0])
			cylinder(d=0.012, h=0.2);

	//journal bolt heads
	//top
	translate([0.025,0.19,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	translate([0.085,0.19,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	translate([0.59,0.19,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	translate([0.65,0.19,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);

	//bottom:
	translate([0.025,-0.02,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	translate([0.085,-0.02,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	translate([0.59,-0.02,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	translate([0.65,-0.02,0.02])
		rotate([-90,0,0])
			cylinder(d=0.02, h=0.01, $fn=6);
	
}

module axle_cutout() {
	gauge=((3*12)/87); //HOn3
	Wo = 0.056;
	length_ext=0.04;
	rotate([90,0,0]) translate([0,0,-(gauge+Wo*2+length_ext)/2])cylinder(d=1/14.5,h=gauge+Wo*2+length_ext);
}

module tender_truck() {
	spacing=0.5;
	translate([0,-spacing/2,0]) rotate([90,0,0]) tender_truck_side();
	translate([0.6815,spacing/2,0]) rotate([90,0,180]) tender_truck_side();
	translate([(0.6815/2)-0.05,-spacing/2,0.17]) cube([0.1, spacing, 0.04]);
}

$fn = $preview ? 90 : 180;

scale(25.4) {
	difference() {
		tender_truck();
		translate([0.055,0,0.07]) axle_cutout();
		translate([0.625,0,0.07]) axle_cutout();
	}
}
