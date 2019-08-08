class Pngxx < Formula
  desc "C++ wrapper for libpng library"
  homepage "https://www.nongnu.org/pngpp/"
  url "https://download.savannah.gnu.org/releases/pngpp/png++-0.2.9.tar.gz"
  sha256 "abbc6a0565122b6c402d61743451830b4faee6ece454601c5711e1c1b4238791"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "5226334e7e4140d95289b8a56d6c5f9c1eb92f499889fc36f79d14b41528d466" => :mojave
    sha256 "5226334e7e4140d95289b8a56d6c5f9c1eb92f499889fc36f79d14b41528d466" => :high_sierra
    sha256 "8e47f0497587c61a45e78c0e75345304bc860ba56e1a272f87b2e1017dc87eef" => :sierra
  end

  depends_on "libpng"

  # Issues with GNU strerror_r being used because Darwin libc does not define _POSIX_C_SOURCE
  patch :DATA

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <png++/png.hpp>
      int main() {
        png::image<png::rgb_pixel> image(200, 300);
        if (image.get_width() != 200) return 1;
        if (image.get_height() != 300) return 2;
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-o", "test"
    system "./test"
  end
end

__END__
diff -Naur png++-0.2.9-orig/error.hpp png++-0.2.9/error.hpp
--- png++-0.2.9-orig/error.hpp	2015-10-25 15:42:45.000000000 -0400
+++ png++-0.2.9/error.hpp	2019-07-18 12:24:10.000000000 -0400
@@ -100,7 +100,7 @@
             strerror_s(buf, ERRBUF_SIZE, errnum);
             return std::string(buf);
 #else
-#if (_POSIX_C_SOURCE >= 200112L || _XOPEN_SOURCE >= 600) && !_GNU_SOURCE
+#if ((_POSIX_C_SOURCE >= 200112L || _XOPEN_SOURCE >= 600) && !_GNU_SOURCE) || (!__GLIBC__)
             strerror_r(errnum, buf, ERRBUF_SIZE);
             return std::string(buf);
 #else
