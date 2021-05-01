class Jpeg < Formula
  desc "Image manipulation library"
  homepage "https://www.ijg.org/"
  url "https://www.ijg.org/files/jpegsrc.v9d.tar.gz"
  mirror "https://dl.bintray.com/homebrew/mirror/jpeg-9d.tar.gz"
  mirror "https://fossies.org/linux/misc/jpegsrc.v9d.tar.gz"
  sha256 "6c434a3be59f8f62425b2e3c077e785c9ce30ee5874ea1c270e843f273ba71ee"
  license "IJG"

  livecheck do
    url "https://www.ijg.org/files/"
    regex(/href=.*?jpegsrc[._-]v?(\d+[a-z]?)\.t/i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "8f7b82a952fb3937889c7f22da1403e5338cd320495917eb26b0c5b2e614791c"
    sha256 cellar: :any, mojave:      "b931e7725c83275c56f962b51b83c10f31a01ac8d823c6722edaf16d893970b1"
    sha256 cellar: :any, high_sierra: "64286932634fbe1e0d07eacda334d2f4967b20bce0737424df56ec5eaa34ccca"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/djpeg", test_fixtures("test.jpg")
  end
end
