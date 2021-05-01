class Gsl < Formula
  desc "Numerical library for C and C++"
  homepage "https://www.gnu.org/software/gsl/"
  url "https://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz"
  mirror "https://ftpmirror.gnu.org/gsl/gsl-2.6.tar.gz"
  sha256 "b782339fc7a38fe17689cb39966c4d821236c28018b6593ddb6fd59ee40786a8"
  license "GPL-3.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any, catalina:    "5972e8669b2560124278b43788a002e3ff22f024c761750a1a33b41d2002f292"
    sha256 cellar: :any, mojave:      "6c88a066c85f76c93a20f6e3256fb9022d6e7db828d184be5b42fd0b322ca7b8"
    sha256 cellar: :any, high_sierra: "8213b1a73d038e499223ccae6d04afe6eb2d9455e327d9558351cf47a0431b84"
    sha256 cellar: :any, sierra:      "8515f26e5a06a99097e87dc9b88ee79787b95448ab67f09b449aee4b0d67bdba"
  end

  def install
    ENV.deparallelize
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make" # A GNU tool which doesn't support just make install! Shameful!
    system "make", "install"
  end

  test do
    system bin/"gsl-randist", "0", "20", "cauchy", "30"
  end
end
