use <../lib/Round-Anything/polyround.scad>
use <../lib/utilities.scad>
use <../lib/path_extrude.scad>

//for fit:
//use <tender_ladder.scad>

//major dimensions:
cistern_length=2.37;
cistern_width=0.83;  //0.79;
cistern_height=0.69;
cistern_leg= 0.15;
cistern_corner=0.05;
cistern_wallwidth=0.015;
cistern_bunker_depth=1.7;

plan_pts = [
[0.000,0.000,cistern_corner],
[cistern_length,0.000,cistern_corner],
[cistern_length,cistern_width,cistern_corner],
[0.000,cistern_width,cistern_corner],
[0.000,cistern_width-cistern_leg,cistern_corner],
[cistern_bunker_depth,cistern_width-cistern_leg,cistern_corner],
[cistern_bunker_depth,cistern_leg,cistern_corner],
[0.000,cistern_leg,cistern_corner]
];

wall=0.02;
plan_pts2 = [
[wall,wall,cistern_corner],
[cistern_length-wall,wall,cistern_corner],
[cistern_length-wall,cistern_width-wall,cistern_corner],
[wall,cistern_width-wall,cistern_corner],
[wall,cistern_width-cistern_leg+wall,cistern_corner],
[cistern_bunker_depth+wall,cistern_width-cistern_leg+wall,cistern_corner],
[cistern_bunker_depth+wall,cistern_leg-wall,cistern_corner],
[wall,cistern_leg-wall,cistern_corner]
];


profile1_pts = [
[0.000,0.000,0.000],
[0.000,0.141,0.000],
[0.298,0.141,0.000],
[0.213,0.133,0.400],
[0.185,0.037,0.200],
[0.043,0.024,0.200]
];

profile2_pts = [
[0.000,0.000,0.000],
[0.000,0.141,0.000],
[0.298,0.141,0.000],
[0.213,0.133,0.55],
[0.175,0.008,0.40],
[0.123,0.000,0.000],
[0.045,0.000,0.000]
];

module cistern_shell() {
	difference() {
	translate([0,-cistern_width/2,0])
		linear_extrude(cistern_height) 
			polygon(polyRound(plan_pts,20));
	translate([0,-cistern_width/2,0])
		linear_extrude(cistern_height-0.18) 
			polygon(polyRound(plan_pts2,20));
	}
}

module profile1() {
	translate([-0.001,cistern_width,0])
		rotate([90,0,0])
			linear_extrude(cistern_width*2) 
				polygon(polyRound(profile1_pts,20));
}

module profile2() {
	translate([-0.001,-cistern_width,0])
		rotate([90,0,180])
			linear_extrude(cistern_width*2) 
				polygon(polyRound(profile2_pts,20));
}


td = 0.027;
trim_length=cistern_length-(td/2);
trim_width=cistern_width-(td/2);


trim_profile = [
	[  0,  0, td/2],
	[  0, td, td/2],
	[ td, td, td/2],
];

trim_profile_pts = [
	[cistern_corner,0.025,0],
	[cistern_corner+0.12, 0.035, 0.04],
	[cistern_corner+0.17, 0.139, 0.1],
	[cistern_corner+1.73, 0.139, 0.1],
	[cistern_corner+1.785, 0, 0.09],
	[cistern_length-cistern_corner, 0, 0]
];
module edge_trim_profile() {
	path_pts = addnum(polyRound(trim_profile_pts,15),0);
	path_extrude(path_pts, polyRound(trim_profile,20));
}

trim_end_offset=0.010;
trim_end_pts = [
	[cistern_length-cistern_corner, cistern_width/2+trim_end_offset, 0],
	[cistern_length+td/2, cistern_width/2+trim_end_offset, td*2],
	[cistern_length+td/2, -cistern_width/2+cistern_corner, 0],
	[cistern_length+td/2, -cistern_width/2-trim_end_offset/2, td*2],
	[cistern_length-cistern_corner, -cistern_width/2-trim_end_offset/2, 0]
];

module edge_trim_end() {
	path_pts = addnum(polyRound(trim_end_pts,15),0);
	path_extrude(path_pts, polyRound(trim_profile,20));
}

