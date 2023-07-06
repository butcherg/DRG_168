ROOTDIR=../..

#files used by other files:
SCADS+=$(ROOTDIR)/Appliances/bell.scad \
$(ROOTDIR)/Appliances/bellhangar.scad \
$(ROOTDIR)/CylinderChest/frontend.scad \
$(ROOTDIR)/CylinderChest/168_pilot.scad \
$(ROOTDIR)/CylinderChest/crossheadguide_hangar.scad \
$(ROOTDIR)/Boiler-Smokebox/proper_firebox/smokebox.scad \
$(ROOTDIR)/Boiler-Smokebox/proper_firebox/boiler.scad \
$(ROOTDIR)/Boiler-Smokebox/proper_firebox/firebox.scad \
$(ROOTDIR)/Boiler-Smokebox/proper_firebox/168_plaque.scad \
$(ROOTDIR)/Appliances/smokestack.scad \
$(ROOTDIR)/Domes/sanddome.scad \
$(ROOTDIR)/Domes/steamdome.scad \
$(ROOTDIR)/Cab/cab_floor.scad \
$(ROOTDIR)/Cab/cab_rear_support.scad \

SCAD = $(notdir $(SCADS))

all: $(SCAD)

.SECONDEXPANSION:
$(SCAD): $$(filter %$$@,$$(SCADS))
	cp $< $@

clean:
	rm -f *.scad

