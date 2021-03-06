class Bbe < Formula
  desc "Sed-like editor for binary files"
  homepage "https://sourceforge.net/projects/bbe-/"
  url "https://downloads.sourceforge.net/project/bbe-/bbe/0.2.2/bbe-0.2.2.tar.gz"
  sha256 "baaeaf5775a6d9bceb594ea100c8f45a677a0a7d07529fa573ba0842226edddb"
  license "GPL-2.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "16ec8602703755894016b9ecd47ca9875a97c66ba259cdb8d7fa8902a17dd8d3"
    sha256 cellar: :any_skip_relocation, mojave:      "f1c5c6884c5e1740d5f649ac1caa4bb42df1a5ab6bba13970497f7c94454d346"
    sha256 cellar: :any_skip_relocation, high_sierra: "95cef154264d814bcdb543da64b8947ed8219411c3da20d854f30bd0aeb1332a"
    sha256 cellar: :any_skip_relocation, sierra:      "4f533ae33e0c46a01bc11f1c8b99ef6baba62a376ddee1000de1fa199f18545a"
    sha256 cellar: :any_skip_relocation, el_capitan:  "d9c63d7b9657e6f1c0e53048564f275283177e3513e202a7a9cfc69571bb5008"
    sha256 cellar: :any_skip_relocation, yosemite:    "ae0aa826fcd9f11e93428e9eaeedb14a56c193c861f09123999a8ba0f3d7f9cd"
    sha256 cellar: :any_skip_relocation, mavericks:   "6b7c4c2c05ab444212260dfef6b2ab2ed7e9230844007651217259d1f957ed02"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/bbe", "--version"
  end
end
