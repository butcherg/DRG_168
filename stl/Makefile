
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
	tar -czvf DRG_168_STLs.tar.gz *.stl stl_integration.scad
