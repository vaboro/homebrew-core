class Vde < Formula
  desc "Ethernet compliant virtual network"
  homepage "https://vde.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/vde/vde2/2.3.2/vde2-2.3.2.tar.gz"
  sha256 "22df546a63dac88320d35d61b7833bbbcbef13529ad009c7ce3c5cb32250af93"
  license "GPL-2.0"

  livecheck do
    url :stable
    regex(%r{url=.*?/vde\d*?[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 catalina:    "141613f09143ec306b51817ff4b205462a95f5272099b3500486cc5b6926ab27"
    sha256 mojave:      "a0cf184ec7804a4984607e3e7d311395514390235241d7844e31aafeb40d48cb"
    sha256 high_sierra: "49241bcf4445833cedd86c3d8901e563032874f9976a21a106073760a5095e39"
    sha256 sierra:      "3e9215e631197e75b179f9f33bc27483ead1d2ce8b3875b7846cc2568cfe67c2"
    sha256 el_capitan:  "97989b0577f7a1fbd13c916aff1e61391cf3d7b886c4ef965f0b765e034c8bbc"
    sha256 yosemite:    "5ca4100e3dae3df4704e2fdf9ae07a1fb0637d2cb2e916e7db931a4cb84a0c55"
    sha256 mavericks:   "ab336b6d84a03dd981d70ab8b377ec3a61dcb9abfffd233c84a0e74c8fadc8b8"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    # 2.3.1 built in parallel but 2.3.2 does not. See:
    # https://sourceforge.net/p/vde/bugs/54/
    ENV.deparallelize
    system "make", "install"
  end
end
