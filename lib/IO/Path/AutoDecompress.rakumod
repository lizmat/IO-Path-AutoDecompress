class IO::Path::AutoDecompress is IO::Path {
    method lines(
      :$chomp = True,
      :$enc   = 'utf8',
      :$nl-in = ["\x0A", "\r\n"]
    ) {
        my str $extension = self.extension;
        if $extension eq 'gz' {
            my $proc := run <gunzip --stdout>, self, :out;
            $proc.out.lines(:$chomp, :$enc, :$nl-in)
        }
        elsif $extension eq 'bz2' {
            my $proc := run <bunzip2 --stdout>, self, :out;
            $proc.out.lines(:$chomp, :$enc, :$nl-in)
        }
        else {
            self.IO::Path::lines(:$chomp, :$enc, :$nl-in)
        }
    }

    method slurp(:$enc = 'utf8') {
        my str $extension = self.extension;
        if $extension eq 'gz' {
            my $proc := run <gunzip --stdout>, self, :out;
            $proc.out.slurp(:$enc)
        }
        elsif $extension eq 'bz2' {
            my $proc := run <bunzip2 --stdout>, self, :out;
            $proc.out.slurp(:$enc)
        }
        else {
            self.IO::Path::slurp(:$enc)
        }
    }
}

my sub IOAD($path) is export {
    IO::Path::AutoDecompress.new($path)
}

=begin pod

=head1 NAME

IO::Path::AutoDecompress - IO::Path with automatic decompression

=head1 SYNOPSIS

=begin code :lang<raku>

use IO::Path::AutoDecompress;

# read lines from a gzipped file transparently
my $io = IO::Path::AutoDecompress.new("foobar.txt.gz");
.say for $io.lines;

# same, but using an .IO like subroutine as a method
my $io = "foobar.txt.gz".&IOAD;
.say for $io.lines;

=end code

=head1 DESCRIPTION

IO::Path::AutoDecompress is a module that provides a subclass to
C<IO::Path>, that will transparently handle compressed files that
are compressed with C<gzip> (the C<.gz> file extension) or C<bzip2>
(the C<.bz2> extension) for the C<.slurp> and C<.lines> methods.

=head1 EXPORTED SUBROUTINES

=head2 IOAD

The C<IOAD> subroutine takes one positional argument and converts
that to an C<IO::Path::AutoDecompress> object.  It is intended to
be used in a way similar to the C<.IO> method in core.

=begin code :lang<raku>

use IO::Path::AutoDecompress;

# using the IOAD subroutine as a method
my $io = "foobar.txt.gz".&IOAD;
.say for $io.lines;

=end code

=head1 PREREQUISITES

This module assumes some version of the C<gunzip> and C<bunzip2>
programs can be executed with the C<--stdout> argument.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/IO-Path-AutoDecompress .
Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

=head1 COPYRIGHT AND LICENSE

Copyright 2022, 2024 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
