class WCalc < Formula
  desc "Very capable calculator"
  homepage "https://w-calc.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/w-calc/Wcalc/2.5/wcalc-2.5.tar.bz2"
  sha256 "0e2c17c20f935328dcdc6cb4c06250a6732f9ee78adf7a55c01133960d6d28ee"
  revision 1

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any, catalina:    "dfde02c6213c6eeeecaeae55d7ecaa7620ab5c86f346f9242c82899802901b8b"
    sha256 cellar: :any, mojave:      "955d80417eea9747844f52b13d91005f207a869e04f49a4a8f1e1db7e8acfa74"
    sha256 cellar: :any, high_sierra: "be1800e5bb6cbf1e8087a0310ba648ec80f5013081d8db1145011c2c826b3c0c"
    sha256 cellar: :any, sierra:      "f934e56de20012d05890525117377efd717ee9d1f09feada9cb41068791065ba"
    sha256 cellar: :any, el_capitan:  "f9b1cd0799ffed7d47cb467d6a9ba606208ec93f263180eb094713ef0bec2bfc"
  end

  depends_on "gmp"
  depends_on "mpfr"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "4", shell_output("#{bin}/wcalc 2+2")
  end
end
