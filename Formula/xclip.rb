class Xclip < Formula
  desc "Command-line utility that is designed to run on any system with an X11"
  homepage "https://github.com/astrand/xclip"
  url "https://github.com/astrand/xclip/archive/0.13.tar.gz"
  sha256 "ca5b8804e3c910a66423a882d79bf3c9450b875ac8528791fb60ec9de667f758"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "c3b3e66635b85111a16a3a9ab1fedbe9872d2848d2dbba421fac8b8bf081a759"
    sha256 cellar: :any_skip_relocation, mojave:      "7bb1acc9b968eba155874f614dbfea960e883121321b063faf81f106f2521014"
    sha256 cellar: :any_skip_relocation, high_sierra: "0963015158b7d4ae2981503edc18427737a0586b7155da5cd2ddaa93fb3b92bd"
    sha256 cellar: :any_skip_relocation, sierra:      "bb26c2bb6d7ce8f15ab50144f38d11ddde113bb400326ccea990ca9a5d0a9c69"
    sha256 cellar: :any_skip_relocation, el_capitan:  "9e17790e9a94ae1e29317f013a65f2d639ae9063db48ed7fa0aed7449f221abb"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on :x11

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/xclip", "-version"
  end
end
