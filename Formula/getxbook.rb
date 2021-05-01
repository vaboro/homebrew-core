class Getxbook < Formula
  desc "Tools to download ebooks from various sources"
  homepage "https://njw.name/getxbook"
  url "https://njw.name/getxbook/getxbook-1.2.tar.xz"
  sha256 "7a4b1636ecb6dace814b818d9ff6a68167799b81ac6fc4dca1485efd48cf1c46"
  revision 1

  bottle do
    sha256 cellar: :any, catalina:    "a99745b1db4509b84e84c0306bdf4439086670e608e7ff7e4d89e5318547391b"
    sha256 cellar: :any, mojave:      "68f7f76c607807315d1e8305830eaa94d04e1c87f1ea1382fb00bd7ec74f2886"
    sha256 cellar: :any, high_sierra: "dce13d6e7d9f5f0eb79064858dca9dc3d62b274ba1f07b2ceaca3bf06e4effed"
    sha256 cellar: :any, sierra:      "d4b7500ecfbcf0b0d4ff905b01589a546aa53da5c1c465878305c8b6ee2c363c"
  end

  depends_on "openssl@1.1"

  def install
    system "make", "CC=#{ENV.cc}", "PREFIX=#{prefix}"
    bin.install "getgbook", "getabook", "getbnbook"
  end

  test do
    assert_match "getgbook #{version}", shell_output("#{bin}/getgbook", 1)
  end
end
