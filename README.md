opam-cross-macos
================

This OPAM repository contains a macOS toolchain featuring OCaml 4.14.2.
The supported build system is GNU/Linux. The supported target systems are 64-bit
Intel or Apple Silicon Macs.

Installation
------------

Set up a [macOS cross toolchain](https://github.com/tpoechtrager/osxcross)
by following the instructions in the linked project. Add the toolchain `bin`
directory to your PATH.

Extract the macOS SDK to your Linux host. If you don't have access to a Mac, follow
[these instructons](https://github.com/tpoechtrager/osxcross#packaging-the-sdk).
Otherwise, find the SDK path `xcrun --show-sdk-path` on your Mac and copy the SDK to
the Linux host. Below we assume that the SDK is available
in `$HOME/src/cross/sdks` on Linux.

For macOS cross-compiling, switch to a regular OCaml compiler (its version must
match the version of the cross-compiler):

    opam switch 4.14.2
    eval `opam env`

or create a new switch:

    opam switch create 4.14.2-macos 4.14.2
    eval `opam env`

Add this repository to OPAM:

    opam repository add macos git://github.com/dboris/opam-cross-macos

Configure the compiler for Intel Macs:

    ARCH=amd64 SUBARCH=x86_64 SDK=13 VER=12.7.0 SDK_DIR=$HOME/src/cross/sdks TOOLPREF=x86_64-apple-darwin22.4 \
      opam install conf-macos

or for Apple Silicon Macs:

    ARCH=arm64 SUBARCH=arm64 SDK=13 VER=12.7.0 SDK_DIR=$HOME/src/cross/sdks TOOLPREF=aarch64-apple-darwin22.4 \
      opam install conf-macos

Some options can be further tweaked:

  * `SDK` specifies the SDK version being used
  * `VER` specifies the value of the `-mmacos-version-min` compiler switch,
    ie the minimum macOS version on which the compiled code will run
  * `TOOLPREF` specifies the toolchain prefix of the macOS cross toolchain
  * `SDK_DIR` specifies the directory containing the macOS SDK

The options above are recorded inside the `conf-macos` package, so make sure to
reinstall that package if you wish to switch to a different toolchain.

Install the compiler:

    opam install ocaml-macos

This project is based on [opam-cross-ios](https://github.com/ocaml-cross/opam-cross-ios) and
credit goes to its original developers. For further background and instructions how to
port OCaml packages to macOS see
[here](https://github.com/ocaml-cross/opam-cross-ios#porting-packages).