use <Round-Anything/polyround.scad>
use <path_extrude.scad>
use <utilities.scad>
use <bell.scad>

/* original:
bhy=0.015;
bhx=0.029;
bhr1=0.3;
bhr2=0.03;
		*/

/* iteration 1:
bhy=0.025;
bhx=0.035;
bhr1=0.3;
bhr2=0.03;
*/

//iteration 2:		
bhy=0.03;
bhx=0.04;
bhr1=0.3;
bhr2=0.03;

bellhangarprofile_pts = [
	[0, bhx/2, bhr1],
	[bhy/2,   bhx, bhr2],
	[bhy, bhx/2, bhr1],
	[bhy/2, 0, bhr2]
];
profile_pts = polyRound(bellhangarprofile_pts, 30); //add radii points to the point array

module lever() {
		
	lever_pts = [
			[0,0,0],
			[0,0.02,0.02],
			[0.01,0.04,0.02],
			[0.01,0.05,0]
	];
	
	lever_path_pts = addnum(polyRound(lever_pts, 50),0);
	//cradle_profile_pts = polyRound(bellhangarprofile_pts, 30);
	//path_extrude(exPath=lever_path_pts, exShape=cradle_profile_pts);
	path_extrude(exPath=lever_path_pts, exShape=profile_pts);
	difference() {
		translate([0.0169,0.055,-bhx/2]) rotate([0,90,0]) cylinder(d=bhx, h=bhy/2+0.001);
		translate([0,0.055,-bhx/2]) rotate([0,90,0]) cylinder(d=0.01, h=0.04);
	}
}

module bellhangar() {
	rotate([90,0,0]) {

		hangaroffset=0.015;
	
		cradle_pts = [
			[0.0000,0.0000,0.0000],
			[0.0267,0.0013,0.0900],
			[0.0483,0.0078,0.0900],
			[0.0657,0.0172,0.0200],
			[0.0741,0.0278,0.0200],
			[0.0741,0.0515,0.0200],
			[0.0569,0.0709,0.0400],
			[0.0569,0.0879,0.0000]
		];

		//cradle:
		cradle_path_pts = addnum(polyRound(cradle_pts, 50),0);
		translate([-0.001,0,bhx/2]) //hangaroffset]) 
			path_extrude(exPath=cradle_path_pts, exShape=profile_pts);
		translate([0.001,0,-bhx/2]) 
			rotate([0,180,0]) 
				path_extrude(exPath=cradle_path_pts, exShape=profile_pts);

		//cradle pillar:

		pillar_pts = [
			[0.0000,0.0000,0.0000],
			[0.0000,0.0290,0.0000],
			[bhx/2,0.0290,0.0000],
			[(bhx*0.7)/2,0.0207,0.0200],
			[(bhx*0.7)/2,0.0097,0.0200],
			[(bhx*1.3)/2,0.0000,0.0000]
		];
		
		translate([0,-0.044,0]) rotate([-90,0,0]) rotate_extrude() polygon(polyRound(pillar_pts, 30));

		//yoke:
		yokew=0.04;
		yokeh=0.04;
		yokep=0.09;
		yoke_pts = [
			[yokew, yokep, 0],
			[yokew, yokep+yokeh, 0.02],
			[-yokew, yokep+yokeh, 0.02],
			[-yokew, yokep, 0]
		];
	
		yoke_path_pts = addnum(polyRound(yoke_pts, 50),0);

		translate([0,0,bhx/2]) 
			path_extrude(exPath=yoke_path_pts, exShape=profile_pts);


		//cradle pivots:
		translate([0.046,0.09,0]) rotate([0,90,0]) cylinder(d=bhx*0.9, h=0.049);
		translate([-0.046,0.09,0]) rotate([0,-90,0]) cylinder(d=bhx*0.9, h=0.042);
	
		//yoke pillar:
		translate([0,0.159,0]) rotate([90,0,0]) cylinder(d=bhx, h=0.03);
		translate([0,0.155,0]) rotate([90,0,0]) cylinder(d=0.019, h=0.03); //bell insert pin
		translate([0,0.17,0]) rotate([90,0,0]) cylinder(d=0.025, h=0.03);
		translate([0,0.17,0]) sphere(0.015);
		
		//base:
		difference() {
			translate([0,-0.039,0]) rotate([90,0,0]) cylinder(d=0.09, h=0.012);
			translate([0,-0.65/2-0.047,-0.2/2]) cylinder(d=0.65, h=0.2);
		}
		//base bolts:
		translate([0.034,-0.034,0]) rotate([90,0,0]) cylinder(d=0.012, h=0.01, $fn=6);
		translate([-0.034,-0.034,0]) rotate([90,0,0]) cylinder(d=0.012, h=0.01, $fn=6);
		translate([0,-0.034,0.034]) rotate([90,0,0]) cylinder(d=0.012, h=0.01, $fn=6);
		translate([0,-0.034,-0.034]) rotate([90,0,0]) cylinder(d=0.012, h=0.01, $fn=6);
		
		//lever:
		translate([0.068, 0.095, bhx/2]) //don't let y coord embed lever in yoke pivot too much; stl render fails...
			lever();
		
	}
}


//translate([0, 0, 0.02]) bell();
bellhangar($fn=90);

//lever($fn=90);

