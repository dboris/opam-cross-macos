#!/bin/sh -e

HOST=$1

./configure --host=$1

make -C runtime primitives sak SAK_CC=cc SAK_LINK='cc -o $(1) $(2)'

cp `which ocamlrun` runtime/ocamlrun
cp -f Makefile.cross Makefile.config
cp -f s-macos.h runtime/caml/s.h
cp -f m-macos.h runtime/caml/m.h

make world opt \
  compilerlibs/ocamlcommon.cmxa compilerlibs/ocamlbytecomp.cmxa \
  compilerlibs/ocamloptcomp.cmxa driver/main.cmx driver/optmain.cmx \
  PROGRAMS= \
  OCAMLRUN=ocamlrun \
  NEW_OCAMLRUN=ocamlrun