//trim_front_pts = [
//	[0,0,0],
//	[0.015,0.02,0.01],
//	[0.015,0.04,0]
//];
trim_front_pts = [
	[0.001,0.001,0],
	[cistern_corner, 0, cistern_corner],
	[cistern_corner, cistern_corner, 0]
];
module edge_trim_front() {
	path_pts = addnum(polyRound(trim_front_pts,7),0);
	rotate([0,-20,0]) rotate([0,0,-90]) path_extrude(path_pts, polyRound(trim_profile,20));
	translate([0,-0.0035,-0.02]) sphere(0.008);
}

module cistern_assembly() {
	render() 
	difference() {  //use render() to solve preview disconnects caused by differences() with linear_extrude()
		cistern_shell();

		//cut down the top, make the wings:
		translate([-0.001,-cistern_width/2+cistern_wallwidth,0.55]) 
			cube([3,cistern_width-cistern_wallwidth*2,0.5]);
		translate([0,0,0.55]) profile1();
		translate([2,0,0.55]) profile2();
		translate([1.995,-0.5,0.55]) cube([1,1,1]);

	}
	
	//bunker extension wall:
	extension_width = cistern_width -0.001;
	translate([1.72,0,-0.05])
		rotate([0,-90,0]) 
			difference() {
				cylinder(d=extension_width*2, h=0.02);
				translate([0,extension_width*1.5, -0.001]) 
					cube([extension_width*2, extension_width*2, 1], center=true);
				translate([0,-extension_width*1.5, -0.001]) 
					cube([extension_width*2, extension_width*2, 1], center=true);
				translate([-0.23,0, -0.001]) 
					cube([extension_width*2, extension_width*2, 1], center=true);
				
			}
			
	//water hatch:
	translate([2.2,0,0.55]) {
		roundedbox([0.15,0.27,0.05], 0.025, true);
		translate([0,0,0.05]) roundedbox([0.16,0.28,0.01], 0.025, true);
		translate([-0.08,0.08,0]) {
			translate([0,-0.02,0.06]) {
				rotate([-90,0,0]) cylinder(d=0.02, h=0.04);
				translate([0,0,-0.005]) cube([0.04,0.04,0.01]);
			}
		}
				
		translate([-0.08,-0.08,0]) {
			translate([0,-0.02,0.06]) {
				rotate([-90,0,0]) cylinder(d=0.02, h=0.04);
				translate([0,0,-0.005]) cube([0.04,0.04,0.01]);
			}
		}

	}
}

module trim() {
	trim_offset=0.017;
	translate([0,cistern_width/2-trim_offset, cistern_height-0.137]) 
		rotate([90,0,0]) 
			edge_trim_profile();
	translate([0,-cistern_width/2-trim_offset-0.001, cistern_height-0.135]) 
		rotate([90,0,0]) 
			edge_trim_profile();

	translate([0,0, cistern_height-0.124]) 
		edge_trim_end();
		
	translate([0.001,-cistern_width/2+cistern_corner+0.0087, cistern_height-0.116]) 
		edge_trim_front();
	//translate([0.001,cistern_width/2+cistern_corner+0.0087, cistern_height-0.116])
	translate([0.001,cistern_width/2-cistern_corner-0.0055, cistern_height-0.1182])	
		mirror([0,1,0]) edge_trim_front();
}

module rivets() {
	toprivetline=0.53;
	bottomrivetline=0.01;

	//top side:
	translate([0,cistern_width/2,toprivetline])
		rotate([-90,0,0])
			rivet_course_rounded(cistern_corner, cistern_length-cistern_corner, 0.01, 0.017, $fn=10);
	translate([0,-cistern_width/2,toprivetline])
		rotate([90,0,0])
			rivet_course_rounded(cistern_corner, cistern_length-cistern_corner, 0.01, 0.017, $fn=10);

	//bottom side:
	translate([0,cistern_width/2,bottomrivetline])
		rotate([-90,0,0])
			rivet_course_rounded(cistern_corner, cistern_length-cistern_corner, 0.01, 0.017, $fn=10);
	translate([0,-cistern_width/2,bottomrivetline])
		rotate([90,0,0])
			rivet_course_rounded(cistern_corner, cistern_length-cistern_corner, 0.01, 0.017, $fn=10);
	
