include <utilities.scad>
use <Round-Anything/polyround.scad>
use <./cab_rear_support.scad>

cabchannellength=0.39;
cabchannelwidth=0.25;
cabchannelheight=0.2;

flooroffset=0.08; //part that extends forward of the cab
floorlength=0.77+flooroffset;
floorwidth=1.05;
floorthickness=0.025;


module wedge(x, y, z) {
	a = x; 
	b = z;
	c = sqrt(x*x + z*z);
	difference() {
		cube([x,y,z]);
		rotate([0,asin(a/c),0]) translate([0,-y/2,0]) cube([x,y*2,sqrt(b*b + a*a)]);
	}
}

module newframe() {
	framelength=0.35; //3.59;
	framewidth=0.25;
	frameheight=0.27;
	framethickness=0.05;
	
	difference() {
		translate([0.38, -framewidth/2, -frameheight]) frame_channel(length=framelength, width=framewidth, height=frameheight, thickness=framethickness);
		translate([0.70,0.25,-0.05]) rotate([0,90,180]) wedge(.15, .5, .29);
		translate([0.37,-0.15,-.275]) rotate([0,62,0]) cube([.6,.6,.6]);
	}
	translate([0.726,-0.85/2,-0.065]) roundedbox([0.04,0.85,0.065], 0.01);
}

module cab_floor() {
	difference() {
		union() {
			translate([0.03,cabchannelwidth/2,.2]) 
				rotate([180,0,0]) frame_channel(length=0.39+0.35, width=cabchannelwidth, height=0.2, thickness=floorthickness);
			translate([-flooroffset,-floorwidth/2,0.2])
				cube([floorlength,floorwidth,floorthickness]);
		}
		union() {
			translate([-0.01, -cabchannelwidth/2+floorthickness, floorthickness])
				cube([floorlength+0.2, cabchannelwidth-(floorthickness*2), 1]);
			translate([-flooroffset-0.001,-0.59/2,floorthickness+0.06])
				cube([floorlength-cabchannellength+0.02,0.59,1]);
		}
	}
	
	//new members to accomodate new frame...
	newframe();
	
	translate([0.74, cabchannelwidth/2, 0]) 
		rotate([0,0,90]) 
			cab_rear_support();
	translate([0.75, -cabchannelwidth/2, 0]) 
		rotate([0,0,-90]) 
			cab_rear_support(false);
}



cab_floor($fn=90);


