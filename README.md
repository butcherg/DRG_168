# DRG 168

![DRG_168](stl_integration.png)

Commputer-Aided-Design (CAD) files to produce a HOn3 model of Denver Rio Grande locomotive #168.  This steam locomotive operated on the DRG from about 1883 to 1933.  It was donated to the city of Colorado Springs, Colorado, where it was put on display in the downtown Antlers Park.  In 2015, it was leased to the Cumbres and Toltec Scenic Railroad (C&TS) for restoration to operation.  It now runs special trains on the C&TS from Antonito, Colorado.

The locomotive design was created using OpenSCAD, a script-based CAD program, open-source.  This program may be downloaded at https://openscad.org/ 

All purpose-developed artifacts in this repository are copyrighted 2022 by Glenn Butcher, all rights reserved.  The artifacts are licensed for use under the terms and conditions of the Creative Commons Attribution 4.0 International (CC BY 4.0) license, terms are available here: https://creativecommons.org/licenses/by/4.0/

There are two external libraries used by this code.  For convenience, I've included the libraries in this repo so you don't have to download and install them.  Their respective licenses are:

- path_extrude: Developed by David Eccles, licensed by him for use under the terms of the GNU General Purpose License v3.0.  https://gitlab.com/gringer/bioinfscripts/blob/master/path_extrude.scad
- polyround: Developed by Kurt Hutten as part of his Round-Anything library, licensed by him for use under the terms of the MIT License.  https://github.com/Irev-Dev/Round-Anything

Additionally, all artifacts in this repository are available "as-is", with no warranty of performance.

NOTE: At this date (7/6/2023) this project is still work-in-progress, that is, there are numerous things missing to make a complete locomotive.

## Directories and Files

The repo is comprised of three directories:

1. stl: This directory is for generating STL mesh files from the OpenSCAD scripts in scad/. The Makefile in this directory is for use with GNU/Unix make to create each .stl from its corresponding .scad script, see "Building STLs" below for instructions.  For those not familiar, the Makefile will check each .stl file date with the corresponding .scad file date and only run OpenSCAD to build/rebuild the .stl if the .scad file is newer.  This saves considerable time making changes to single .scad scripts and making only the affected .stls.  The Makefile has specifics that pertain to my installation; change them to your situation if you intend to use it.  Also of note is that some .stl files will report mesh errors, although I'll make sure they're not egregious enough to affect printing.

2. scad: This directory contains the .scad files to build each corresponding .stl.  Some files are named xxx_assembly.scad, which signifies that the part is an amalgam of two or more subsidiary parts and corresponding .scad files.

3. lib: This directory contains the .scad files that are required by the .scad files in scad/  Some of them are sub-assemblies, others are libraries of useful OpenSCAD modules.  utilities.scad is a collection of modules I wrote specifically for building #168, most which could be used in other locomotive models.  Two files, polyround.scad and path_extrude.scad, are libraries from the external sources identified in the license paragraphs above; these two files were crucial to developing the curvy surfaces that are vintage steam locomotives.  Note: The scripts in scad/ reference these scripts through relative paths, so putting updates in the regular OpenSCAD library directories won't be referenced.

## Building STLs

### Prerequisites
- OpenSCAD (required): You can get this program at https://openscad.org, or install it from your operating systems' package repository (Linux). For the Makefile in the stl/ directory to work, the OpenSCAD executable needs to be in a directory that can be seen from a command line terminal window.  NOTE: OpenSCAD developers are currently integrating a new mesh library, Manifold.  This library is multiple orders of magnitude faster than the old CGAL library; to use it you need to download one of the nightly builds available further down the Download page.  DRG_168 scripts generate LARGE meshes, so using this version is advised.  I'll remove this note when OpenSCAD releases a Manifold-based version.
- Mesh-fixing program (optional): The OpenSCAD scripts in this repository will generate STL meshes that can be successfully printed, but some may contain various errors reported by some software.  Any number of mesh-fixing programs are available to correct these errors; Windows 3D Builder is my current favorite. If you're using Windows 11, 3D Builder is probably already available on your computer.  For Linux operating systems, Meshlab would be my choice, but it is a lot more difficult to use.

### Building with the Makefile
Using GNU make:
```
cd stl
make
```
Takes about 2.5 minutes on my 4Ghz Ubuntu desktop.

