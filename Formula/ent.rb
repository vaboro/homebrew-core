class Ent < Formula
  desc "Pseudorandom number sequence test program"
  homepage "https://www.fourmilab.ch/random/"
  # This tarball is versioned and smaller, though non-official
  url "https://github.com/psm14/ent/archive/1.0.tar.gz"
  sha256 "6316b9956f2e0cc39f2b934f3c53019eafe2715316c260fd5c1e5ef4523ae520"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "e51a453d227894a84db498d75bac3205f82fdd3b104b176fa691cb8ae864a14a"
    sha256 cellar: :any_skip_relocation, mojave:      "c2a9cd4a124a37767cc35a683aad913a92e712627c5ff00c43db06dbab38909f"
    sha256 cellar: :any_skip_relocation, high_sierra: "61cac8b0bcf0c511e6c77760cc9441ec7b4d981392f98d37bd8a40fd281620df"
    sha256 cellar: :any_skip_relocation, sierra:      "9f20aba355ecd3310d5e4cd425fe69d88e20e9e1bc128a4b6a97c5d98a828135"
    sha256 cellar: :any_skip_relocation, el_capitan:  "f5244a065b7aafe3ba60077de0072e9b5d231a7fd1eb348cd7f6583a69a08ad3"
    sha256 cellar: :any_skip_relocation, yosemite:    "072e3e71ee3b6813dafb15e53e8b474c1d15f26865b9cd05652e46c220e3926d"
    sha256 cellar: :any_skip_relocation, mavericks:   "cb4bd5766cdb804092f73a908921e034da352b890fdc34f5cc1f0d56a27d3c3a"
  end

  def install
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}"
    bin.install "ent"

    # Used in the below test
    prefix.install "entest.mas", "entitle.gif"
  end

  test do
    # Adapted from the test in the Makefile and entest.bat
    system "#{bin}/ent #{prefix}/entitle.gif > entest.bak"
    # The single > here was also in entest.bat
    system "#{bin}/ent -c #{prefix}/entitle.gif > entest.bak"
    system "#{bin}/ent -fc #{prefix}/entitle.gif >> entest.bak"
    system "#{bin}/ent -b #{prefix}/entitle.gif >> entest.bak"
    system "#{bin}/ent -bc #{prefix}/entitle.gif >> entest.bak"
    system "#{bin}/ent -t #{prefix}/entitle.gif >> entest.bak"
    system "#{bin}/ent -ct #{prefix}/entitle.gif >> entest.bak"
    system "#{bin}/ent -ft #{prefix}/entitle.gif >> entest.bak"
    system "#{bin}/ent -bt #{prefix}/entitle.gif >> entest.bak"
    system "#{bin}/ent -bct #{prefix}/entitle.gif >> entest.bak"
    system "diff", "entest.bak", "#{prefix}/entest.mas"
  end
end
