use <../lib/brake_assembly.scad>

scale(25.4)
	mirror([0,1,0]) brake_assembly($fn=180);