	//middle port side
	translate([0,-cistern_width/2,0.23])
		rotate([90,0,0])
			rivet_course_rounded(cistern_corner+0.1, cistern_length-(cistern_corner+0.1), 0.01, 0.05, $fn=10);
	translate([0,-cistern_width/2,0.25])
		rotate([90,0,0])
			rivet_course_rounded(cistern_corner+0.125, cistern_length-(cistern_corner+0.1), 0.01, 0.05, $fn=10);
	translate([0,-cistern_width/2,0.25]) //extra on the end, front
		rotate([90,0,0])
			rivet_course_rounded(cistern_corner+0.1, cistern_corner+0.1, 0.01, 0.05, $fn=10);
	translate([0,-cistern_width/2,0.25]) //extra on the end, back
		rotate([90,0,0])
			rivet_course_rounded(cistern_length-(cistern_corner+0.12), cistern_length-(cistern_corner+0.12), 0.01, 0.05, $fn=10);

	//middle starboard side
	translate([0,cistern_width/2,0.23])
		rotate([-90,0,0])
			rivet_course_rounded(cistern_corner+0.1, cistern_length-(cistern_corner+0.1), 0.01, 0.05, $fn=10);
	translate([0,cistern_width/2,0.25])
		rotate([-90,0,0])
			rivet_course_rounded(cistern_corner+0.125, cistern_length-(cistern_corner+0.1), 0.01, 0.05, $fn=10);
	translate([0,cistern_width/2,0.25]) //extra on the end, front
		rotate([-90,0,0])
			rivet_course_rounded(cistern_corner+0.1, cistern_corner+0.1, 0.01, 0.05, $fn=10);
	translate([0,cistern_width/2,0.25]) //extra on the end, back
		rotate([-90,0,0])
			rivet_course_rounded(cistern_length-(cistern_corner+0.12), cistern_length-(cistern_corner+0.12), 0.01, 0.05, $fn=10);
	
//corners:
	//front-left:
	//outside:
	translate([0.051,-(cistern_width/2)+cistern_corner,bottomrivetline])
		rotate([0,-90,0])
			rivet_cylinder_rounded(diameter=cistern_corner, start_deg=0, end_deg=90, rivet_diameter=0.01, spacing_deg=15, $fn=10);
	translate([0.051,-(cistern_width/2)+cistern_corner,toprivetline])
		rotate([0,-90,0])
			rivet_cylinder_rounded(diameter=cistern_corner, start_deg=0, end_deg=90, rivet_diameter=0.01, spacing_deg=15, $fn=10);
	//inside:
	translate([0.051,-(cistern_width/2)+cistern_corner*2,bottomrivetline])
		rotate([0,-90,-90])
			rivet_cylinder_rounded(diameter=cistern_corner, start_deg=0, end_deg=90, rivet_diameter=0.01, spacing_deg=15, $fn=10);
	translate([0.051,-(cistern_width/2)+cistern_corner*2,toprivetline])
		rotate([0,-90,-90])
			rivet_cylinder_rounded(diameter=cistern_corner, start_deg=0, end_deg=90, rivet_diameter=0.01, spacing_deg=15, $fn=10);
	//fronts:
	translate([0,-(cistern_width/2)+(cistern_corner+0.025),bottomrivetline])
		rotate([-90,0,90])
			rivet_course_rounded(-0.01, 0.01, 0.01, 0.02, $fn=10);
	translate([0,-(cistern_width/2)+(cistern_corner+0.025),toprivetline])
		rotate([-90,0,90])
			rivet_course_rounded(-0.01, 0.01, 0.01, 0.02, $fn=10);
	
