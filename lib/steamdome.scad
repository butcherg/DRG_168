
domeheight = 12;
domediameter = 15;

module steamdome() {
	rotate([0,0,90]) {
		//main cylinder:
		translate ([0,0,.1]) cylinder(d=0.315, h=0.20);

		//dome top:
		translate([0,0,.3])
		hull()
		difference() {
			rotate_extrude() 
				translate([0.081,0,0]) 
				circle(d=0.157);
			translate([-1,-1,-2]) cube(2);
		}

		//dome base:
		baseofst=0.008;
		base = 
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
				translate([0.3/2,0,0]) { //x defines radius
					offset(-baseofst,$fn=54) offset(baseofst,$fn=54)offset(baseofst,$fn=54) offset(-baseofst,$fn=54) 
						polygon(base);
					//square([0.13,0.13]);
					//translate([0,2.5,0]) 	square([1,1]);
				}
			}
			translate([0,.5,-0.245]) rotate([90,0,0])
				cylinder(d=0.65, h=10);
		}

		//crown:
		crownofst=0.005;
		crown = [
		[0,0], 
		[0,.1],
		[.05,.1],
		[.05,.095],
		[.025,.081],
		[.03,0]
		];

		translate([0,0,.33]) 
		difference () {
			rotate_extrude() {
				translate([0.05,0,0]) { 
				offset(-crownofst,$fn=54) offset(crownofst,$fn=54)offset(crownofst,$fn=54) offset(-crownofst,$fn=54) 
				polygon(crown);
				}
			}
		}
	
		//safety valves:
		translate([0.025,0,.369]) { 
			cylinder(r=.015, h=.085);
			translate([0,0,.065]) cylinder(r=.0165, h=.002);
			translate([0,0,.085]) cylinder(r=.017, h=.003);
			hull() {
				cylinder(r=.01, h=.110 );
				cylinder(r=.008, h=.112 );
			}
			cylinder(r=.0035, h=.125 );
		}
	
		translate([-0.025,0,.369]) { 
			cylinder(r=.015, h=.085);
			translate([0,0,.065]) cylinder(r=.0165, h=.002);
			translate([0,0,.085]) cylinder(r=.017, h=.003);
			hull() {
				cylinder(r=.01, h=.110 );
				cylinder(r=.008, h=.112 );
			}
			cylinder(r=.0035, h=.125 );
		}
	}
}

$fn =  $preview ? 90 : 180;

scale(25.4)
	steamdome();
