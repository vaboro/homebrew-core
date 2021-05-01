class Raylib < Formula
  desc "Simple and easy-to-use library to learn videogames programming"
  homepage "https://www.raylib.com/"
  url "https://github.com/raysan5/raylib/archive/3.0.0.tar.gz"
  sha256 "164d1cc1710bb8e711a495e84cc585681b30098948d67d482e11dc37d2054eab"
  license "Zlib"
  head "https://github.com/raysan5/raylib.git", branch: "master"

  bottle do
    sha256 cellar: :any, catalina:    "e4a993eb3b14cb555d76197d3515c2606782f0d36e37f511512acd3198a1f7a7"
    sha256 cellar: :any, mojave:      "889ab34922a972bcf77b40c2b931f02e136531f4716efe1d9ba8dec56ea99a58"
    sha256 cellar: :any, high_sierra: "85002fb7e4a095c32af67f399b0974a3346595bfceb99589ddb42753aab0e13d"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", "-DSTATIC_RAYLIB=ON",
                         "-DSHARED_RAYLIB=ON",
                         "-DMACOS_FATLIB=OFF",
                         "-DBUILD_EXAMPLES=OFF",
                         "-DBUILD_GAMES=OFF",
                         *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdlib.h>
      #include <raylib.h>
      int main(void)
      {
          int num = GetRandomValue(42, 1337);
          return 42 <= num && num <= 1337 ? EXIT_SUCCESS : EXIT_FAILURE;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lraylib", "-o", "test"
    system "./test"
  end
end
