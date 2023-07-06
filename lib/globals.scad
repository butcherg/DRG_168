/* 
	globals.scad: Variable declarations used across the DR&G #168 project


*/

//driver centers, frame datum, in HO decimal inches

front_driver=0.79;
main_driver=1.39;
rear_driver=2.37;

//translate vectors.  For each part, what it takes to orient it relative to the frame, in HO decimal inches

frontend_assembly_position = [-0.785, 0, 0.08]; 

smokebox_boiler_firebox_position = [-0.47, 0, 0.306]; 
smokebox_front_position = [-0.476, 0, 0.61]; 
168_plate_position = [-0.53, 0, 0.61];
footboards_position = [-0.748, 0, 0]; 

headlamp_position = [-0.52, 0, 0.96]; 
smokestack_position = [-0.177, 0, 0.87]; 
sanddome_position = [0.335, 0, 0.82];
steamdome_position = [1.28, 0, 0.86]; 
bell_hangar_assembly_position = [1.673, 0, 1.0]; 
generator_position = [1.909, 0, 0.935]; 
compressor_position = [1.29, -0.429, 0.4];

cab_position = [2.12205, 0, 0.272]; 
firebox_backhead_position = [2.291, 0, 0.646]; 

port_crosshead_position = [0.375, -0.34, -0.025];
starboard_crosshead_position = [0.293, 0.34, -0.025];
port_siderod_position = [0.085, -0.285, 0.085];
starboard_siderod_position = [0.0, 0.285, 0.0];
port_connecting_rod_position = [0.465+1.01, -0.34, 0.085];
starboard_connecting_rod_position = [0.38+1.01, 0.34, 0.0];

cistern_position = [3.181,0,0.298]; //preliminary...
tender_frame_position = [2.91,0,0.175];

