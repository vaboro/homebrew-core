class Pngcheck < Formula
  desc "Print info and check PNG, JNG, and MNG files"
  homepage "http://www.libpng.org/pub/png/apps/pngcheck.html"
  url "https://downloads.sourceforge.net/project/png-mng/pngcheck/2.3.0/pngcheck-2.3.0.tar.gz"
  sha256 "77f0a039ac64df55fbd06af6f872fdbad4f639d009bbb5cd5cbe4db25690f35f"
  revision 1

  livecheck do
    url :stable
    regex(%r{url=.*?/pngcheck[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "7fb0d821218aba52e2c261c4cdcc50438d71cbf232baba97ef13e861c3386a11"
    sha256 cellar: :any_skip_relocation, mojave:      "22033aa6f7b96ecb9d7eb038b7103e5faa782f4d36c142c3220f1e1ff1fc9e9e"
    sha256 cellar: :any_skip_relocation, high_sierra: "f4cdf56cdf51ab156bcc1009cce5cdd46d86de12811549136d50a1a18295b7c7"
    sha256 cellar: :any_skip_relocation, sierra:      "c98b0fd09e8b615f98d4ee9762485a8e9026c9cdb3dc576ef81ee0bbff6058d7"
    sha256 cellar: :any_skip_relocation, el_capitan:  "98e0a49125511f279c09c99fdb33ea5e2d44f489be4a8a6d70ce9faba48e8b92"
    sha256 cellar: :any_skip_relocation, yosemite:    "2f8901f0259f2ec24478268e5fa4cd8fe904a160592f118efdddf4ba20221dd6"
    sha256 cellar: :any_skip_relocation, mavericks:   "af2af2a3771b7730c0da6fe3c74f6044b3664498c0b9f5070be3cf4d7ec1274e"
  end

  def install
    system "make", "-f", "Makefile.unx", "ZINC=", "ZLIB=-lz"
    bin.install %w[pngcheck pngsplit png-fix-IDAT-windowsize]
  end

  test do
    system bin/"pngcheck", test_fixtures("test.png")
  end
end
