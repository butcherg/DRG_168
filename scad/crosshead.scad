use <../lib/utilities.scad>

h=0.2; //overall height
l=0.18; //overall length (x axis)
t=0.05; //thickness
sl=0.03; //piston slot width
pn=0.03; //piston pin hole

ih=h*0.5; //inset height
il=l*0.3; //inset length (x axis)
of=(ih-il)/2; 
d=0.4; //multiplier to ih, depth of inset proportion to inset height

//guide slot dimension:
st=0.025;

module nut_exposedbolt(nd=0.04, bd=0.02, nh=0.02, ex=1.2) {
	//nut:
	cylinder(d=nd, h=nh, $fn=6);
	//bolt:
	cylinder(d=bd, h=nh*ex, $fn=90);
}

module crosshead() {
	difference() {
		//basic shape:
		translate([0,-t/2,0]) cube([l, t, h]); 
		union() {
			//guide slots:
			translate([-l/2, -st/2,-st/2]) cube([l*2, st, st]);
			translate([-l/2, -st/2,h-st/2]) cube([l*2, st, st]);
			
			//front and back insets:
			translate([-0.001,0.5/2,h-(ih/2)]) rotate([0,90,-90]) linear_extrude(0.5) trapezoid(ih, il, ih*d, of);
			translate([l+0.001,-0.5/2,h-(ih/2)])  rotate([0,90,90]) linear_extrude(0.5) trapezoid(ih, il, ih*d, of);
			
			//piston rod slot:
			translate([il,-sl/2,(ih/2)]) cube([0.5,sl,ih]);
			//piston rod pin hole:
			translate([l/2, 0.5/2, h/2]) 
				rotate([90,0,0]) cylinder(d=pn, h=0.5);
		}
		
		
		
	}
	//piston rod receptacle:
	//K&S brass rod, 1/32", SKU #8160
	od=0.05;
	id=1/32;
	ht=0.04;
	translate([0,0,l/2+0.025/2]) 
		rotate([0,90,0]) 
			//hollow_cylinder(od=od, id=id+0.005, ht=ht); // for metal rod
			hollow_cylinder(od=od, id=id, ht=ht);
	translate([-0.5,0,l/2+0.025/2]) 
		rotate([0,90,0]) 
			cylinder(d=id, h=0.5);

	//bolts:
	nd=0.025;
	bd=0.015;
	nh=0.008;
	ex=1.15;
	//starboard:
	translate([l*0.2, -t/2, 0.03]) rotate([90,0,0]) nut_exposedbolt(nd, bd, nh, ex);
	translate([l*0.5, -t/2, 0.03]) rotate([90,0,0]) nut_exposedbolt(nd, bd, nh, ex);
	translate([l*0.8, -t/2, 0.03]) rotate([90,0,0]) nut_exposedbolt(nd, bd, nh, ex);
	
	translate([l*0.2, -t/2, 0.165]) rotate([90,0,0]) nut_exposedbolt(nd, bd, nh, ex);
	translate([l*0.5, -t/2, 0.165]) rotate([90,0,0]) nut_exposedbolt(nd, bd, nh, ex);
	translate([l*0.8, -t/2, 0.165]) rotate([90,0,0]) nut_exposedbolt(nd, bd, nh, ex);
	
	ex1=1;
	//port:
	translate([l*0.2, t/2, 0.03]) rotate([-90,0,0]) nut_exposedbolt(nd, bd, nh, ex1);
	translate([l*0.5, t/2, 0.03]) rotate([-90,0,0]) nut_exposedbolt(nd, bd, nh, ex1);
	translate([l*0.8, t/2, 0.03]) rotate([-90,0,0]) nut_exposedbolt(nd, bd, nh, ex1);
	
	translate([l*0.2, t/2, 0.165]) rotate([-90,0,0]) nut_exposedbolt(nd, bd, nh, ex1);
	translate([l*0.5, t/2, 0.165]) rotate([-90,0,0]) nut_exposedbolt(nd, bd, nh, ex1);
	translate([l*0.8, t/2, 0.165]) rotate([-90,0,0]) nut_exposedbolt(nd, bd, nh, ex1);
}

//translate([l,-0.5/2,h-(ih/2)])  rotate([0,90,90]) linear_extrude(0.5) trapezoid(ih, il, ih*0.6, of);


$fn = $preview ? 90 : 180;

scale(25.4)
	crosshead();
