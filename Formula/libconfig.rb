class Libconfig < Formula
  desc "Configuration file processing library"
  homepage "https://hyperrealm.github.io/libconfig/"
  url "https://github.com/hyperrealm/libconfig/archive/v1.7.2.tar.gz"
  sha256 "f67ac44099916ae260a6c9e290a90809e7d782d96cdd462cac656ebc5b685726"
  license "LGPL-2.1"
  head "https://github.com/hyperrealm/libconfig.git"

  bottle do
    rebuild 1
    sha256 cellar: :any, catalina:    "5133affbfe2df2eccf05017748542e521e70a8db8763c8d8e39e00aec78fe3f8"
    sha256 cellar: :any, mojave:      "b1c005fc0d3a811efcef915d8e84d9cc2828d6c35c5649f71fab3c714b2ae1ea"
    sha256 cellar: :any, high_sierra: "5762b7106a3e4ecc470193cd8abcfd40de090c456d42b413e545402246d73f69"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libconfig.h>
      int main() {
        config_t cfg;
        config_init(&cfg);
        config_destroy(&cfg);
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}", "-L#{lib}", "-lconfig",
           testpath/"test.c", "-o", testpath/"test"
    system "./test"
  end
end
