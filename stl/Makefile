
OPENSCAD=/home/glenn/3DPrinting/openscad/build-release/openscad --enable=manifold

SRC  := ../scad
OBJ  := .
BIN  := .
SRCS := $(wildcard $(SRC)/*.scad)
OBJS := $(patsubst $(SRC)/%.scad,%.stl,$(SRCS))
EXE  := foo.txt
BASENAMES    := $(patsubst $(SRC)/%.scad,%,$(SCADS))

.PHONY: all clean

all: $(OBJS)

$(OBJ)/%.stl: $(SRC)/%.scad | $(OBJ)
	$(OPENSCAD) --export-format binstl -o $@ $<

clean:
	rm -f *.stl

dist:
	mkdir DRG_168
	cp ../lib/globals.scad DRG_168/.
	cp *.stl DRG_168/.
	cp stl_integration.scad DRG_168/.
	sed -i 's/\.\.\/lib\///g' DRG_168/stl_integration.scad
	tar -czvf DRG_168_STLs.tar.gz DRG_168
	rm -rf DRG_168
