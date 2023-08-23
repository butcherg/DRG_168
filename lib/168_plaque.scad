

module cylchar(txt, surface, radius, rotation, invert)
{	
	rot = 90 * invert;
	rotate([rotation,0,0])
		//translate([surface,0,radius])
		translate([0,0,radius]) 
			rotate([rot,0,rot]) linear_extrude(4) text(txt, font = "Liberation Serif:style=Bold", halign="center", valign="center");
}

module cyltext(txt, surface, radius, offset, increment, invert)
{
	for (i=[0:len(txt)]) {
		cylchar(txt[i], surface, radius, offset+(i*increment), invert);
	}
}

module 168_plaque()
{
	plaque=126;
	thickness=4;
	translate([1, 0, 0]) 
		rotate([0,90,0]) cylinder(h=thickness, d=plaque-0.1, center=true);
	translate([(thickness+1)/2,0,0]) 
		difference() {
			rotate([0,90,0]) cylinder(h=thickness*2, d=plaque, center=true);
			translate([-0.5,0,0]) 
				rotate([0,90,0]) cylinder(h=11, d=plaque-3, center=true);
		}
	
	translate([thickness,0,0]) cyltext("BALDWIN LOCOMOTIVE WORKS", 60, 55, 110, -9.7, 1);
	translate([thickness,0,0]) cyltext("PHILADELPHIA", 60, 55, 127, 9.3, -1);
	translate([thickness,0,-70]) cyltext("BURNHAM,", 60, 100, 19, -6, 1);

	translate([thickness,0,15]) rotate([90,0,90]) linear_extrude(4) 
		text("PARRY,", font = "Liberation Serif:style=Bold", halign="center", valign="center");
	translate([thickness,0,0]) rotate([90,0,90]) linear_extrude(4) 
		text("WILLIAMS&Co", font = "Liberation Serif:style=Bold", halign="center", valign="center");
	translate([thickness,0,-18]) rotate([90,0,90]) linear_extrude(4) 
		text("No6670,", font = "Liberation Serif:style=Bold", halign="center", valign="center");

	translate([thickness,0,62]) cyltext("1883.", 60, 100, 172, 5, -1);
}

$fn = $preview ? 90 : 360;
168_plaque();
