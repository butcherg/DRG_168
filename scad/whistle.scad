use <../lib/Round-Anything/polyround.scad>
use <../lib/utilities.scad>

//for sizing:
//use <../lib/steamdome.scad>

module whistle() {
	diameter=0.05;
	height=0.1;
	
	
	
	difference() {
		translate([diameter/2,0,0])
			cylinder(d=diameter, h=height); //main body
		translate([diameter/2,0,-height])
			cylinder(d=diameter*0.9, h=height*2);
		rotate([0,0,30])
			translate([-height,diameter/2,0])
				rotate([0,90,0]) 
					cylinder(d=diameter, h=height*2);
		rotate([0,0,-30])
			translate([-height,-diameter/2,0])
				rotate([0,90,0]) 
					cylinder(d=diameter, h=height*2);
	}
	
	//upper lip:
	translate([diameter/2,0,height]) 	
		cylinder(d1=diameter, d2=diameter*1.05, h=height*0.02);

	//cup:
	cup_height=0.01;
	cup_pts = [
		[0,0,0],
		[0,cup_height*0.1,0],
		[(diameter/2),cup_height,0],
		//[(diameter/2)*1.1,cup_height/2,0.1],
		[(diameter/2)*1.1,0,0.1],
		[0,0,0]
	];
	translate([diameter/2,0,-cup_height]) {
		rotate_extrude(angle=360) polygon(polyRound(cup_pts,20));
		translate([0,0,cup_height])
			difference() {
				cylinder(d1=diameter, d2=diameter*1.05, h=cup_height*0.2);
				translate([0,0,-cup_height/2]) 
				cylinder(d=diameter*0.95,h=cup_height);
			}
	}
	
	translate([diameter/2,0,height]) {
		cylinder(d=diameter*0.17, h=height*0.05);
		translate([0,0,0.004])sphere(d=diameter*0.17);
		cylinder(d=diameter*0.1, h=height*0.1);
		translate([0,0,height*0.11]) cylinder(d=diameter*0.125, h=height*0.03);
		translate([0,0,height*0.11]) sphere(d=diameter*0.125);
		translate([0,0,height*0.14]) sphere(d=diameter*0.125);
		cylinder(d=diameter*0.05, h=height*0.18);
	}

	//plumbing:
	translate([diameter/2,0,-diameter/2]) {
		sphere(d=diameter/2);
		translate([0,0,-0.02]) cylinder(d=0.015, h=0.035);
		translate([0,0,0]) rotate([0,-90,0]) cylinder(d=0.015, h=0.015, $fn=6);
		translate([0,0,-0.017]) cylinder(d=0.018, h=0.007, $fn=6);
		translate([0,0,-0.02]) rotate([0,90,-90-45]) elbow(0.01, 0.01*1.3);
		//translate([0,0,-0.022]) sphere(0.018/2);
		translate([0.0,0.0,-0.033]) 
			rotate([90,0,-90-45]) 
				translate([0.0,0.0,0.01]) 
					cylinder(d=0.015, h=0.05);
		translate([0.02,0,0.014]) 
			rotate([90,0,0]) {
				cylinder(d=0.01, h=0.02, center=true);
				cylinder(d=0.007, h=0.025, center=true, $fn=6);
			}
	}
	
	//valve lever:
	lever_pts = [
		[0.111,0.021,0.000],
[0.095,0.023,0.000],
[0.107,0.052,0.050],
[0.081,0.086,0.050],
[0.119,0.101,0.050],
[0.098,0.194,0.300],
[0.132,0.309,0.030],
[0.179,0.301,0.000],
[0.174,0.290,0.000],
[0.143,0.288,0.020],
[0.126,0.192,0.500],
[0.147,0.101,0.300]
	];
	difference() {
		union() {
			translate([0.02,0.003,-0.035])
				scale(0.3)
					rotate([90,0,0]) 
						linear_extrude(0.02) 
							polygon(polyRound(lever_pts, 20));
			translate([0.053,0,-0.026])
				rotate([90,0,0])
						cylinder(d=0.01, h=0.006, center=true);
			translate([0.07,0,0.055])
				rotate([90,0,0])
						cylinder(d=0.01, h=0.006, center=true);
		}
		translate([0.07,0,0.055])
			rotate([90,0,0])	
			cylinder(d=0.004, h=0.007, center=true);
		translate([0.053,0,-0.026])
				rotate([90,0,0])
						cylinder(d=0.004, h=0.007, center=true);
	}

}

//rotate([0,0,-45])
//translate([0.11,-0.15,0.35])
scale(25.4)
	whistle($fn=90);

//steamdome($fn=90);