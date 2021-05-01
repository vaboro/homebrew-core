class Utf8proc < Formula
  desc "Clean C library for processing UTF-8 Unicode data"
  homepage "https://juliastrings.github.io/utf8proc/"
  url "https://github.com/JuliaStrings/utf8proc/archive/v2.5.0.tar.gz"
  sha256 "d4e8dfc898cfd062493cb7f42d95d70ccdd3a4cd4d90bec0c71b47cca688f1be"
  license all_of: ["MIT", "Unicode-DFS-2015"]

  bottle do
    sha256 cellar: :any, catalina:    "f215acf62769b7036110950b65285742b6550c631b0606befa12b98f32c53130"
    sha256 cellar: :any, mojave:      "1bd0f29df929fff62b33895ca76162b9d376aefea09115c84a3841793fa7a9a3"
    sha256 cellar: :any, high_sierra: "12b05c0477b8f6fd029f3723d74712f267960fb9d212a21520f9a557d3cd516c"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <string.h>
      #include <utf8proc.h>

      int main() {
        const char *version = utf8proc_version();
        return strnlen(version, sizeof("1.3.1-dev")) > 0 ? 0 : -1;
      }
    EOS

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lutf8proc", "-o", "test"
    system "./test"
  end
end
