OPENSCAD=/usr/bin/openscad

#put an alternate definition of OPENSCAD i OpenSCAD.mk.  Put OpenSCAD.mk in the top level .gitignore
#Use this to include alternate OpenSCAD locations or OpenSCAD switches, e.g.,
#OPENSCAD=/usr/local/bin/openscad --enable=manifold --enable=lazy-union
-include OpenSCAD.mk

all: 168_plate.stl bell_hangar_assembly.stl cab.stl cistern.stl compressor.stl connecting_rod.stl crosshead.stl crossheadguide_hangar.stl driver_set.stl firebox_backhead.stl footboards.stl frame.stl frontend_assembly.stl generator.stl headlamp.stl siderod.stl smokebox_boiler_firebox_assembly.stl smokebox_front.stl tender_frame.stl tender_truck.stl 

168_plate.stl: ../scad/168_plate.scad | ../lib/Round-Anything/polyround.scad 
	$(OPENSCAD) --export-format binstl -o 168_plate.stl ../scad/168_plate.scad

bell_hangar_assembly.stl: ../scad/bell_hangar_assembly.scad | ../lib/bell.scad ../lib/bellhangar.scad 
	$(OPENSCAD) --export-format binstl -o bell_hangar_assembly.stl ../scad/bell_hangar_assembly.scad

cab.stl: ../scad/cab.scad | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad ../lib/cab_floor.scad ../lib/utilities.scad ../lib/globals.scad 
	$(OPENSCAD) --export-format binstl -o cab.stl ../scad/cab.scad

cistern.stl: ../scad/cistern.scad | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad ../lib/path_extrude.scad 
	$(OPENSCAD) --export-format binstl -o cistern.stl ../scad/cistern.scad

compressor.stl: ../scad/compressor.scad | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o compressor.stl ../scad/compressor.scad

connecting_rod.stl: ../scad/connecting_rod.scad | ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o connecting_rod.stl ../scad/connecting_rod.scad

crosshead.stl: ../scad/crosshead.scad | ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o crosshead.stl ../scad/crosshead.scad

crossheadguide_hangar.stl: ../scad/crossheadguide_hangar.scad | utilities.scad globals.scad 
	$(OPENSCAD) --export-format binstl -o crossheadguide_hangar.stl ../scad/crossheadguide_hangar.scad

driver_set.stl: ../scad/driver_set.scad | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o driver_set.stl ../scad/driver_set.scad

firebox_backhead.stl: ../scad/firebox_backhead.scad | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad ../lib/globals.scad 
	$(OPENSCAD) --export-format binstl -o firebox_backhead.stl ../scad/firebox_backhead.scad

footboards.stl: ../scad/footboards.scad | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad smokebox_boiler_firebox_assembly.scad 
	$(OPENSCAD) --export-format binstl -o footboards.stl ../scad/footboards.scad

frame.stl: ../scad/frame.scad | ../lib/utilities.scad ../lib/globals.scad 
	$(OPENSCAD) --export-format binstl -o frame.stl ../scad/frame.scad

frontend_assembly.stl: ../scad/frontend_assembly.scad | ../lib/frontend.scad ../lib/168_pilot.scad ../lib/crossheadguide_hangar.scad ../lib/utilities.scad ../lib/globals.scad 
	$(OPENSCAD) --export-format binstl -o frontend_assembly.stl ../scad/frontend_assembly.scad

generator.stl: ../scad/generator.scad | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o generator.stl ../scad/generator.scad

headlamp.stl: ../scad/headlamp.scad | ../lib/utilities.scad ../lib/Round-Anything/polyround.scad 
	$(OPENSCAD) --export-format binstl -o headlamp.stl ../scad/headlamp.scad

siderod.stl: ../scad/siderod.scad | ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o siderod.stl ../scad/siderod.scad

smokebox_boiler_firebox_assembly.stl: ../scad/smokebox_boiler_firebox_assembly.scad | ../lib/smokebox.scad ../lib/boiler.scad ../lib/firebox.scad ../lib/smokestack.scad ../lib/sanddome.scad ../lib/steamdome.scad ../lib/utilities.scad ../lib/globals.scad footboards.scad 
	$(OPENSCAD) --export-format binstl -o smokebox_boiler_firebox_assembly.stl ../scad/smokebox_boiler_firebox_assembly.scad

smokebox_front.stl: ../scad/smokebox_front.scad | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o smokebox_front.stl ../scad/smokebox_front.scad

tender_frame.stl: ../scad/tender_frame.scad | ../lib/Round-Anything/polyround.scad 
	$(OPENSCAD) --export-format binstl -o tender_frame.stl ../scad/tender_frame.scad

tender_truck.stl: ../scad/tender_truck.scad | ../lib/utilities.scad ../lib/Round-Anything/polyround.scad 
	$(OPENSCAD) --export-format binstl -o tender_truck.stl ../scad/tender_truck.scad


#targets for files that the scripts in ../scad need; are not built (stl)

utilities.scad: 
	
../lib/utilities.scad: 
	
../lib/168_pilot.scad: 
	
../lib/crossheadguide_hangar.scad: 
	
../lib/bell.scad: 
	
../lib/bellhangar.scad: 
	
../lib/firebox.scad: 
	
../lib/Round-Anything/polyround.scad: 
	
footboards.scad: 
	
../lib/cab_floor.scad: 
	
smokebox_boiler_firebox_assembly.scad: 
	
../lib/path_extrude.scad: 
	
../lib/smokestack.scad: 
	
../lib/globals.scad: 
	
globals.scad: 
	
../lib/steamdome.scad: 
	
../lib/sanddome.scad: 
	
../lib/frontend.scad: 
	
../lib/boiler.scad: 
	
../lib/smokebox.scad: 
	

clean:
	rm -f *.stl

dist:
	mkdir DRG_168
	cp ../lib/globals.scad DRG_168/.
	cp ../lib/RP15_rail.scad DRG_168/.
	cp *.stl DRG_168/.
	cp stl_integration.scad DRG_168/.
	sed -i 's/\.\.\/lib\///g' DRG_168/stl_integration.scad
	#sed 's/\/\///' DRG_168/stl_integration.scad > DRG_168/foo.scad
	#$(OPENSCAD) --export-format 3mf -o DRG_168/stl_integration.3mf DRG_168/foo.scad
	$(OPENSCAD) --export-format 3mf -o DRG_168/stl_integration.3mf DRG_168/stl_integration.scad
	#rm DRG_168/foo.scad
	tar -czvf DRG_168.tar.gz DRG_168
#	rm -rf DRG_168

stldist:
	mkdir DRG_168
	cp *.stl DRG_168/.
	tar -czvf DRG_168_STLs.tar.gz DRG_168
	rm -rf DRG_168
