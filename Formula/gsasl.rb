class Gsasl < Formula
  desc "SASL library command-line interface"
  homepage "https://www.gnu.org/software/gsasl/"
  url "https://ftp.gnu.org/gnu/gsasl/gsasl-1.8.1.tar.gz"
  mirror "https://ftpmirror.gnu.org/gsasl/gsasl-1.8.1.tar.gz"
  sha256 "4dda162a511976bfef14ad1fecd7733719dfd9c361b5d09dc8414ea9d472d8d2"
  license "GPL-3.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any, catalina:    "964ad480f7fafd04051fe76a288b5f109766ae39e4329b00f1a268b5082b316e"
    sha256 cellar: :any, mojave:      "ac8236d918eea76cb15f196f5a571aab775ba1381e33d2c222a98114a2d391f6"
    sha256 cellar: :any, high_sierra: "d79efee531f43ebd0019d68f2066fb02f0ab9009ea3b78bddda231b6ddda5a7a"
  end

  depends_on "libgcrypt"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--with-gssapi-impl=mit",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match(/#{version}/, shell_output("#{bin}/gsasl"))
  end
end
