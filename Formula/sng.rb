class Sng < Formula
  desc "Enable lossless editing of PNGs via a textual representation"
  homepage "https://sng.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/sng/sng-1.1.0.tar.gz"
  sha256 "119c55870c1d1bdc65f7de9dbc62929ccb0c301c2fb79f77df63f5d477f34619"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any, catalina:    "b37aa0aca0f3ab6b87ebaba92312fe008233a7f03cc015bcd6dd6e29e5291110"
    sha256 cellar: :any, mojave:      "f6968419ecf0848134eac6705e33c8fe0ea31696d0aa21a1a530af7767ff2865"
    sha256 cellar: :any, high_sierra: "b708d5c925acb4986d3cb6af71a2fc25d9ca53b35c3cc7700332513858057786"
    sha256 cellar: :any, sierra:      "30d9ad9aac3d8aaa67ae524d41bcdfbd92232f053bb0d5ccb3961b811c5b39a3"
  end

  depends_on "libpng"
  depends_on :x11

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    cp test_fixtures("test.png"), "test.png"
    system bin/"sng", "test.png"
    assert_include File.read("test.sng"), "width: 8; height: 8; bitdepth: 8;"
  end
end
