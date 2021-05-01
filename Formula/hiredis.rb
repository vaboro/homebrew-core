class Hiredis < Formula
  desc "Minimalistic client for Redis"
  homepage "https://github.com/redis/hiredis"
  url "https://github.com/redis/hiredis/archive/v0.14.1.tar.gz"
  sha256 "2663b2aed9fd430507e30fc5e63274ee40cdd1a296026e22eafd7d99b01c8913"
  license "BSD-3-Clause"
  revision 1
  head "https://github.com/redis/hiredis.git"

  bottle do
    sha256 cellar: :any, catalina:    "4b089bee868b4fe533bea75917f21a42a11a9e04d5b396ec5a94d5623372ec0b"
    sha256 cellar: :any, mojave:      "8974f8bacac7ce018f6f238915c6c5f07751c5183283337634a1715624d344b8"
    sha256 cellar: :any, high_sierra: "5ed94f51e6dbe91f7d195be5a5d085c7929f82bafeecba8645dd2315a94dad8d"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
    pkgshare.install "examples"
  end

  test do
    # running `./test` requires a database to connect to, so just make
    # sure it compiles
    system ENV.cc, "-I#{include}/hiredis", "-L#{lib}", "-lhiredis",
           pkgshare/"examples/example.c", "-o", testpath/"test"
    assert_predicate testpath/"test", :exist?
  end
end
