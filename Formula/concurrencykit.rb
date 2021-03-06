class Concurrencykit < Formula
  desc "Aid design and implementation of concurrent systems"
  homepage "http://concurrencykit.org/"
  url "https://github.com/concurrencykit/ck/archive/0.7.0.tar.gz"
  sha256 "e730cb448fb0ecf9d19bf4c7efe9efc3c04dd9127311d87d8f91484742b0da24"
  license "BSD-2-Clause"
  head "https://github.com/concurrencykit/ck.git"

  bottle do
    sha256 cellar: :any, catalina:    "12788eda54c82375102f2f33e28f533151b4d3f6fa9042ea7c7aa03fb25c3e3a"
    sha256 cellar: :any, mojave:      "357062d84adf8f0c8d1a92a7fda6fb9278b6264edf061935d595342e0c334aed"
    sha256 cellar: :any, high_sierra: "c8def7655e173d45ff8ec94bc78750507235fa9eb8b79be639bf250698d59761"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <ck_spinlock.h>
      int main()
      {
        ck_spinlock_t spinlock;
        ck_spinlock_init(&spinlock);
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}", "-L#{lib}", "-lck",
           testpath/"test.c", "-o", testpath/"test"
    system "./test"
  end
end
