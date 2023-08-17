OPENSCAD=/home/glenn/3DPrinting/openscad/build-release/openscad --enable=manifold --enable=lazy-union

all: 168_pilot.stl 168_plate.stl bell_hangar_assembly.stl cab.stl cistern.stl compressor.stl connecting_rod.stl crosshead.stl driver_set.stl firebox_backhead.stl footboards.stl frame.stl frontend_assembly.stl generator.stl headlamp.stl siderod.stl smokebox_boiler_firebox_assembly.stl smokebox_front.stl tender_frame.stl tender_truck.stl 

168_pilot.stl: | ../lib/utilities.scad ../lib/Round-Anything/polyround.scad 
	$(OPENSCAD) --export-format binstl -o 168_pilot.stl ../scad/168_pilot.scad

168_plate.stl: | ../lib/Round-Anything/polyround.scad 
	$(OPENSCAD) --export-format binstl -o 168_plate.stl ../scad/168_plate.scad

bell_hangar_assembly.stl: | ../lib/bell.scad ../lib/bellhangar.scad 
	$(OPENSCAD) --export-format binstl -o bell_hangar_assembly.stl ../scad/bell_hangar_assembly.scad

cab.stl: | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad ../lib/cab_floor.scad ../lib/utilities.scad ../lib/globals.scad 
	$(OPENSCAD) --export-format binstl -o cab.stl ../scad/cab.scad

cistern.stl: | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad ../lib/path_extrude.scad 
	$(OPENSCAD) --export-format binstl -o cistern.stl ../scad/cistern.scad

compressor.stl: | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o compressor.stl ../scad/compressor.scad

connecting_rod.stl: | ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o connecting_rod.stl ../scad/connecting_rod.scad

crosshead.stl: | ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o crosshead.stl ../scad/crosshead.scad

driver_set.stl: | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o driver_set.stl ../scad/driver_set.scad

firebox_backhead.stl: | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad ../lib/globals.scad 
	$(OPENSCAD) --export-format binstl -o firebox_backhead.stl ../scad/firebox_backhead.scad

footboards.stl: | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad smokebox_boiler_firebox_assembly.scad 
	$(OPENSCAD) --export-format binstl -o footboards.stl ../scad/footboards.scad

frame.stl: | ../lib/utilities.scad ../lib/globals.scad 
	$(OPENSCAD) --export-format binstl -o frame.stl ../scad/frame.scad

frontend_assembly.stl: | ../lib/frontend.scad ../lib/crossheadguide_hangar.scad ../lib/utilities.scad ../lib/globals.scad 
	$(OPENSCAD) --export-format binstl -o frontend_assembly.stl ../scad/frontend_assembly.scad

generator.stl: | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o generator.stl ../scad/generator.scad

headlamp.stl: | ../lib/utilities.scad ../lib/Round-Anything/polyround.scad 
	$(OPENSCAD) --export-format binstl -o headlamp.stl ../scad/headlamp.scad

siderod.stl: | ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o siderod.stl ../scad/siderod.scad

smokebox_boiler_firebox_assembly.stl: | ../lib/smokebox.scad ../lib/boiler.scad ../lib/firebox.scad ../lib/smokestack.scad ../lib/sanddome.scad ../lib/steamdome.scad ../lib/utilities.scad ../lib/globals.scad footboards.scad 
	$(OPENSCAD) --export-format binstl -o smokebox_boiler_firebox_assembly.stl ../scad/smokebox_boiler_firebox_assembly.scad

smokebox_front.stl: | ../lib/Round-Anything/polyround.scad ../lib/utilities.scad 
	$(OPENSCAD) --export-format binstl -o smokebox_front.stl ../scad/smokebox_front.scad

tender_frame.stl: | ../lib/Round-Anything/polyround.scad 
	$(OPENSCAD) --export-format binstl -o tender_frame.stl ../scad/tender_frame.scad

tender_truck.stl: | ../lib/utilities.scad ../lib/Round-Anything/polyround.scad 
	$(OPENSCAD) --export-format binstl -o tender_truck.stl ../scad/tender_truck.scad


#targets for files that the scripts in ../scad need; are not built (stl)

../lib/path_extrude.scad: 
	
../lib/utilities.scad: 
	
../lib/frontend.scad: 
	
smokebox_boiler_firebox_assembly.scad: 
	
../lib/boiler.scad: 
	
../lib/crossheadguide_hangar.scad: 
	
../lib/bell.scad: 
	
footboards.scad: 
	
../lib/cab_floor.scad: 
	
../lib/firebox.scad: 
	
../lib/smokestack.scad: 
	
../lib/sanddome.scad: 
	
../lib/steamdome.scad: 
	
../lib/bellhangar.scad: 
	
../lib/Round-Anything/polyround.scad: 
	
../lib/globals.scad: 
	
../lib/smokebox.scad: 
	

clean:
	rm -f *.stl

dist:
	mkdir DRG_168
	cp ../lib/globals.scad DRG_168/.
	cp *.stl DRG_168/.
	cp stl_integration.scad DRG_168/.
	sed -i 's/\.\.\/lib\///g' DRG_168/stl_integration.scad
	sed 's/\/\///' DRG_168/stl_integration.scad > DRG_168/foo.scad
	$(OPENSCAD) --export-format 3mf -o DRG_168/stl_integration.3mf DRG_168/foo.scad
	rm DRG_168/foo.scad
	tar -czvf DRG_168_STLs.tar.gz DRG_168
	rm -rf DRG_168

