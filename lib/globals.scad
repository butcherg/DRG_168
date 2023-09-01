/* 
	globals.scad: Variable declarations used across the DR&G #168 project


*/

adjustment20230705 = 0.075;

//driver centers, frame datum, in HO decimal inches

front_driver=0.79-adjustment20230705;
main_driver=1.39-adjustment20230705;
rear_driver=2.37-adjustment20230705;

//screw hole x coordinates

front_screw_hole = -0.15;
rear_screw_hole = 2.25-adjustment20230705;

//translate vectors.  For each part, what it takes to orient it relative to the frame, in HO decimal inches

frontend_assembly_position = [-0.785, 0, 0.08]; 

smokebox_boiler_firebox_position = [-0.462-adjustment20230705, 0, 0.295]; 
//smokebox_boiler_firebox_position = [-0.462, 0, 0.495]; 
smokebox_front_position = [-0.476-adjustment20230705, 0, 0.61]; 
168_plate_position = [-0.53-adjustment20230705, 0, 0.61];
footboards_position = [-0.748, 0, 0]; 

headlamp_position = [-0.52-adjustment20230705, 0, 0.96]; 
smokestack_position = [-0.177, 0, 0.87]; 
sanddome_position = [0.335, 0, 0.82];
steamdome_position = [1.28, 0, 0.86]; 
bell_hangar_assembly_position = [1.673-adjustment20230705, 0, 0.99]; 
generator_position = [1.909-adjustment20230705, 0, 0.935]; 
compressor_position = [1.29-adjustment20230705, -0.429, 0.4];

cab_position = [2.12205-adjustment20230705, 0, 0.272]; 
firebox_backhead_position = [2.291-adjustment20230705, 0, 0.646]; 

port_crosshead_position = [0.375-adjustment20230705, -0.34, -0.025];
starboard_crosshead_position = [0.293-adjustment20230705, 0.34, -0.025];
port_siderod_position = [0.092-adjustment20230705, -0.285, 0.089];
starboard_siderod_position = [0.0-adjustment20230705, 0.285, 0.0];
port_connecting_rod_position = [0.465+1.01-adjustment20230705, -0.34, 0.085];
starboard_connecting_rod_position = [0.38+1.01-adjustment20230705, 0.34, 0.0];

crossheadguide_hangar_position = [0.46, 0, -0.08];

cistern_position = [3.181-adjustment20230705,0,0.273]; //preliminary...
tender_frame_position = [2.91-adjustment20230705,0,0.15];

