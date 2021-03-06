class Exiftool < Formula
  desc "Perl lib for reading and writing EXIF metadata"
  homepage "https://exiftool.org"
  # Ensure release is tagged production before submitting.
  # https://exiftool.org/history.html
  url "https://exiftool.org/Image-ExifTool-12.00.tar.gz"
  sha256 "d0792cc94ab58a8b3d81b18ccdb8b43848c8fb901b5b7caecdcb68689c6c855a"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  livecheck do
    url "https://exiftool.org/history.html"
    regex(/production release is.*?href=.*?Image[._-]ExifTool[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "94e6bea5ede141fec762e7c7e06e1434d84b90695388cf269787ae77ece01cda"
    sha256 cellar: :any_skip_relocation, mojave:      "94e6bea5ede141fec762e7c7e06e1434d84b90695388cf269787ae77ece01cda"
    sha256 cellar: :any_skip_relocation, high_sierra: "b7aa0c2aa1d2e0e1d2eab87c16c180153f62715e780f31a83f2f081d8f91b620"
  end

  def install
    # replace the hard-coded path to the lib directory
    inreplace "exiftool", "$1/lib", libexec/"lib"

    system "perl", "Makefile.PL"
    system "make", "all"
    libexec.install "lib"
    bin.install "exiftool"
    doc.install Dir["html/*"]
    man1.install "blib/man1/exiftool.1"
    man3.install Dir["blib/man3/*"]
  end

  test do
    test_image = test_fixtures("test.jpg")
    assert_match %r{MIME Type\s+: image/jpeg},
                 shell_output("#{bin}/exiftool #{test_image}")
  end
end
