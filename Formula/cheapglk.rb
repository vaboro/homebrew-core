class Cheapglk < Formula
  desc "Extremely minimal Glk library"
  homepage "https://www.eblong.com/zarf/glk/"
  url "https://www.eblong.com/zarf/glk/cheapglk-106.tar.gz"
  version "1.0.6"
  sha256 "2753562a173b4d03ae2671df2d3c32ab7682efd08b876e7e7624ebdc8bf1510b"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "91d3c4e89b0750585d52206bf25054eb2db72af798e0d4e1c33021177b92ae13"
    sha256 cellar: :any_skip_relocation, mojave:      "d57b00a86e3d1c76f43d8f034c1dfe77d23da3d34637449040fdedd21f6a4a63"
    sha256 cellar: :any_skip_relocation, high_sierra: "47c6f59d902a306b30c6255f65fd7626e32d5c39800fd80daeada852e95994f2"
    sha256 cellar: :any_skip_relocation, sierra:      "d76d29db8ea0201fcef949e02cbddb1c06311dece796a263192ffef487a3aa2c"
    sha256 cellar: :any_skip_relocation, el_capitan:  "497a5399738c026d318d3213b764f20fb80ccea94181919fad2e80eb75086055"
    sha256 cellar: :any_skip_relocation, yosemite:    "8351c9dec39fd8e860e50a8e693e1c648def81c3ddcbdd3a856f656d585b0082"
  end

  keg_only "it conflicts with other Glk libraries"

  def install
    system "make"

    lib.install "libcheapglk.a"
    include.install "glk.h", "glkstart.h", "gi_blorb.h", "gi_dispa.h", "Make.cheapglk"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include "glk.h"
      #include "glkstart.h"

      glkunix_argumentlist_t glkunix_arguments[] = {
          { NULL, glkunix_arg_End, NULL }
      };

      int glkunix_startup_code(glkunix_startup_t *data)
      {
          return TRUE;
      }

      void glk_main()
      {
          glk_exit();
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lcheapglk", "-o", "test"
    assert_match version.to_s, pipe_output("./test", "echo test", 0)
  end
end
