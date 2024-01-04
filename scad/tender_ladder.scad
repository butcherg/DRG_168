use <../lib/utilities.scad>

ladderheight=0.73;
ladderwidth=0.15;
ladderdepth=0.08;
ladderthickness=0.025;
laddermaterial=0.03;

cisternheight=0.6;

module laddermount_top() {
	length=0.11;
	difference() {
			roundedbox([0.04, length, ladderthickness], 0.01);
			translate([-laddermaterial/2,laddermaterial/2,-0.5]) cube([0.04,length-laddermaterial,1]);
			translate([-laddermaterial/1.5,-0.001,-0.5]) cube([0.04,length-laddermaterial,1]);
			//translate([-laddermaterial,laddermaterial,-0.5]) cube([0.04,length-laddermaterial,1]);
	}
	translate([-0.01,laddermaterial/4, ladderthickness/2])
	rotate([90,0,90]){
		translate([0,0,-0.01]) cube([ladderthickness, laddermaterial/2, 0.02],center=true);
			linear_extrude(0.03, twist=90) 
				square([ladderthickness, laddermaterial/2], center=true);
	}
}

module laddermount_bottom() {
	cube([laddermaterial, ladderthickness, ladderwidth]);
	
	//bolts:
	translate([0.015,-0.01,0.029]) rotate([-90,0,0]) translate([0,0,0]) cylinder(d=0.02, h=0.03, $fn=6);
	translate([0.015,-0.01,0.075]) rotate([-90,0,0]) translate([0,0,0]) cylinder(d=0.02, h=0.03, $fn=6);
	translate([0.015,-0.01,0.121]) rotate([-90,0,0]) translate([0,0,0]) cylinder(d=0.02, h=0.03, $fn=6);
}

module ladder_frame() {
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
}

module tender_ladder() {
	translate([ladderdepth/3,ladderwidth/2,0]) 
	rotate([0,-90,90]) {
		ladder_frame();
	
		//rungs:
		translate([0.1,ladderthickness/2,0])
			cylinder(d=ladderthickness, h=ladderwidth);
		translate([0.1+0.14,ladderthickness/2,0])
			cylinder(d=ladderthickness, h=ladderwidth);
		translate([0.1+0.14*2,ladderthickness/2,0])
			cylinder(d=ladderthickness, h=ladderwidth);
		
		translate([0.52,0.005,-0.005]) laddermount_top();
		
		translate([0,0.025,0]) laddermount_bottom();
	}
}

//scale(25.4)
	tender_ladder($fn=90);
	//laddermount($fn=90);
	//color("green") laddermount1($fn=90);
	//ladder_frame($fn=90);