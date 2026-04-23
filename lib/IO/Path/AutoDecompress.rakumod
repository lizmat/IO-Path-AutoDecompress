# Helper class to give IO::Path a "proc" like interface
my role Proccer {
    method out() { self }
    method lines(|c) { self.IO::Path::lines(|c) }
    method slurp(|c) { self.IO::Path::slurp(|c) }
}

my class IO::Path::AutoDecompress is IO::Path {

    # Create a "proc" like object to obtain data from
    method !proc() {
        my str $extension = self.extension;
        $extension eq 'gz'
          ?? run(<gunzip --stdout>, self, :out)
          !! $extension eq 'bz2'
            ?? run(<bunzip2 --stdout>, self, :out)
            !! $extension eq 'zip' | 'rar' | '7z' | 'xz'
              ?? run(<7z e -so>, self, :out)
              !! self but Proccer
    }

    method lines(IO::Path::AutoDecompress:D:
      :$chomp = True,
      :$enc   = 'utf8',
      :$nl-in = ["\x0A", "\r\n"]
    ) {
        self!proc.out.lines(:$chomp, :$enc, :$nl-in)
    }

    method slurp(IO::Path::AutoDecompress:D: :$enc = 'utf8') {
        self!proc.out.slurp(:$enc)
    }
}

my sub IOAD($path) is export {
    IO::Path::AutoDecompress.new($path)
}

# vim: expandtab shiftwidth=4
