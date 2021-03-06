class Cmatrix < Formula
  desc "Console Matrix"
  homepage "https://github.com/abishekvashok/cmatrix/"
  url "https://github.com/abishekvashok/cmatrix/archive/v2.0.tar.gz"
  sha256 "ad93ba39acd383696ab6a9ebbed1259ecf2d3cf9f49d6b97038c66f80749e99a"
  license "GPL-3.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "fcc9c366c560e89ee2b4f61d1bdece14379a2c598719fd2eef784564bf9ed677"
    sha256 cellar: :any_skip_relocation, mojave:      "1b3d3155c87c8f2b788fe18c3e72f04af4e79c609030e3447c3e17f9d3870c7b"
    sha256 cellar: :any_skip_relocation, high_sierra: "2c3b0ce73a2f89ece3783885e44aba5f584268768283e650d8b6552bc00f058d"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  uses_from_macos "ncurses"

  def install
    system "autoreconf", "-i"
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/cmatrix", "-V"
  end
end
