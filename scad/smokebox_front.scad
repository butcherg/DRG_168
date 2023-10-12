include <../lib/Round-Anything/polyround.scad>
include <../lib/utilities.scad>

168_front = [ [0.0000,0.0420,0.0000],
[0.0000,0.0000,0.0000],
[0.3050,0.0000,0.0000],
[0.3050,0.0153,0.0000],
[0.2408,0.0149,0.0000],
[0.2400,0.0246,0.0100],
[0.1881,0.0281,0.2500],
[0.1300,0.0360,0.2500],
[0.0810,0.0400,0.2500],
[0.0380,0.0410,0.2500] ];

smokebox_hinge = [ [0.0000,0.0000,0.0000],
[0.0000,0.0300,0.0050],
[0.0760,0.0400,0.0500],
[0.1560,0.0340,0.0300],
[0.1600,0.0000,0.0000] ];

module smokebox_dog()
{
	roundedbox([0.02,0.04,0.01], 0.005);
	translate([0,0.015,.01])
		roundedbox([0.02,0.04,0.01], 0.005);
	translate([0.01, 0.025, 0])
		cylinder(h=0.025, r=0.01, $fn=6);
}

module smokebox_hinge_assy()
{
	//$fn=50;
	translate([-0.011,-0.08,-0.13 ]) {
		rotate([180,0,-90]) 
			linear_extrude(0.02) polygon(polyRound(smokebox_hinge,30));
		translate([-0.01,-0.146,-0.02]) cylinder(h=0.04, r=0.013);
	}
	
	translate([-0.011,-0.08,0.15 ]) {
		rotate([180,0,-90]) 
			linear_extrude(0.02) polygon(polyRound(smokebox_hinge,30));
		translate([-0.01,-0.146,-0.04]) cylinder(h=0.04, r=0.013);
	}
}

module smokebox_front()
{ 
	rotate([0,-90,0]) {
		//smokebox face:
		//color("#cccccc") 
		difference() {
			rotate_extrude()
				polygon(polyRound(168_front));
			translate([0, 0, -0.03])
				cylinder(d=0.032, h=0.1);
		}
		
		//alignment flange:
		rotate([0, 90, 0]) {
			difference() {
				boilercourse(0.61-0.0256*2, 0.2, 0.03);
				translate([-0.03, -0.045/2, -0.61/2+0.01]) cube([0.3, 0.045, 0.05]);
			}
		}
	
		start_deg=0;
		end_deg=315; 
		spacing_deg=45;

		//rivets:
		translate([0,0,0.013])
			rotate([0,90,0])
				//color("#888888") 
				rivet_circle(diameter=0.285, start_deg=0, end_deg=360, rivet_diameter=0.025, spacing_deg=12);

		//door dogs:
		for(angle = [start_deg: spacing_deg : end_deg])
		{
			rotate([0,0,angle])
				translate([0,-0.275,0.01]) 
					//color("#888888") 
					smokebox_dog();
	
		}
	
		//handrail stanchions:
		rotate([0,0,42])
			translate([0.285,0,0.014])
				rotate([0,0,90])
					stanchion();
		rotate([0,0,-42])
			translate([0.285,0,0.014])
				rotate([0,0,90])
					stanchion();
	}
	smokebox_hinge_assy();
}


$fn = $preview ? 90 : 360;

scale(25.4)
	smokebox_front();


