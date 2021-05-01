class Pgdbf < Formula
  desc "Converter of XBase/FoxPro tables to PostgreSQL"
  homepage "https://github.com/kstrauser/pgdbf"
  url "https://downloads.sourceforge.net/project/pgdbf/pgdbf/0.6.2/pgdbf-0.6.2.tar.xz"
  sha256 "e46f75e9ac5f500bd12c4542b215ea09f4ebee638d41dcfd642be8e9769aa324"
  license "GPL-3.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "ae8050a5d6a6f91f529a0985a5626981d22573094791274c7bc1759b2770c4c7"
    sha256 cellar: :any_skip_relocation, mojave:      "4a76ca05c6b73ea6fcf57d6699cbaf3e249c5e3b20990e51ab33d11bfbdd7d50"
    sha256 cellar: :any_skip_relocation, high_sierra: "caf544eee09339bb34ab68a35880bc863bb13aa7943de98ef25680cb0182f901"
    sha256 cellar: :any_skip_relocation, sierra:      "7d0eabf3051e9cf450d985987f89cf0d70476b37202b3b5bdc84ec48e8cb670d"
    sha256 cellar: :any_skip_relocation, el_capitan:  "72ad6b801d25db2008d0ab4badd2bb280f55eb6f6956925ee5620d62d8f06bbb"
    sha256 cellar: :any_skip_relocation, yosemite:    "4042a284cac8abe88e7d1c9e6c003e00a9b8247905739829cd768a824df7993b"
    sha256 cellar: :any_skip_relocation, mavericks:   "c53298c57bb2d31d82ddce41ed65057d7781de2118857f5f795aaaefe3c00110"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
