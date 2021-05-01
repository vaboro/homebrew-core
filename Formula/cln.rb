class Cln < Formula
  desc "Class Library for Numbers"
  homepage "https://www.ginac.de/CLN/"
  url "https://www.ginac.de/CLN/cln-1.3.6.tar.bz2"
  sha256 "f492530e8879bda529009b6033e1923c8f4aae843149fc28c667c20b094d984a"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any, catalina:    "bbc7716e6028fc3dc95dc22bf20033d13119b6ffe62dbd4c2609ecce85459a92"
    sha256 cellar: :any, mojave:      "1e62717cf6b0562643947c904c547e737bc9209cb349c388c6b7f9edcd915001"
    sha256 cellar: :any, high_sierra: "0f14327e937f0a665dc66c5b62dc5d11094d812831221d8b86f8e5ba966e9540"
  end

  depends_on "gmp"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    assert_match "3.14159", shell_output("#{bin}/pi 6")
  end
end
