ROOTDIR=../..

#primary model files
SCADS=$(ROOTDIR)/Frame/Alternate_Frame/frame.scad \
$(ROOTDIR)/Boiler-Smokebox/proper_firebox/smokebox_boiler_firebox_assembly.scad \
$(ROOTDIR)/Boiler-Smokebox/proper_firebox/smokebox_front.scad \
$(ROOTDIR)/Boiler-Smokebox/firebox_backhead.scad \
$(ROOTDIR)/Boiler-Smokebox/168_plate.scad \
$(ROOTDIR)/Boiler-Smokebox/proper_firebox/footboards.scad \
$(ROOTDIR)/Cab/cab.scad \
$(ROOTDIR)/CylinderChest/frontend_assembly.scad \
$(ROOTDIR)/Rods/siderod.scad \
$(ROOTDIR)/Rods/connecting_rod.scad \
$(ROOTDIR)/Rods/crosshead.scad \
$(ROOTDIR)/Appliances/compressor.scad \
$(ROOTDIR)/Appliances/bell_hangar_assembly.scad \
$(ROOTDIR)/Appliances/generator.scad \
$(ROOTDIR)/Appliances/headlamp.scad \
$(ROOTDIR)/Wheels/RP25.scad \
$(ROOTDIR)/Tender/cistern.scad \
$(ROOTDIR)/Tender/tender_frame.scad \
$(ROOTDIR)/Tender/tender_truck.scad 

SCAD = $(notdir $(SCADS))

all: $(SCAD)

.SECONDEXPANSION:
$(SCAD): $$(filter %$$@,$$(SCADS))
	cp $< $@

clean:
	rm -f *.scad

