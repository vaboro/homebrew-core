class Parallelstl < Formula
  desc "C++ standard library algorithms with support for execution policies"
  homepage "https://github.com/intel/parallelstl"
  url "https://github.com/intel/parallelstl/archive/20200330.tar.gz"
  sha256 "47d78920a7220828cde9b0c0cf808c70774b2db05ab4dd689b8bbd350afb9e6e"
  # Apache License Version 2.0 with LLVM exceptions
  license "Apache-2.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "5b3837f32d57d6d5398da1127eb4bba489a85821ae32e125fc486edb3abbca11" => :catalina
    sha256 "5b3837f32d57d6d5398da1127eb4bba489a85821ae32e125fc486edb3abbca11" => :mojave
    sha256 "5b3837f32d57d6d5398da1127eb4bba489a85821ae32e125fc486edb3abbca11" => :high_sierra
  end

  depends_on "cmake" => :build
  depends_on "tbb"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
    prefix.install "stdlib"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <pstl/execution>
      #include <pstl/algorithm>
      #include <array>
      #include <assert.h>

      int main() {
        std::array<int, 10> arr {{5,2,3,1,4,9,7,0,8,6}};
        std::sort(std::execution::par_unseq, arr.begin(), arr.end());
        for(int i=0; i<10; i++)
          assert(i==arr.at(i));
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "-L#{Formula["tbb"].opt_lib}", "-ltbb",
                    "-I#{prefix}/stdlib", "-I#{include}", "test.cpp", "-o", "test"
    system "./test"
  end
end
