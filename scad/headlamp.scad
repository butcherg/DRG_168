use <../lib/utilities.scad>
use <../lib/Round-Anything/polyround.scad>

bottom=[0.16, 0.25];
top=[0.11/2, 0.15/2];
base=0.1;

module crown (bottom=[1,1], top=[0.5,0.5], height=0.5) {
	hull() {
		translate([bottom[0]/2-top[0]/2, bottom[1]/2-top[1]/2, height]) cube([top[0], top[1], height/100]);
		cube([bottom[0], bottom[1], height/100]);
	}
}



module top() {
	difference() {
		roundedbox([top[1], top[0]*0.8, 0.075],0.005);
		translate([-0.003,0.0035,-0.001]) roundedbox([top[1], top[0]*0.7, 0.08],0.005);
	}
	translate([-0.002,0.0025,0.013]) roundedbox([top[1], top[0]*0.7, 0.05],0.005);
}

module door() {
	w=0.14;
	h=0.24;
	t=0.9;
	th=0.005;
	crown([w, h], [w*t, h*t], th); 
	translate([w*0.85, h/2, th*2]) sphere(d=0.02, $fn=360);
	translate([w*0.85, h/2, th*2]) rotate([90,0,0]) cylinder(d1=0.01, d2=0.015, h=th*8, $fn=360);
	translate([w*0.85, h/3, th*2]) sphere(d=0.015, $fn=360);
	//translate([w*0.1, h*0.7, -0.005]) rounded_border(0.105, 0.05, 0.011);
}

module foot() {
	foot_pts = [
[0.070,0.000,0.000],
[0.075,0.018,0.020],
[0.040,0.049,0.300],
[0.000,0.080,0.000],
[0.170,0.080,0.000],
[0.183,0.047,0.070],
[0.238,0.013,0.020],
[0.240,0.000,0.000]
	];
	rotate([90,0,0]) difference() {
		linear_extrude(0.02) polygon(polyRound(foot_pts,30));
		translate([0.085,0.03,-0.5]) cube([0.07,0.02,1]);
		translate([0.085,0.04,-0.5]) cylinder(h=1, d=0.02, $fn=90);
		translate([0.155,0.04,-0.5]) cylinder(h=1, d=0.02, $fn=90);
	}
}

module headlamp() {

	translate([0,-bottom[1]/2,0,]) {
		//bottom:
		translate([-(bottom[0]*base)/2, -(bottom[1]*base)/2, 0]) cube([bottom[0]*(1+base), bottom[1]*(1+base), 0.01 ]);
	
		//main box:
		difference() {
			cube([bottom[0], bottom[1], 0.27]);
			translate([0.01,0.01,0.01]) cube([0.13, 0.23, 0.25]);
			translate([-0.1,0.25/2,0.27/2]) rotate([0,90,0]) cylinder(d=0.19, h=0.15);
		}
		
		//lens ring:
		translate([0,bottom[1]/2,0.27/2])
			rotate([0,-90,0]) 
				hollow_cylinder(od=0.23, id=0.21, ht=0.02);

		//crown:
		translate([0,0,0.27]) 
			crown(bottom, top, 0.03);
		translate([bottom[0]/2-top[0]/2,bottom[1]/2-top[1]/2,0.3]) 
			cube([top[0], top[1], 0.025]);
		translate([(bottom[0]/2-top[0]/2-0.005/2), (bottom[1]/2-top[1]/2)-0.007/2, 0.3+0.02]) 
			cube([top[0]*1.1, top[1]*1.1, 0.005]);
		translate([0.058,00.0875,0.29]) rotate([0,-90,-90]) top();
		
		attachheight=0.045;
		attachoffset=0.04;
		attachlength=bottom[0]-attachoffset;
		
		//feet:
		translate([-0.005,0.02,-0.08]) foot();
		translate([-0.005,bottom[1]+0.0,-0.08]) foot();
		
		//doors:
		translate([0.01,0,0.015]) 
			rotate([90,0,0]) 
				door();
		//translate([0.01,0.25,0.25]) 	//doesn't appear to have a starboard door...
		//	rotate([-90,0,0]) 
		//		door();
		
		//number boards:
		translate([0.026,-0.003,0.18]) rotate([0,-90,-90]) rope_rectangle(l=0.11, w=0.06, d=0.007);
		translate([0.026,0.255,0.18]) rotate([0,-90,-90]) rope_rectangle(l=0.11, w=0.06, d=0.007);
	}
}

$fn = $preview ? 90 : 180;

scale(25.4)
 headlamp();
//foot();
//top();
