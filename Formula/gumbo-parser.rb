class GumboParser < Formula
  desc "C99 library for parsing HTML5"
  homepage "https://github.com/google/gumbo-parser"
  url "https://github.com/google/gumbo-parser/archive/v0.10.1.tar.gz"
  sha256 "28463053d44a5dfbc4b77bcf49c8cee119338ffa636cc17fc3378421d714efad"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any, catalina:    "c922c8ec4425cef96e3283bace0ffda97cdd5f4946ca151da69045c6ce80ef06"
    sha256 cellar: :any, mojave:      "aa6ed085625f40a65ecead082bd711dcb16af9aed6f74372edb7dc19e44fba5c"
    sha256 cellar: :any, high_sierra: "ed0957fe59981b55c1baf149022a5b0f3a163f1a6eb6e03e402da2f018406b9f"
    sha256 cellar: :any, sierra:      "7c911b3f74827405abdf92cb6f6265cf7185043af4101d851eb68c5e69ea71e6"
    sha256 cellar: :any, el_capitan:  "56f5446eb431b628655748659a8a7479466e00addf7d90070464364a3f3cafa9"
    sha256 cellar: :any, yosemite:    "02169cdaafcf9343bacf98e0e34b1f7383eb0b1b89385965d81796e110f8c38f"
    sha256 cellar: :any, mavericks:   "efc9658f05e6543d7faed663ef7106c5720e72a86672d7ef000372babade1e43"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "gumbo.h"

      int main() {
        GumboOutput* output = gumbo_parse("<h1>Hello, World!</h1>");
        gumbo_destroy_output(&kGumboDefaultOptions, output);
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lgumbo", "-o", "test"
    system "./test"
  end
end
