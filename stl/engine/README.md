# DRG #168 Engine Core

The six files in this directory are the core parts to assemble the basic
engine.  The have been designed to allow a number of fabrication
alternatives, particularly printing the frame in metal or hand-fabication
in brass.  

## Printing

The detail embedded in the parts requires SLA (resin) printing to resolve. 
At 4k LCD resolution and 0.05mm layer height, the build plate is not
readable; let me know if a higher resolution will resove that.  For resin
printing, the cab, front end, smokebox front, and firebox backhead should be
printed at a 45-degree angle to minimize layer lines on surfaces.  The
firebox-boiler-smokebox assembly best prints vertical, to my limited
testing, but I'd be happy to hear of better alternatives.  

## Assembly

The engine parts require two 0-80 screws and nuts for assembly, one through
the cylinder chest into the smokebox (this scre will also attach the pilot
truck), and one through the rear frame through the cab attachment tab into
the firebox backhead base.  The smokebox and firebox backhead have nut
insets where the nuts can be glued with a small bit of CA adhesive.

The frame is designed to accommodate 12mm drivers on 1/8" axles from
Scalelink, https://www.scalelink.co.uk/.  They are to be held in place by a
0.02" thick brass plate, slightly smaller than 1/4" wide to fit in the
insets.  There are two 0-80 tappable screw holes in the frame bottom to
attach the plate.

## Modeling

These parts have been designed to accomodate variations in modeling; they
should support modeling of any of the T-12 class locomotives.  One exception
is the front end bolster; it is about 7 inches further forward than the
standard T-12, owing to the extension of the frame by the DRG to accommodate
a snowplow.  

Of note is that, for a powered model, the frame should be fabricated from
metal or a similarly stiff material.  The frame .stl should be
fabricate-able in Shapeways cast brass, but I haven't tried it yet.  You can
still print the frame in resin, but it won't be stiff enough to even tram
horizontally.  At this point, I believe the frame, crosshead guides, and
piston/main/siderods need to be made of metal...

The initial commit is way short of a fully-modeled locomotive.  I'm modeling
other parts/pieces for a complete locomotive that will eventually show up in
other directories of this repository.  Of note is that the backhead in the
initial commit is woefully bereft of detail; more is forthcoming.  For this
reason, you may want to avoid gluing the backhead to the cab...

These .stl files represent modeling accomplished in OpenSCAD scripts. 
Eventually, I'll also post these here, but that might take some time as they
need major re-organization to be proper engineering artifacts.
