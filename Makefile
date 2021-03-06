#----------------------------------------------------------------------------
#
# Core makefile
#
# Tom Peterka
# Argonne National Laboratory
# 9700 S. Cass Ave.
# Argonne, IL 60439
# tpeterka@mcs.anl.gov
#
# All rights reserved. May not be used, modified, or copied
# without permission
#
#----------------------------------------------------------------------------

include ../user_defs.mk

# override the user defs to force serial mode
ifeq ($(SERIAL), YES)
MPI = NO
MPE = NO
BIL = NO
PNETCDF = NO
HDF5 = NO
ZOLTAN = NO
endif

include ../system_defs.mk

INCLUDE += -I. -I../anlcom -I../renderer -I../renderer/libgcb

OBJS =  Grid.o          polynomials.o  TimeVaryingFieldLine.o \
	eigenvals.o  Interpolator.o  Rake.o	    Topology.o \
	eigenvecs.o  IsoSurf.o	     Solution.o     triangulator.o \
	Element.o    StreakLine.o    VectorMatrix.o Field.o \
        PathLine.o   Streamline.o    FieldLine.o    Plot3DReader.o CurvilinearGrid.o\
	TimeLine.o   OSUFlow.o       FileReader.o   calc_subvolume.o 

SRCS =  Grid.C          polynomials.C  TimeVaryingFieldLine.C \
	eigenvals.C  Interpolator.C  Rake.C	    Topology.C \
	eigenvecs.C  IsoSurf.C	     Solution.C     triangulator.C \
	Element.C    StreakLine.C    VectorMatrix.C Field.C \
	PathLine.C   Streamline.C    FieldLine.C    Plot3DReader.C CurvilinearGrid.C\
	TimeLine.C   OSUFlow.C       FileReader.C   calc_subvolume.C 

.suffixes: .c

.C.o:
	$(C++) $(CCFLAGS) $(INCLUDE) $<
.c.o:
	$(CC) $(CCFLAGS) $(INCLUDE) $<

default: all

all: libOSUFlow.a 

libOSUFlow.a : $(OBJS)
	rm -f $@
	ar cru $@ $(OBJS) 

clean:
	rm -f *.o *.a

depend: Makefile $(SRCS)
	makedepend -fMakefile $(CCFLAGS) $(INCLUDE) $(SRCS)
