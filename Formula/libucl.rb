class Libucl < Formula
  desc "Universal configuration library parser"
  homepage "https://github.com/vstakhov/libucl"
  url "https://github.com/vstakhov/libucl/archive/0.8.1.tar.gz"
  sha256 "a6397e179672f0e8171a0f9a2cfc37e01432b357fd748b13f4394436689d24ef"
  license "BSD-2-Clause"

  bottle do
    rebuild 3
    sha256 cellar: :any, catalina:    "8ff53b6da5423f7b6e11b6173b4b720d3563b1a24243ea4f977cf269d67aeb4c"
    sha256 cellar: :any, mojave:      "1ffddb657d95f504ba3b7331f5dbbd995c5d237cda3f736e99182a16a8e8181d"
    sha256 cellar: :any, high_sierra: "dd5dbb4eb7e3d37816acc4f3bc2842c8e91caeb4a6f058eed75cab9d72192315"
    sha256 cellar: :any, sierra:      "5c477e0feb163dc955e89eabf97cae445fefc9c920fe46073c85af348535d7cd"
    sha256 cellar: :any, el_capitan:  "93e7d66507c386c9fe720b5f4c77d3b719574b7c311319cddc09bcbda659bce7"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  def install
    system "./autogen.sh"

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-utils
      --prefix=#{prefix}
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <ucl++.h>
      #include <string>
      #include <cassert>

      int main(int argc, char **argv) {
        const std::string cfg = "foo = bar; section { flag = true; }";
        std::string err;
        auto obj = ucl::Ucl::parse(cfg, err);
        assert(obj);
        assert(obj[std::string("foo")].string_value() == "bar");
        assert(obj[std::string("section")][std::string("flag")].bool_value());
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cpp", "-L#{lib}", "-lucl", "-o", "test"
    system "./test"
  end
end
