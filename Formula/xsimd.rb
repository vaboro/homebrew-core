class Xsimd < Formula
  desc "Modern, portable C++ wrappers for SIMD intrinsics"
  homepage "https://xsimd.readthedocs.io/en/latest/"
  url "https://github.com/xtensor-stack/xsimd/archive/7.4.8.tar.gz"
  sha256 "318676faae48d2082440df9f161a95303a3f29c3f0b03ff32ca24063b12f5699"
  license "BSD-3-Clause"

  bottle do
    cellar :any_skip_relocation
    sha256 "a8c6a9f46585989372faf4b18029b2f69a1660e743ba8ee126a51686656dfc56" => :catalina
    sha256 "a8c6a9f46585989372faf4b18029b2f69a1660e743ba8ee126a51686656dfc56" => :mojave
    sha256 "a8c6a9f46585989372faf4b18029b2f69a1660e743ba8ee126a51686656dfc56" => :high_sierra
  end

  depends_on "cmake" => :build

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTS=OFF"

    system "cmake", ".", *args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <vector>
      #include <type_traits>

      #include "xsimd/memory/xsimd_alignment.hpp"

      using namespace xsimd;

      struct mock_container {};

      int main(void) {
        using u_vector_type = std::vector<double>;
        using a_vector_type = std::vector<double, aligned_allocator<double, XSIMD_DEFAULT_ALIGNMENT>>;

        using u_vector_align = container_alignment_t<u_vector_type>;
        using a_vector_align = container_alignment_t<a_vector_type>;
        using mock_align = container_alignment_t<mock_container>;

        if(!std::is_same<u_vector_align, unaligned_mode>::value) abort();
        if(!std::is_same<a_vector_align, aligned_mode>::value) abort();
        if(!std::is_same<mock_align, unaligned_mode>::value) abort();
        return 0;
      }
    EOS
    system ENV.cxx, "test.c", "-std=c++14", "-I#{include}", "-o", "test"
    system "./test"
  end
end
