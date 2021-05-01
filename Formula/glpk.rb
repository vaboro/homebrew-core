class Glpk < Formula
  desc "Library for Linear and Mixed-Integer Programming"
  homepage "https://www.gnu.org/software/glpk/"
  url "https://ftp.gnu.org/gnu/glpk/glpk-4.65.tar.gz"
  mirror "https://ftpmirror.gnu.org/glpk/glpk-4.65.tar.gz"
  sha256 "4281e29b628864dfe48d393a7bedd781e5b475387c20d8b0158f329994721a10"
  license "GPL-3.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any, catalina:    "55bd72ce9a73c652c34616d09d8ca7d05028c089835c9f0e91db0868e626fc05"
    sha256 cellar: :any, mojave:      "563546e59d89de41270630d03276672f927037c28d6c64531791524cb7e611e4"
    sha256 cellar: :any, high_sierra: "5c0b4a34749c6e60bf9aa39f175ca907bab774f89a1b8a1697f3f5d02d493f2a"
    sha256 cellar: :any, sierra:      "3cbe0b40e3852414560a4929da0ee050fc8fa424b56b3ea756f853ce274b9a3a"
    sha256 cellar: :any, el_capitan:  "90ba265eb683981e612faae96318b662558e828a99a89200a29df93006d34084"
  end

  depends_on "gmp"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--with-gmp"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include "glpk.h"

      int main(int argc, const char *argv[])
      {
        printf("%s", glp_version());
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-I#{include}", "-lglpk", "-o", "test"
    assert_match version.to_s, shell_output("./test")
  end
end