The file stl/SCADMakefile is for use with a program I wrote called scadmake.  It essentially does the same thing as the GNU Makefile; indeed, the Makefile was generated with scadmake.  You can use scadmake instead of GNU make and the Makefile to make the scad/*.scad files into the stl/ directory; it can be gotten here:

https://github.com/butcherg/SCADMake


### Building Individual Parts

Run OpenSCAD, open the .scad file you want to work with in the scad directory.  Note: If you move a .scad file to another directory, you may break linkages to other files it depends on in the lib/ directory.  Afer opening, hit the F6 key to render a mesh, then export it with File->Export->Export as STL...

### Assembling Tne Model

The current model (2023-10-16) is static, that is, no motor for running.  I'll eventually add versions of certain parts to make an operable model, but it will also require some metalwork.  The assembly insructions below do not include painting; it's your discretion regarding where to paint what in the assembly sequence.

#### Required Materials/Parts:
1. Two 0-80 screws and nuts for the major assembly
2. Two short 0-80 screws for driver retainer plate
3. 1/4" x 1/16" brass strip, K&S brass strip SKU #8245
4. 0.025" brass sheet, K&S SKU 16405
5. 24 gauge brass wire for piping, pilot supports
6. 30 gauge brass wire for the cut levers, piping
7. 40 link per inch chain (couplers)

#### Assembly Sequence
1. Build the .stl files and resin-print them. There's a lot of detail that'll be lost in a FDM print.  You're on your own for supports, although some guidance can be found at my blog of the build, https://glenn.pulpitrock.net/blog.  Note that you'll need three each of the driver sets, six of the wheel sets, two each of the siderod, connecting rod, and crosshead.
2. Mount a 0-80 nut in the nut retainers of the firebox backhead and the smokebox. CA glue works for securing them; run a screw through each after mounting/gluing to clear any glue that may have seeped into the center.
3. Cut a length of 1/4" x 1/16" brass to the dimension of the frame spine defined in stl_integration.scad. I'm not including the length here to keep from getting out of sync with the spine defined in the .scad file; it's worth it to render and print it to use as a pattern.
4. Drill the two holes in the spine at the locations defined in the spine pattern (okay, you need to print the pattern ).
5. Glue the frame to the spine, aligning the two parts flush at the rear.  The rear holes of the frame and spine should line up.
6. Stack the firebox backhead into the cab from the front, aligning the screw holes, then place them on the frame/spine and screw the whole thing together with a 0-90 screw.
7. Glue the crosshead guide hangar to the slots for the slides in the rear of the cylinders.
8. Drill out the cylinder centers from the rear to about halfway in.
9. Slide the front of the frame spine through the crosshead hangar slot all the way into the cylinder chest. Be careful sliding it through the crosshead hangar, as it's rather fragile.  Make sure the spine front hole and the cylinder chest hole are aligned.
10. Assemble the pilot truck by snapping two of the wheel sets into the pilot truck frame.
11. Slide the rear of the boiler assembly onto the backhead, up to the ring of rivets on the backhead.  The boiler assembly should rest on the cradle of the cylinder chest. 
12. Thread a 0-90 screw with washer through the pilot truck, into the bottom of the cylinder chest, through the frame spine, and up to the boiler's 0-90 nut and screw into place.  This concludes the assembly of the major engine parts.
13. Drivers are placed in the frame slots and retained with a plate cut from 0.025" thick brass sheet, 1/4" wide. There's no pattern for this, eyeball the length and placement of the screw holes with the frame.  Tap the two holes on the underside of the frame with a 0-80 tap, then attach the plate with 0-80 screws.
14. Cut some small lengths of 24 gauge wire and glue into the crank holes of the drivers.  Install with glue the siderods and connecting rods onto the wires, and into the crossheads.
15. Glue the compressor, generator, bell, and headlamp into their respective places on the boiler.  There are alignment dimples for the compressor top and generator front, and alignment flanges for the headlamp.
16. Pilot supports are cut from 24 gauge wire, front ends insert straight into the pilot beam and glued, bend a bit of the rear ends and insert into the plates on the smokebox with the accommodating holes, DO NOT GLUE, to allow disassembly.
17. Detailing the model is at your discretion.  There are supports for the cut levers that accept 30 gauge wire. Handrails can be cut from 24 gauge piano wire, threaded through the boiler stanchions and into the cab mounting holes and glued.  Piping can be run from the compressor to the cab and from the sandbox down below the foot boards.
18. Tender - TBD


## Hacking

Modeling #168 is a work-in-progress that I'm documenting at a blog:  https://glenn.pulpitrock.net/blog/. This is a good place to read about how I organized various scripts, very important to understand if you're going to modify them.

Using any of these .stl or .scad files in other projects is encouraged, as long as the Creative Commons attribution terms are respected.

stl_integration.scad is useful to inspect part relationships for fit.  All of the .stls are loaded and placed per the coordinates defined in globals.scad.  Also rendered here are positioning aids such as handrails.  One component is rendered here that is required to complete the model, the frame spine, which is a length of 1/4" x 1/16" brass with two holes to accommodate the assembly screws.  

A lot of the locomotive was modeled with extrusions from polygons.  It is rather difficult to craft a point array for such polygons by just typing in numbers, so I wrote a program with which to plot polygon points, wxPolygon.  It lets one construct a polygon visually, copy the numbers to the clipboard, then paste them into an OpenSCAD script properly formatted. It also will incorporate a radius for each point, allowing the point array to be used with polyRound() to round the corners.  Saved me a bunch of time over hand-coding, and can be found here:

https://github.com/butcherg/wxpolygon

At some point in the near future, I'm going to start posting releases, which will contain the .stl files from the .stl directory, further run through a mesh fixer so there will be no mesh errors to cause angst.