	//front-right:
	//outside:
	translate([0.051,(cistern_width/2)-cistern_corner,bottomrivetline])
		rotate([0,-90,-90])
			rivet_cylinder_rounded(diameter=cistern_corner, start_deg=0, end_deg=90, rivet_diameter=0.01, spacing_deg=15, $fn=10);
	translate([0.051,(cistern_width/2)-cistern_corner,toprivetline])
		rotate([0,-90,-90])
			rivet_cylinder_rounded(diameter=cistern_corner, start_deg=0, end_deg=90, rivet_diameter=0.01, spacing_deg=15, $fn=10);
	//inside:
	translate([0.051,(cistern_width/2)-cistern_corner*2,bottomrivetline])
		rotate([0,-90,0])
			rivet_cylinder_rounded(diameter=cistern_corner, start_deg=0, end_deg=90, rivet_diameter=0.01, spacing_deg=15, $fn=10);
	translate([0.051,(cistern_width/2)-cistern_corner*2,toprivetline])
		rotate([0,-90,0])
			rivet_cylinder_rounded(diameter=cistern_corner, start_deg=0, end_deg=90, rivet_diameter=0.01, spacing_deg=15, $fn=10);
	//fronts:
	translate([0,(cistern_width/2)-(cistern_corner+0.025),bottomrivetline])
		rotate([-90,0,90])
			rivet_course_rounded(-0.01, 0.01, 0.01, 0.02, $fn=10);
	translate([0,(cistern_width/2)-(cistern_corner+0.025),toprivetline])
		rotate([-90,0,90])
			rivet_course_rounded(-0.01, 0.01, 0.01, 0.02, $fn=10);
			
//Interior rivets:
	//top side:
	translate([0,-(cistern_width/2)+(cistern_corner*2)+0.05,toprivetline])
		rotate([-90,0,0])
			rivet_course_rounded(cistern_corner, cistern_bunker_depth, 0.01, 0.017, $fn=10);
	translate([0,(cistern_width/2)-(cistern_corner*2)-0.05,toprivetline])
		rotate([90,0,0])
			rivet_course_rounded(cistern_corner, cistern_bunker_depth, 0.01, 0.017, $fn=10);

	//bottom side:
	translate([0,-(cistern_width/2)+(cistern_corner*2)+0.05,bottomrivetline])
		rotate([-90,0,0])
			rivet_course_rounded(cistern_corner, cistern_bunker_depth, 0.01, 0.017, $fn=10);
	translate([0,(cistern_width/2)-(cistern_corner*2)-0.05,bottomrivetline])
		rotate([90,0,0])
			rivet_course_rounded(cistern_corner, cistern_bunker_depth, 0.01, 0.017, $fn=10);

	//corners:
	//bottom left:
	translate([cistern_bunker_depth-cistern_corner,-((cistern_width/2)-(cistern_corner*4)),bottomrivetline])
		rotate([0,90,0])
			rivet_corner_rounded(diameter=cistern_corner, start_deg=0, end_deg=70, rivet_diameter=0.01, spacing_deg=15, $fn=10);

	//top left:
	translate([cistern_bunker_depth-cistern_corner,-((cistern_width/2)-(cistern_corner*4)),toprivetline])
		rotate([0,90,0])
			rivet_corner_rounded(diameter=cistern_corner, start_deg=0, end_deg=70, rivet_diameter=0.01, spacing_deg=15, $fn=10);

	//bottom right:
	translate([cistern_bunker_depth-cistern_corner,((cistern_width/2)-(cistern_corner*4)),bottomrivetline])
		rotate([0,90,90])
			rivet_corner_rounded(diameter=cistern_corner, start_deg=10, end_deg=70, rivet_diameter=0.01, spacing_deg=15, $fn=10);

	//top right:
	translate([cistern_bunker_depth-cistern_corner,((cistern_width/2)-(cistern_corner*4)),toprivetline])
		rotate([0,90,90])
			rivet_corner_rounded(diameter=cistern_corner, start_deg=10, end_deg=70, rivet_diameter=0.01, spacing_deg=15, $fn=10);

	//back wall:
	backwallwidth=0.49-cistern_corner*2;
	translate([cistern_bunker_depth,0,bottomrivetline])
		rotate([0,-90,0])
		translate([0,-backwallwidth/2,0])
			rotate([0,0,90])
				rivet_course_rounded(0, backwallwidth+0.01, 0.01, 0.017, $fn=10);

	translate([cistern_bunker_depth,0,toprivetline])
		rotate([0,-90,0])
		translate([0,-backwallwidth/2,0])
			rotate([0,0,90])
				rivet_course_rounded(0, backwallwidth+0.01, 0.01, 0.017, $fn=10);

