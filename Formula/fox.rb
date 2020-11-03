class Fox < Formula
  desc "Toolkit for developing Graphical User Interfaces easily"
  homepage "http://www.fox-toolkit.org/"
  url "http://fox-toolkit.org/ftp/fox-1.6.56.tar.gz"
  sha256 "c517e5fcac0e6b78ca003cc167db4f79d89e230e5085334253e1d3f544586cb2"
  license "LGPL-2.1-or-later"
  revision 1

  livecheck do
    url "http://www.fox-toolkit.org/news.html"
    regex(/FOX STABLE v?(\d+(?:\.\d+)+)/i)
  end

  bottle do
    cellar :any
    sha256 "c6697be294c9a0458580564d59f8db32791beb5e67a05a6246e0b969ffc068bc" => :catalina
    sha256 "26c9068061f545f1cd76c2b7b81775fc93b1e0d1fb80b53e374095438cebfd30" => :mojave
    sha256 "1de9a326c1e14cf8c4f29768478deb14071ace6120e4dca6557e6872fd88e7dd" => :high_sierra
    sha256 "14435c5f78a3d046ca5a0890edafc71cd74335c0857e8701fe26ae481977aeb2" => :sierra
    sha256 "a12e69c87858187ed33f11713e06c98a482308b3cb78884441ba279f4f51523e" => :el_capitan
  end

  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on :x11

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--enable-release",
                          "--prefix=#{prefix}",
                          "--with-x",
                          "--with-opengl"
    # Unset LDFLAGS, "-s" causes the linker to crash
    system "make", "install", "LDFLAGS="
    rm bin/"Adie.stx"
  end

  test do
    system bin/"reswrap", "-t", "-o", "text.txt", test_fixtures("test.jpg")
    assert_match "\\x00\\x85\\x80\\x0f\\xae\\x03\\xff\\xd9", File.read("text.txt")
  end
end
