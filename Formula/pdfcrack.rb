class Pdfcrack < Formula
  desc "PDF files password cracker"
  homepage "https://pdfcrack.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/pdfcrack/pdfcrack/pdfcrack-0.19/pdfcrack-0.19.tar.gz"
  sha256 "3115206998b7cddf13971dd4b50946c077fc96e220aca1c0734798d907a2c0ed"
  license "GPL-2.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "2c26ba3ca3a1edd9cc9e6570cb5d1c7838a152a3d8281a2a16c6be5276d47b23"
    sha256 cellar: :any_skip_relocation, mojave:      "12310e0c5841db19ecf51f527cde0aaba1663a04aa78c760a5d6e02218dc4e3c"
    sha256 cellar: :any_skip_relocation, high_sierra: "9923fadda54414a1d0cd5e86b0796aec8bbaf7c80e96e7518b5ae136d50d5674"
  end

  def install
    system "make", "all"
    bin.install "pdfcrack"
  end

  test do
    system "#{bin}/pdfcrack", "--version"
  end
end