	//vertical courses:
	//midships:
	translate([0.9515, -cistern_width/2,0.01])
		rotate([0,-90,90]) 
			rivet_course_rounded(0, cistern_height-0.17, 0.01, 0.017, $fn=10);
	translate([0.9515, cistern_width/2,0.01])
		rotate([0,-90,-90]) 
			rivet_course_rounded(0, cistern_height-0.17, 0.01, 0.017, $fn=10);
			
	//rear corners:
	translate([cistern_length-cistern_corner, -cistern_width/2,bottomrivetline])
		rotate([0,-90,90]) 
			rivet_course_rounded(0, cistern_height-0.17, 0.01, 0.017, $fn=10);
	translate([cistern_length-cistern_corner, cistern_width/2,bottomrivetline])
		rotate([0,-90,-90]) 
			rivet_course_rounded(0, cistern_height-0.17, 0.01, 0.017, $fn=10);

	//inside front corners:
	translate([cistern_corner*2, -(cistern_width/2)+(cistern_corner*2)+0.05,bottomrivetline])
		rotate([0,-90,-90]) 
			rivet_course_rounded(0, cistern_height-0.17, 0.01, 0.017, $fn=10);
	translate([cistern_corner*2, (cistern_width/2)-(cistern_corner*2)-0.05,bottomrivetline])
		rotate([0,-90,90]) 
			rivet_course_rounded(0, cistern_height-0.17, 0.01, 0.017, $fn=10);

	//back of tender:
	//corners:
	translate([cistern_length-cistern_corner, -cistern_width/2+cistern_corner, bottomrivetline])
		rotate([0,90,0])
			rivet_cylinder_rounded(diameter=cistern_corner, start_deg=0, end_deg=90, rivet_diameter=0.01, spacing_deg=15, $fn=10);
	translate([cistern_length-cistern_corner, -cistern_width/2+cistern_corner, toprivetline])
		rotate([0,90,0])
			rivet_cylinder_rounded(diameter=cistern_corner, start_deg=0, end_deg=90, rivet_diameter=0.01, spacing_deg=15, $fn=10);
	translate([cistern_length-cistern_corner, cistern_width/2-cistern_corner, bottomrivetline])
		rotate([-90,90,0])
			rivet_cylinder_rounded(diameter=cistern_corner, start_deg=0, end_deg=90, rivet_diameter=0.01, spacing_deg=15, $fn=10);
	translate([cistern_length-cistern_corner, cistern_width/2-cistern_corner, toprivetline])
		rotate([-90,90,0])
			rivet_cylinder_rounded(diameter=cistern_corner, start_deg=0, end_deg=90, rivet_diameter=0.01, spacing_deg=15, $fn=10);

	//top and bottom lines:
	translate([cistern_length, -((cistern_width-cistern_corner)/2)+0.05,bottomrivetline])
		rotate([90,0,90]) 
			rivet_course_rounded(0, cistern_width-cistern_corner*2, 0.01, 0.017, $fn=10);
	translate([cistern_length, -((cistern_width-cistern_corner)/2)+0.05,toprivetline])
		rotate([90,0,90]) 
			rivet_course_rounded(0, cistern_width-cistern_corner*2, 0.01, 0.017, $fn=10);

	//rear detail:
	ofst=3;
	//port covers:
	translate([cistern_length, cistern_width/ofst, 0.24])
		rotate([0,90,0])
			cylinder(d=0.08, h=0.005, $fn=90);
	translate([cistern_length, -cistern_width/ofst, 0.24])
		rotate([0,90,0])
			cylinder(d=0.08, h=0.005, $fn=90);
	//port rivet circles:
	translate([cistern_length+0.005,cistern_width/ofst,0.24])
		rotate([0,180,0])
			rivet_circle_rounded(diameter=0.03, start_deg=0, end_deg=360, rivet_diameter=0.01, spacing_deg=30, $fn=30);
	translate([cistern_length+0.005,-cistern_width/ofst,0.24])
		rotate([0,180,0])
			rivet_circle_rounded(diameter=0.03, start_deg=0, end_deg=360, rivet_diameter=0.01, spacing_deg=30, $fn=30);
	//port center rivets:
	translate([cistern_length+0.005,-cistern_width/ofst,0.25])
		rotate([0,90,0])
			rivet_course_rounded(0, 0.02, 0.01, 0.017, $fn=10);
	translate([cistern_length+0.005,cistern_width/ofst,0.25])
		rotate([0,90,0])
			rivet_course_rounded(0, 0.02, 0.01, 0.017, $fn=10);
	end_course_length=cistern_width-(cistern_corner*7);
	translate([cistern_length,-(end_course_length/2)+0.025,0.25])
		rotate([90,0,90])
			rivet_course_rounded(0, end_course_length, 0.01, 0.05, $fn=10);
	translate([cistern_length,-end_course_length/2,0.23])
		rotate([90,0,90])
			rivet_course_rounded(0, end_course_length, 0.01, 0.05, $fn=10);
	
