use <../lib/utilities.scad>

ladderheight=0.73;
ladderwidth=0.2;
ladderdepth=0.15;
ladderthickness=0.02;
laddermaterial=0.02;

cisternheight=0.6;

module tender_ladder() {
	translate([ladderdepth/3,ladderwidth/2,0]) 
	rotate([0,-90,90]) {
		difference() {
			roundedbox([ladderheight, ladderdepth,ladderwidth], (ladderdepth/2)-0.01);
		
			translate([ladderthickness,ladderthickness,-ladderwidth/2]) 
				roundedbox([ladderheight-(ladderthickness*2), ladderdepth-(ladderthickness*2),ladderwidth*2], ((ladderdepth-(ladderthickness*2))/2)-0.01);
			translate([-ladderheight/2,-0.01,laddermaterial/2])
				cube([ladderheight*2, ladderdepth*2, ladderwidth-laddermaterial]);
			translate([-0.001,ladderdepth/3,-ladderwidth/2])
				cube([cisternheight-0.05,ladderwidth*2,ladderwidth*2]);
		}
	
		//rungs:
		translate([0.08,ladderthickness/2,0])
			cylinder(d=ladderthickness, h=ladderwidth);
		translate([0.08+0.14,ladderthickness/2,0])
			cylinder(d=ladderthickness, h=ladderwidth);
		translate([0.08+0.14*2,ladderthickness/2,0])
			cylinder(d=ladderthickness, h=ladderwidth);

		//mounting bar:
		translate([0.002,ladderdepth/3,0])
			cube([ladderthickness, ladderthickness/2, ladderwidth]);
		translate([ladderthickness/2,ladderdepth/3+ladderthickness/2,0.04])
			rotate([90,0,0])
				cylinder(h=0.015, d=0.01, $fn=6);
		translate([ladderthickness/2,ladderdepth/3+ladderthickness/2,0.10])
			rotate([90,0,0])
				cylinder(h=0.015, d=0.01, $fn=6);
		translate([ladderthickness/2,ladderdepth/3+ladderthickness/2,0.16])
			rotate([90,0,0])
				cylinder(h=0.015, d=0.01, $fn=6);
	}
}

scale(25.4)
	tender_ladder($fn=90);
