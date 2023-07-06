
module domecrown (diameter, radius) 
{
	hull()
	rotate_extrude() 
	translate([(diameter/2)-radius,0,0])
	difference() {  //make the outer edge
		difference() {
			circle(r=radius);
			translate([-radius, -radius]) 
				color("Red") 
					square([radius*2, radius]);
		}
		translate([-radius,0]) 
			color ("Blue") 
				square([radius, radius]);
	}
}

module sanddome() { 
	rotate([0,0,90]) {
		//main cylinder:
		translate ([0,0,.14]) cylinder(d=0.24, h=0.14);

		//dome top:
		translate([0,0,.28]) domecrown(0.243,0.065);

		//dome base:
		ofst=0.008;
		pts = 
		[
		[0,0], 
		[0,.16], 
		[.012,.16], 
		[0.018,.12],
		[.05,.1],
		[.05,0]
		];
	
		difference () {
			rotate_extrude() {
				translate([0.11,0,0]) { //x defines radius
					offset(-ofst,$fn=54) offset(ofst,$fn=54)offset(ofst,$fn=54) offset(-ofst,$fn=54) 
						polygon(pts);
					//square([0.13,0.13]);
					//translate([0,2.5,0]) 	square([1,1]);
				}
			}
			translate([0,.5,-0.22]) rotate([90,0,0])
				cylinder(d=0.61, h=10);
		}

		//dome crown: 
		translate([0,0,.35]) {
			domecrown (0.11, 0.03);
			translate([0,0,-0.01])cylinder(d=0.11, h=0.01);
		}
	
		//sand pipe outlets:
		outletofst = 0.005;
		outletpts = 
		[
		[0,.02],
		[.01,0],
		[0,-.02],
		[-.01,0]
		];
	
		translate([.15,0,.08]) rotate([0,-45,0]) {
			translate([0,0,-0.025])
			linear_extrude(height=.05) {
				offset(-outletofst,$fn=54) offset(outletofst,$fn=54)offset(outletofst,$fn=54) offset(-outletofst,$fn=54)
				polygon(outletpts);
			}
		}
	
		translate([-.15,0,.08]) rotate([0,45,0]) {
			translate([0,0,-0.025])
			linear_extrude(height=.05) {
				offset(-outletofst,$fn=54) offset(outletofst,$fn=54)offset(outletofst,$fn=54) offset(-outletofst,$fn=54)
				polygon(outletpts);
			}
		}
	}
}

$fn =  $preview ? 90 : 180;

scale(25.4)
	sanddome();

