use <../lib/utilities.scad>

ladderheight=0.73;
ladderwidth=0.15;
ladderdepth=0.08;
ladderthickness=0.02;
laddermaterial=0.02;

cisternheight=0.6;

module laddermount() {
	rotate([90,0,90]) {
		translate([0,0,-0.01]) cube([ladderthickness, laddermaterial/2, 0.02],center=true);
		linear_extrude(0.02, twist=90) 
			square([ladderthickness, laddermaterial/2], center=true);
		translate([0,0,0.025]) cube([laddermaterial/2,ladderthickness, 0.01],center=true);
		
		translate([-0.00,-ladderthickness/2,0.025]) cube([ 0.095,ladderthickness,laddermaterial/2]);
		translate([0,0,0.03]) rotate([90,0,0]) cylinder(h=ladderthickness, d=laddermaterial/2,center=true);
		translate([0.095,0,0.03]) rotate([90,0,0]) cylinder(h=ladderthickness, d=laddermaterial/2,center=true);
		
		translate([0.09,-ladderthickness/2,0]) cube([laddermaterial/2,ladderthickness,0.03]);
	}
}


module tender_ladder() {
	translate([ladderdepth/3,ladderwidth/2,0]) 
	rotate([0,-90,90]) {
		difference() {
			roundedbox([ladderheight, ladderdepth,ladderwidth], (ladderdepth/2)-0.01);
			//hollow out roundedbox to ladderthickness:
			translate([ladderthickness,ladderthickness,-ladderwidth/2]) 
				roundedbox([ladderheight-(ladderthickness*2), ladderdepth-(ladderthickness*2),ladderwidth*2], ((ladderdepth-(ladderthickness*2))/2)-0.01);
			//hollow out roundebox to laddermaterial:
			translate([-ladderheight/2,-0.01,laddermaterial/2])
				cube([ladderheight*2, ladderdepth*2, ladderwidth-laddermaterial]);
			//cut off ladder rails to interface with tender:
			translate([-0.001,ladderdepth/3,-ladderwidth/2])
				cube([cisternheight-0.08,ladderwidth*2,ladderwidth*2]);
			//cut off top of starboard rail, even with top of tender:
			translate([0.5,0,-ladderwidth/2])
				cube([ladderheight,ladderdepth,ladderwidth]);
		}
		
	
		//rungs:
		translate([0.1,ladderthickness/2,0])
			cylinder(d=ladderthickness, h=ladderwidth);
		translate([0.1+0.14,ladderthickness/2,0])
			cylinder(d=ladderthickness, h=ladderwidth);
		translate([0.1+0.14*2,ladderthickness/2,0])
			cylinder(d=ladderthickness, h=ladderwidth);

		//mounting bar:
		translate([0.002,ladderdepth/3,0])
			cube([ladderthickness, ladderthickness/2, ladderwidth]);
		translate([ladderthickness/2,ladderdepth/3+ladderthickness/2,0.025])
			rotate([90,0,0])
				cylinder(h=0.015, d=0.01, $fn=6);
		translate([ladderthickness/2,ladderdepth/3+ladderthickness/2,0.075])
			rotate([90,0,0])
				cylinder(h=0.015, d=0.01, $fn=6);
		translate([ladderthickness/2,ladderdepth/3+ladderthickness/2,0.13])
			rotate([90,0,0])
				cylinder(h=0.015, d=0.01, $fn=6);
		
		translate([0.52,0.01,0.005]) laddermount();
	}
}

scale(25.4)
	tender_ladder($fn=90);