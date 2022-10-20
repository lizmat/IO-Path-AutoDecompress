[![Actions Status](https://github.com/lizmat/IO-Path-AutoDecompress/actions/workflows/test.yml/badge.svg)](https://github.com/lizmat/IO-Path-AutoDecompress/actions)

NAME
====

IO::Path::AutoDecompress - IO::Path with automatic decompression

SYNOPSIS
========

```raku
use IO::Path::AutoDecompress;
```

DESCRIPTION
===========

IO::Path::AutoDecompress is a module that provides a subclass to `IO::Path`, that will transparently handle compressed files that are compressed with `gzip` (the `.gz` file extension) or `bzip2` (the `.bz2` extension) for the `.slurp` and `.lines` methods.

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

Copyright 2022 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

