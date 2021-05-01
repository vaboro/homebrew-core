class Jbigkit < Formula
  desc "JBIG1 data compression standard implementation"
  homepage "https://www.cl.cam.ac.uk/~mgk25/jbigkit/"
  url "https://www.cl.cam.ac.uk/~mgk25/jbigkit/download/jbigkit-2.1.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/j/jbigkit/jbigkit_2.1.orig.tar.gz"
  sha256 "de7106b6bfaf495d6865c7dd7ac6ca1381bd12e0d81405ea81e7f2167263d932"
  license "GPL-2.0"
  head "https://www.cl.cam.ac.uk/~mgk25/git/jbigkit",
       using: :git

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "16936e06d59fe44d40a3829bc60fec43cb7ca23d54b5fdf9510aca78df648460"
    sha256 cellar: :any_skip_relocation, mojave:      "887d4f100ed2264220232720a7732a969ee97df32a1c87f03897952920b6019a"
    sha256 cellar: :any_skip_relocation, high_sierra: "c8a003d12559b6f506fbd912c3b68163f7ab6022fd53e069bfbd55c813f52df5"
    sha256 cellar: :any_skip_relocation, sierra:      "831dd1ec7e8013ddc6c23641a21292eae26f397e8b61d95382a6240f18fc5602"
    sha256 cellar: :any_skip_relocation, el_capitan:  "bdec08cd92dd59183b698c6bbd9072881fdfce64b4ecb6182e405e0f2ad26c00"
    sha256 cellar: :any_skip_relocation, yosemite:    "764396342e87b84253aa06f5046f90c778cacca998ce970900cb2fdf1cfdc3fa"
    sha256 cellar: :any_skip_relocation, mavericks:   "0ce925915b984307d2e679622138143c5cc5baf832b0a16003fa1e6111a5df9f"
  end

  conflicts_with "netpbm", because: "both install `pbm.5` and `pgm.5` files"

  def install
    system "make", "CC=#{ENV.cc}", "CCFLAGS=#{ENV.cflags}"

    cd "pbmtools" do
      bin.install %w[pbmtojbg jbgtopbm pbmtojbg85 jbgtopbm85]
      man1.install %w[pbmtojbg.1 jbgtopbm.1]
      man5.install %w[pbm.5 pgm.5]
    end
    cd "libjbig" do
      lib.install Dir["lib*.a"]
      (prefix/"src").install Dir["j*.c", "j*.txt"]
      include.install Dir["j*.h"]
    end
    pkgshare.install "examples", "contrib"
  end

  test do
    system "#{bin}/jbgtopbm #{pkgshare}/examples/ccitt7.jbg | #{bin}/pbmtojbg - testoutput.jbg"
    system "/usr/bin/cmp", pkgshare/"examples/ccitt7.jbg", "testoutput.jbg"
  end
end
