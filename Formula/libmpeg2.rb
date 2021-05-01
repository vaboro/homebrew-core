class Libmpeg2 < Formula
  desc "Library to decode mpeg-2 and mpeg-1 video streams"
  homepage "https://libmpeg2.sourceforge.io/"
  url "https://libmpeg2.sourceforge.io/files/libmpeg2-0.5.1.tar.gz"
  sha256 "dee22e893cb5fc2b2b6ebd60b88478ab8556cb3b93f9a0d7ce8f3b61851871d4"
  license "GPL-2.0"

  bottle do
    rebuild 1
    sha256 cellar: :any, catalina:    "248128226f4e6649a0aabec67dfb20f5b105a58b194c0e5830b5e13caf3b9421"
    sha256 cellar: :any, mojave:      "5b6d4bf134cee2877da39a05a5c918f870c9742fe5823d9ad8b61b013fc7a7f2"
    sha256 cellar: :any, high_sierra: "bdd9339459f1a039f480f3c31730265457bf6736ab625359482eb4e3796e455c"
    sha256 cellar: :any, sierra:      "4454cdb2561326d53d7680fb004a13a54674b9cabd619cc9a5fede2742c9da9e"
    sha256 cellar: :any, el_capitan:  "841e93dd99b97b96b475aedff29b58f5be5c4156869b1c0212e5d7ed8dd7f481"
    sha256 cellar: :any, yosemite:    "3d07c45554ff34036b9eae5a31dc5417c15109ba134d414035b1bf6f9dda7c79"
    sha256 cellar: :any, mavericks:   "f6a868beb10fbf84d3eb1af556478ecbfb238d28608a53b99e607c02910e5e49"
  end

  depends_on "sdl"

  def install
    # Otherwise compilation fails in clang with `duplicate symbol ___sputc`
    ENV.append_to_cflags "-std=gnu89"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
