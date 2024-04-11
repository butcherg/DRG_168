include <../lib/utilities.scad>
//use <wheel_set.scad>

module frame_slot(framewidth=0.25, slot=0.129, axle=0.125, slotdepth=0.0, detentdepth=0.02)
{
	translate([-slot/2,-framewidth/2,0]) {
		translate([0,0,detentdepth]) {
			cube([slot,framewidth*2,(slot/2)+slotdepth]);
			translate([slot/2,0,(slot/2)+slotdepth]) rotate([-90,0,0]) cylinder(d=slot, h=framewidth*2);
		}
		translate([(slot-axle)/2,0,0.001]) cube([axle,framewidth*2,detentdepth]);  //detent
	}
}

module pilot_truck()
{
	slot=0.073;
	axle=0.058;
	wheelcenters=0.71;
	framewidth=0.3;
	framelength=wheelcenters + 0.16;
	translate([framelength/2, -framewidth/2, 0]) {
		difference() {
			translate([-framelength/2, 0, 0])frame_channel(length=framelength, framewidth, height = 0.125);
			translate([-wheelcenters/2,0,-0.002]) frame_slot(slot=slot, axle=axle);
			translate([wheelcenters/2,0,-0.002]) frame_slot(slot=slot, axle=axle);
			translate([0,framewidth/2,0]) cylinder(h=1, d=screwhole_0_80*2.7);
		}
		
		//translate([-wheelcenters/2, 0, 0]) driver_set($fn=90);
		
	}
	//translate([(framelength-wheelcenters)/2, 0.001, 0.05]) driver_set($fn=90);
	//translate([((framelength-wheelcenters)/2)+wheelcenters, 0.001, 0.05]) driver_set($fn=90);
}

scale(25.4)
pilot_truck($fn=90);
//frame_slot(slot=0.08, axle=0.073, $fn=90);

