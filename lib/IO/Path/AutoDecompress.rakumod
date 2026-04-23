class IO::Path::AutoDecompress is IO::Path {
    method lines(IO::Path::AutoDecompress:D:
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
        elsif $extension ~~ /^(zip|rar|7z|xz)$/ {
            my $proc := run <7z e -so>, self, :out;
            $proc.out.lines(:$chomp, :$enc, :$nl-in)
        }
        else {
            self.IO::Path::lines(:$chomp, :$enc, :$nl-in)
        }
    }

    method slurp(IO::Path::AutoDecompress:D: :$enc = 'utf8') {
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

# vim: expandtab shiftwidth=4
