class Folly < Formula
  desc "Collection of reusable C++ library artifacts developed at Facebook"
  homepage "https://github.com/facebook/folly"
  url "https://github.com/facebook/folly/archive/v2020.09.07.00.tar.gz"
  sha256 "9ca4130f8dbe0632d95557f40afd3cc3389e48de563d29b9f885ba2006dc84b1"
  license "Apache-2.0"
  head "https://github.com/facebook/folly.git"

  bottle do
    cellar :any
    sha256 "353fb220422b3c03a79fe4c844d351f2ce7e1564db7ffdb82c68d3911f8a0e1f" => :catalina
    sha256 "098318281ce8ae3b1565ce9d54bc9976d4a0dcb8f9ca2587833cd5750a24bff0" => :mojave
    sha256 "e9fb26bb103b8bbc5aab331093c4f206731928e19376b363d3c3d1cdfd7bee70" => :high_sierra
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "double-conversion"
  depends_on "fmt"
  depends_on "gflags"
  depends_on "glog"
  depends_on "libevent"
  depends_on "lz4"
  # https://github.com/facebook/folly/issues/966
  depends_on macos: :high_sierra
  depends_on "openssl@1.1"
  depends_on "snappy"
  depends_on "xz"
  depends_on "zstd"

  # https://github.com/facebook/folly/pull/1439
  patch do
    url "https://github.com/facebook/folly/commit/a8fef9cd797c97efc4884fc1bee9b4d990be9efc.diff?full_index=1"
    sha256 "be6eb1b6c669ba367d53cbbc7d66d5954b77961a716da9fbba44a1ef6a5e0472"
  end

  def install
    mkdir "_build" do
      args = std_cmake_args + %w[
        -DFOLLY_USE_JEMALLOC=OFF
      ]

      system "cmake", "..", *args, "-DBUILD_SHARED_LIBS=ON"
      system "make"
      system "make", "install"

      system "make", "clean"
      system "cmake", "..", *args, "-DBUILD_SHARED_LIBS=OFF"
      system "make"
      lib.install "libfolly.a", "folly/libfollybenchmark.a"
    end
  end

  test do
    (testpath/"test.cc").write <<~EOS
      #include <folly/FBVector.h>
      int main() {
        folly::fbvector<int> numbers({0, 1, 2, 3});
        numbers.reserve(10);
        for (int i = 4; i < 10; i++) {
          numbers.push_back(i * 2);
        }
        assert(numbers[6] == 12);
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++14", "test.cc", "-I#{include}", "-L#{lib}",
                    "-lfolly", "-o", "test"
    system "./test"
  end
end
