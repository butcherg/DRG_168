use <utilities.scad> //for roundedbox()
//use <../Rods/crosshead.scad>

include <../lib/globals.scad>


//includes crosshead guides, need to experiment with resins for mechanical viability...

module crossheadguide_hangar() 
{
	//width, height, material thickness, and radius of  the hangar:
	w=0.95;  //width of the hangar
	h=0.31;  //height of the hangar, puts the crosshead guides at the cylinder tops and bottoms
	t=0.02;  //thickness of the hangar and slide material
	th=0.04; //height of the slides
	r=0.05;  //radius of the hangar corners
	d=0.05; 	 //the width of the hangar body:
	
	//crosshead guide parameters:
	hlen=0.5-0.05;  //0.5 is long, to allow hangar positioning; shorten after position is determined...
	cylctr=0.68;

	translate([t,-w/2,0]) 
		rotate([0,-90,0]) 
			difference() {
				roundedbox([h, w, t], r);
				translate([d, d, -0.01]) 
					roundedbox([h-d*2, w-d*2, t*2], r);
			}
			
	//crosshead guides, positioned so they expose the inner edge in the hangar void 
	//to allow the crosshead to slide on...
	translate([0, cylctr/2,  h-(d/2)-th]) translate([-hlen+t,-t/2,0]) cube([hlen, t,th]);
	translate([0, cylctr/2,  (d/2)])   translate([-hlen+t,-t/2,0]) cube([hlen, t,th]);
	translate([0, -cylctr/2, h-(d/2)-th]) translate([-hlen+t,-t/2,0]) cube([hlen, t,th]);
	translate([0, -cylctr/2, (d/2)])   translate([-hlen+t,-t/2,0]) cube([hlen, t,th]);
}


//crossheadguide_hangar($fn=90);


//for print, uncomment, render, and export to .stl: 
scale(25.4)
	crossheadguide_hangar($fn=360);

//for itegration:
//translate([-0.3,-0.68/2,0.055]) crosshead($fn=90);

