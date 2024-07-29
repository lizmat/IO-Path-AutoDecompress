[![Actions Status](https://github.com/lizmat/IO-Path-AutoDecompress/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/IO-Path-AutoDecompress/actions) [![Actions Status](https://github.com/lizmat/IO-Path-AutoDecompress/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/IO-Path-AutoDecompress/actions) [![Actions Status](https://github.com/lizmat/IO-Path-AutoDecompress/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/IO-Path-AutoDecompress/actions)

NAME
====

IO::Path::AutoDecompress - IO::Path with automatic decompression

SYNOPSIS
========

```raku
use IO::Path::AutoDecompress;

# read lines from a gzipped file transparently
my $io = IO::Path::AutoDecompress.new("foobar.txt.gz");
.say for $io.lines;

# same, but using an .IO like subroutine as a method
my $io = "foobar.txt.gz".&IOAD;
.say for $io.lines;
```

DESCRIPTION
===========

IO::Path::AutoDecompress is a module that provides a subclass to `IO::Path`, that will transparently handle compressed files that are compressed with `gzip` (the `.gz` file extension) or `bzip2` (the `.bz2` extension) for the `.slurp` and `.lines` methods.

EXPORTED SUBROUTINES
====================

IOAD
----

The `IOAD` subroutine takes one positional argument and converts that to an `IO::Path::AutoDecompress` object. It is intended to be used in a way similar to the `.IO` method in core.

```raku
use IO::Path::AutoDecompress;

# using the IOAD subroutine as a method
my $io = "foobar.txt.gz".&IOAD;
.say for $io.lines;
```

PREREQUISITES
=============

This module assumes some version of the `gunzip` and `bunzip2` programs can be executed with the `--stdout` argument.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/IO-Path-AutoDecompress . Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2022, 2024 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

