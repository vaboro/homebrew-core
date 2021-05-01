class Libilbc < Formula
  desc "Packaged version of iLBC codec from the WebRTC project"
  homepage "https://github.com/TimothyGu/libilbc"
  url "https://github.com/TimothyGu/libilbc/releases/download/v2.0.2/libilbc-2.0.2.tar.gz"
  sha256 "84d5c99087a35bda3463bcb993245b4f8c28c04fe037215a5ec56570f68ce519"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any, catalina:    "3a8caa126466fcf7cde71363a4423e709b249f0a7318a22e5bd545d3d5382ea3"
    sha256 cellar: :any, mojave:      "cbb71770ab1bc1647e719d9b084d710c8c5c4e37a0b1a70e53650b3fb24cda62"
    sha256 cellar: :any, high_sierra: "63df659558f7961f6e04c347dad5ef6508578e86e0c13b15d39fb267dcc440db"
    sha256 cellar: :any, sierra:      "421757bd970d1ba1d0c1fe2eff208cc0b44f8a75bbf9a09344ba504ad377750f"
    sha256 cellar: :any, el_capitan:  "fff34390e949e037bb4b16937b62ab4993f55d2fb805656116ceab6a7c9b6e83"
    sha256 cellar: :any, yosemite:    "7f16b3e0f254f35be8b6275339dc813a6443f65d1c27e1748e08835a49733f6f"
    sha256 cellar: :any, mavericks:   "7aa8495e4050ea38152ec218452d6fac97387ad385a6d63806238e838664471b"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <ilbc.h>
      #include <stdio.h>

      int main() {
        char version[255];

        WebRtcIlbcfix_version(version);
        printf("%s", version);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lilbc", "-o", "test"
    system "./test"
  end
end
