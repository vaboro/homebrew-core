class CKermit < Formula
  desc "Scriptable network and serial communication for UNIX and VMS"
  homepage "http://www.kermitproject.org/"
  url "http://www.kermitproject.org/ftp/kermit/archives/cku302.tar.gz"
  version "9.0.302"
  sha256 "0d5f2cd12bdab9401b4c836854ebbf241675051875557783c332a6a40dac0711"

  livecheck do
    url "http://www.kermitproject.org/ck90.html"
    regex(/The current C-Kermit release is v?(\d+(?:\.\d+)+) /i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:    "fea40d461340389165bcaf8ce5fa074d703baef9a44252d25b3a0f96c29660cf"
    sha256 cellar: :any_skip_relocation, mojave:      "3021e5f091b9bd56f3b5b1f289552ba83b1d6c10b229fac9aaeb8bbbecdc6f6e"
    sha256 cellar: :any_skip_relocation, high_sierra: "b6eae07c8d3365501f4e13af80b54ded073a2b1fc09fa885a445c7f52d96d589"
    sha256 cellar: :any_skip_relocation, sierra:      "b19ecd36ee298cba626b1276c228cdb4ee57726cf5af64166d8ff2800067e926"
    sha256 cellar: :any_skip_relocation, el_capitan:  "446776aff790c8f3b6f30be915dc18f4beffa973b92201384682beb7dc714562"
    sha256 cellar: :any_skip_relocation, yosemite:    "fe01b123ec7cddfbf46908bbf2071542a92f195d75733230896b5de78d92cdef"
    sha256 cellar: :any_skip_relocation, mavericks:   "eebf4b834242dc754c00eb87ee5cee621d39f9369cfe67cdb620a1f81a197f20"
  end

  def install
    system "make", "macosx"
    man1.mkpath

    # The makefile adds /man to the end of manroot when running install
    # hence we pass share here, not man.  If we don't pass anything it
    # uses {prefix}/man
    system "make", "prefix=#{prefix}", "manroot=#{share}", "install"
  end

  test do
    assert_match "C-Kermit #{version}",
                 shell_output("#{bin}/kermit -C VERSION,exit")
  end
end
