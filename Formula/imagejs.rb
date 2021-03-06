class Imagejs < Formula
  desc "Tool to hide JavaScript inside valid image files"
  homepage "https://jklmnn.de/imagejs/"
  url "https://github.com/jklmnn/imagejs/archive/0.7.2.tar.gz"
  sha256 "ba75c7ea549c4afbcb2a516565ba0b762b5fc38a03a48e5b94bec78bac7dab07"
  license "GPL-3.0"
  head "https://github.com/jklmnn/imagejs.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "2e758f8cb396b7dde6e80ff4115798122739418868b36d05a19231ff103c3028"
    sha256 cellar: :any_skip_relocation, mojave:      "4129ad096d0f6c28d40dd7e99749eaaa519b08db6bf708bea9b97c56cb45f6db"
    sha256 cellar: :any_skip_relocation, high_sierra: "5abd3ddcc69f1d44205b5f66b01850c5469cc982643711f3a37f13f7bd0d649b"
    sha256 cellar: :any_skip_relocation, sierra:      "7e56845664f1d00cb460effbc723aa6a4df38e34e3a654f9c9e9485037f086ff"
    sha256 cellar: :any_skip_relocation, el_capitan:  "9f98ec026ce971a312606d06acbdeabcc38c842e6f4fdbd1d7631a76e3f3307d"
    sha256 cellar: :any_skip_relocation, yosemite:    "47dc7fa5f0b5706b0c952522b897652758ccedcb7169bcd25e551204bb19da27"
  end

  def install
    system "make"
    bin.install "imagejs"
  end

  test do
    (testpath/"test.js").write "alert('Hello World!')"
    system "#{bin}/imagejs", "bmp", "test.js", "-l"
  end
end