	//bunker extension rivets:
	translate([1.7,0,-0.07]) 
		rivet_circle_rounded(diameter=cistern_width, start_deg=-27, end_deg=27, rivet_diameter=0.01, spacing_deg=6, $fn=30);
	translate([1.72,0,-0.07]) 
		rotate([0,0,180])
		rivet_circle_rounded(diameter=cistern_width, start_deg=-27, end_deg=27, rivet_diameter=0.01, spacing_deg=6, $fn=30);

}

module cistern_floor() {
	difference() {
		translate([0,-cistern_width/2,-0.0])
			linear_extrude(0.03)
				polygon(polyRound(plan_pts,20));
		translate([wall*4, (cistern_width/2)-(cistern_leg/2), -0.05])
			cylinder(d=cistern_leg-(wall*2), h=0.1);
		for (i=[1:1:17]) {
			translate([wall*4+((cistern_leg-wall)*i), (cistern_width/2)-(cistern_leg/2), -0.05])
				cylinder(d=cistern_leg-(wall*2), h=0.1);
		}
		translate([wall*4, -(cistern_width/2)+(cistern_leg/2), -0.05])
			cylinder(d=cistern_leg-(wall*2), h=0.1);
		for (i=[1:1:17]) {
			translate([wall*4+((cistern_leg-wall)*i), -((cistern_width/2)-(cistern_leg/2)), -0.05])
				cylinder(d=cistern_leg-(wall*2), h=0.1);
		}
		for (i=[14:1:17]) {
			translate([wall*4+((cistern_leg-wall)*i), -((cistern_width/2)-(cistern_leg*4)), -0.05])
				cylinder(d=cistern_leg-(wall*2), h=0.1);
		}
		for (i=[14:1:17]) {
			translate([wall*4+((cistern_leg-wall)*i), ((cistern_width/2)-(cistern_leg*4)), -0.05])
				cylinder(d=cistern_leg-(wall*2), h=0.1);
		}
		for (i=[14:1:17]) {
			translate([wall*4+((cistern_leg-wall)*i), 0, -0.05])
				cylinder(d=cistern_leg-(wall*2), h=0.1);
		}
      }
}

module cistern_spacer(w=1, s=1.01) {
	difference() {
		translate([-w/2,-w/2,0]) cube([w,w,0.02]);
		translate([-w/s,0,-0.01]) cylinder(d=w*1.5, h=0.1);
		translate([w/s,0,-0.01]) cylinder(d=w*1.5, h=0.1);
	}
}

module cistern() {
	cistern_assembly();
	//cistern_floor();
	trim();
	rivets();
	
	translate([1.76,0,0.005])
	translate([0.55/2,0,0]) 
		rotate([0,0,90]) 
			cistern_spacer(0.64, 1.06);

	translate([0.4,0.34,0.005])
		cistern_spacer(0.12);
	translate([0.4,-0.34,0.005])
		cistern_spacer(0.12);

	translate([0.9,0.34,0.005])
		cistern_spacer(0.12);
	translate([0.9,-0.34,0.005])
		cistern_spacer(0.12);
	
	translate([1.4,0.34,0.005])
		cistern_spacer(0.12);
	translate([1.4,-0.34,0.005])
		cistern_spacer(0.12);
}

$fn =  $preview ? 90 : 180;

scale(25.4) {
	cistern();
	//translate([cistern_length+0.01,0,0.02]) tender_ladder();
}
