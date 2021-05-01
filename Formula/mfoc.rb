class Mfoc < Formula
  desc "Implementation of 'offline nested' attack by Nethemba"
  homepage "https://github.com/nfc-tools/mfoc"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mfoc/mfoc-0.10.7.tar.bz2"
  sha256 "93d8ac4cb0aa6ed94855ca9732a2ffd898a9095c087f12f9402205443c2eb98c"
  license "GPL-2.0"
  revision 1

  bottle do
    sha256 cellar: :any, catalina:    "14c431c29b0b0e746d1533606ab13097a84b853c13d4399672027cf9256dad32"
    sha256 cellar: :any, mojave:      "ff9f6c43ef70b8ae6fee40c43cf5f0acd6f72acd5507874e75d82703aeed5fc3"
    sha256 cellar: :any, high_sierra: "83a0236f5971e007e67e620730d458f8dcdcb7ff7770cc97c07407a771dbf69a"
  end

  depends_on "pkg-config" => :build
  depends_on "libnfc"
  depends_on "libusb"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"mfoc", "-h"
  end
end
