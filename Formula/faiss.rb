class Faiss < Formula
  desc "Efficient similarity search and clustering of dense vectors"
  homepage "https://github.com/facebookresearch/faiss"
  url "https://github.com/facebookresearch/faiss/archive/v1.6.3.tar.gz"
  sha256 "e1a41c159f0b896975fbb133e0240a233af5c9286c09a28fde6aefff5336e542"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "457e410d8e5b009bf12cb1b5881485f03461646ef18ff8afb69dbbc7113519b4"
    sha256 cellar: :any, mojave:      "b3eb242ff373017f8d7ba621fde32d745a6d7d6c5c7ca5de888b7f8087e94776"
    sha256 cellar: :any, high_sierra: "03b95260a4fdd6cceaa69bb4e7168939aadf2b608f998079f7511aec6171f2d1"
  end

  depends_on "libomp"

  on_linux do
    depends_on "openblas"
  end

  def install
    system "./configure", "--without-cuda",
                          "--prefix=#{prefix}",
                          "ac_cv_prog_cxx_openmp=-Xpreprocessor -fopenmp",
                          "LIBS=-lomp"
    system "make"
    system "make", "install"
    pkgshare.install "demos"
  end

  test do
    cp pkgshare/"demos/demo_imi_flat.cpp", testpath
    system ENV.cxx, "-std=c++11", "-L#{lib}", "-lfaiss", "demo_imi_flat.cpp", "-o", "test"
    assert_match "Query results", shell_output("./test")
  end
end
