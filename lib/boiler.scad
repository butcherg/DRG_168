include <utilities.scad>

smokeboxcolor =  "dimgray";
boilercolor =  "gray";
strapcolor =  "dimgray";

module boiler(decor=true) {
	//first course:
	translate([0,0,0.61/2]) {
		if (decor) boilercourse(0.625, 0.04, 0.04);  //strap
		translate([0,0,0]) boilercourse(0.61, 0.4, 0.05);   // first course
		if (decor) translate([0.37,0,0]) boilercourse(0.625, 0.04, 0.04);  //strap
	}

	//second (tapered) course:
	translate([0.41,0,0]) //move down centerline to its position
		rotate([0,-2.3,0]) //tapered cant, bottom rests on x-axis
			translate([0,0,0.61/2]) //bottom-front on x-axis
					taperedcourse(0.61, 0.65, 0.5, 0.05);  //second course
}
$fn = $preview ? 90 : 360;
scale(25.4)
boiler($fn=90);
	