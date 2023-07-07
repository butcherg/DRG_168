include <utilities.scad>
use <168_plaque.scad>
//use <../smokebox_front.scad>

smokeboxcolor =  "dimgray";
rivetfn = 10;
buildplatefn = 30;

module smokebox(decor=true) {
	translate([0,0,0.61/2]) {//bottom on x axis
		difference() {
			boilercourse(0.61, 0.6, 0.05); //smokebox
			//translate([0.315, 0, -0.5]) cylinder(h=0.5, r=0.04, $fn=90);  //screw hole
		}
		boilercourse(0.61, 0.05, 0.1); //gluing flange for smokebox front
		translate([0,-0.02, -0.61/2]) cube([0.1, 0.04, 0.08]);
		
		if (decor) {
			rotate([120,0,0])
				translate([0.04,0,0.61/2])
					rivet_course(start_x= 0, end_x=0.54, spacing=0.05, $fn=rivetfn);
			rotate([-120,0,0])
				translate([0.04,0,0.61/2])
					rivet_course(start_x= 0, end_x=0.54, spacing=0.05, $fn=rivetfn);
			translate([0.04,0,0])
				rivet_cylinder(diameter=0.305, start_deg=0, end_deg=360, spacing_deg=10, $fn=rivetfn);
			translate([0.09, 0, 0])
				rivet_cylinder(diameter=0.305, start_deg=120, end_deg=240, spacing_deg=10, $fn=rivetfn);
			translate([0.54, 0, 0])
					rivet_cylinder(diameter=0.305, start_deg=0, end_deg=360, spacing_deg=10, $fn=rivetfn);

			render() translate([0.3,-0.304,0.015]) 
				rotate([0,0,-90])
					scale([0.001,0.001,0.001]) 
						168_plaque($fn=buildplatefn);
				
			render() translate([0.3,0.304,0.015]) 
				rotate([0,0,90])
					scale([0.001,0.001,0.001]) 
						168_plaque($fn=buildplatefn);

			//translate([0.309,0,-(0.61/2)+0.026]) nutretainer_0_80(d=0.21);
					
			//rotate([40,0,0]) translate([0.3,0,0.61/2]) stanchion(height=0.08);
			//rotate([-40,0,0]) translate([0.3,0,0.61/2]) stanchion(height=0.08);
		}
	}
}

$fn = $preview ? 90 : 180;
scale(25.4)
smokebox();

//for integration:
//translate([0, 0, 0.61/2]) smokebox_front($fn=90);