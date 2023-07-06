include <../lib/utilities.scad>

framelength=3.59-0.75-0.34;
framewidth=0.25;  //0.25 to accomodate the firebox overhangs, would prefer 0.29 but oh well...
frameheight=0.27;
framethickness=0.06;

module driverslot(framewidth=0.25, slot=0.129, axle=0.125, slotdepth=0.0, detentdepth=0.02)
{
	translate([0,-framewidth/2,0]) {
		translate([0,0,detentdepth]) {
			cube([slot,framewidth*2,(slot/2)+slotdepth]);
			translate([slot/2,0,(slot/2)+slotdepth]) rotate([-90,0,0]) cylinder(d=slot, h=framewidth*2);
		}
		translate([(slot-axle)/2,0,0.001]) cube([axle,framewidth*2,detentdepth]);  //detent
	}
}

module driver_slots() {
	//-0.75 is to accommodate the new frame position...
	front=1.54-0.75;
	main=2.14-0.75; //2.13...
	rear=3.12-0.75;
	slot=0.129;
	axle=0.129; //axle retention detent...
	slotdepth=0.02;

	translate([front-slot/2,0,-0.002]) 
		driverslot(framewidth=framewidth, slot=slot, axle=axle, slotdepth=slotdepth, detentdepth=0.02);
	translate([main-slot/2,0,-0.002])
		driverslot(framewidth=framewidth, slot=slot, axle=axle, slotdepth=slotdepth, detentdepth=0.02);
	translate([rear-slot/2,0,-0.002])
		driverslot(framewidth=framewidth, slot=slot, axle=axle, slotdepth=slotdepth, detentdepth=0.02);
	
}

module frame_voids() {
	//frame screw holes:
	translate([3-0.75, framewidth/2, 0]) cylinder(h=2, d=screwhole_0_80, $fn=90);
	//translate([0.595-0.75, framewidth/2, 0]) cylinder(h=2, d=screwhole_0_80, $fn=90);
	translate([0.62-0.75, framewidth/2, 0]) cylinder(h=2, d=screwhole_0_80, $fn=90);

	//valvegear hangar mounting slot:
	translate([0.54, -0.35, 0.19]) cube([0.02, 1, 0.1]);
	
	//frame voids:
	translate([1.53,0,0.06]) 
		wedge(0.7, 0.7, 0.14);
	
	//cutout for proper firebox:
	translate([1.53,0,0.23]) 
		rotate([-180,0,0])
			wedge_angle(0.12, 0.7, 11);
	translate([1.53,-0.7/2,0.229])
		cube([0.615,0.7,0.14]);
	
	translate([0.92,-.15,.059]) cube([.33,.6,.13]);
	translate([-0.001, -0.5, -0.001]) cube([0.66, 1, 0.12]);
	
	//propulsion cutout:
	//translate([0.55,framethickness,0]) cube([0.5, framewidth-framethickness*2, 0.5]); //front driver
	//main driver???
}
//wedge(.14, .7, .7);

module frame(tab=true) {
	tablength=0.25; //extend in the cylinder block far enough to engage the screw hole...
	//K&S brass strip sku #8245, 0.064" thick, 1/4" wide, 12" long
	tabthickness=0.064;
	tabwidth=0.25;
	
	difference() {
		translate([0, -framewidth/2, 0]) { //center frame on the tram line
			difference() {
				union() {
					frame_channel(length=framelength, width=framewidth, height=frameheight, thickness=framethickness);
					if (tab) translate([-tablength,(framewidth-tabwidth)/2,0.25-tabthickness]) cube([tablength, tabwidth, tabthickness]); //cylinder chest insertion tab
				}
				union() {
					driver_slots();
					frame_voids();
				}
			}
		}
		//inset for bottom plate:
		platewidth=0.2;
		translate([0,-platewidth/2,-0.001]) cube([framelength*1.1, platewidth, 0.03]);
	}
	
	//bottom plate fastening blocks:
	blockoffset=0.029;
	blockthickness=0.03;
	difference() {
		translate([0.985,-framewidth/2,blockoffset]) cube([0.2, framewidth, blockthickness]);
		translate([1.085, 0, 0]) cylinder(h=2, d=screwhole_0_80, $fn=90);
	}
	difference() {
		translate([1.885,-framewidth/2,blockoffset]) cube([0.2, framewidth, blockthickness]);
		translate([1.985, 0, 0]) cylinder(h=2, d=screwhole_0_80, $fn=90);
	}		
}

$fn = $preview ? 90 : 180;

//translate([0.75,0,0.0]) 
scale(25.4)
	frame();

