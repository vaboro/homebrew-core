class Lcs < Formula
  desc "Satirical console-based political role-playing/strategy game"
  homepage "https://sourceforge.net/projects/lcsgame/"
  url "https://svn.code.sf.net/p/lcsgame/code/trunk", revision: "738"
  version "4.07.4b"
  license "GPL-2.0"
  head "https://svn.code.sf.net/p/lcsgame/code/trunk"

  bottle do
    sha256 catalina:    "65391613e5fd3ea3d8e5f7a2d5586105e3408bb09cddb77aebcfd4bcb7e3396a"
    sha256 mojave:      "91469578607a9f4d1ae989ee523f2b5dd97c976d32d9a822769129df828163e5"
    sha256 high_sierra: "5b640b7b87dfe6603670addce1b6af77b0cd7ebbda10c445fddc6d365960e761"
    sha256 sierra:      "a8fa614ec5adc3ee2d7417a024bf5e9c78e9f8d4e043e0b916dc5a99f1bb1d9c"
    sha256 el_capitan:  "621487b12c93a9b37e1330041f979a28d3d310c1d8c9efecf274808d081d510e"
    sha256 yosemite:    "9ca23650e17e177c4c9fa5352dc81a9f415bc3778b2fd8a55330936eb4d7d28c"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./bootstrap"
    system "./configure", "LIBS=-liconv", "--prefix=#{prefix}"
    system "make", "install"
  end
end
