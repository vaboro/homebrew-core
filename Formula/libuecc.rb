class Libuecc < Formula
  desc "Very small Elliptic Curve Cryptography library"
  homepage "https://git.universe-factory.net/libuecc/"
  url "https://git.universe-factory.net/libuecc/snapshot/libuecc-7.tar"
  sha256 "0120aee869f56289204255ba81535369816655264dd018c63969bf35b71fd707"
  head "https://git.universe-factory.net/libuecc"

  livecheck do
    url :head
    regex(/href=.*?libuecc[._-]v?(\d+(?:\.\d+)*)\.t/i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "89acc7a04f910882b89d9e032a45e8c27dc98257d6d4e6b28f6c6a26c8c369ae"
    sha256 cellar: :any, mojave:      "d4d0c41262688ddca9ee2f2e6b80c33670c5a8db7266cd0c0592cd50b0d18be1"
    sha256 cellar: :any, high_sierra: "95646c23acf19c1f07032c6f311f446e7a32b1a9d0c1dd385ec3c41811036572"
    sha256 cellar: :any, sierra:      "4722877fdc4538c814a10e6d0dc2f1a4d2a3571ce4ca1c8b37279c88cd83883f"
    sha256 cellar: :any, el_capitan:  "d9e52027a6535fb74e44026d23ef13a2417a1f22402173dc90d136071ea5290d"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdlib.h>
      #include <libuecc/ecc.h>

      int main(void)
      {
          ecc_int256_t secret;
          ecc_25519_gf_sanitize_secret(&secret, &secret);

          return EXIT_SUCCESS;
      }
    EOS
    system ENV.cc, "-I#{include}/libuecc-#{version}", "-L#{lib}", "-o", "test", "test.c", "-luecc"
    system "./test"
  end
end
