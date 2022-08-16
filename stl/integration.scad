// A 'sanity-check' integration of the six main component .stl 
// files of the engine.
//
// Rotate around the model by holding down the left mouse button
// and dragging.  Slide the view around by doing the same thing, 
// but with the right mouse button.  Zoom in and out of the view
// with the mouse wheel.
//
// If you want to view only certain parts, put '//' in front of 
// the lines of parts you don't want to see, the press F5 to re-
// render the view.


color("#000000") import("newframe.stl");
translate([53.6,0,6.3])  color("#333333") import("cab.stl");
translate([57.9,0,15.5]) color("#666666") import("firebox_backhead.stl");
translate([-12,0,7.65])  color("#999999") import("smokebox_boiler_firebox.stl");
translate([-12,0,15.38]) color("#CCCCCC") import("smokebox_front.stl");
translate([-19.06,0,2])  color("#FFFFFF") import("frontend.stl");
