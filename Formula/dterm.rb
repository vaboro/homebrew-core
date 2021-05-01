class Dterm < Formula
  desc "Terminal emulator for use with xterm and friends"
  homepage "http://www.knossos.net.nz/resources/free-software/dterm/"
  url "http://www.knossos.net.nz/downloads/dterm-0.5.tgz"
  sha256 "94533be79f1eec965e59886d5f00a35cb675c5db1d89419f253bb72f140abddb"
  license "GPL-2.0"

  livecheck do
    url :homepage
    regex(/href=.*?dterm[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "0ee11ec243e1d9038a5f8d0ef86a00e5bf07af59be0497e8b8b677bf032bdc2b"
    sha256 cellar: :any_skip_relocation, mojave:      "d6d5d49c0e4da6bc6273bb8cffc0717daea8cad68346c34d9beedcbe0e5b24a3"
    sha256 cellar: :any_skip_relocation, high_sierra: "85085f6142348852c9a5efee30a697fa6b31d9162807a256aee5100e50ff99ea"
    sha256 cellar: :any_skip_relocation, sierra:      "a0f9f7bfcadc790624975724244e30d4459e0eb3172dc2646db2b58f7643589c"
    sha256 cellar: :any_skip_relocation, el_capitan:  "6e18a2f46faa55e99fe070c7fd5e95940d66a5295f694605c9e90b416b577d37"
    sha256 cellar: :any_skip_relocation, yosemite:    "353231f24cda3e48779652002067ac2650b0182f4e7f69fc86b059139daf4511"
  end

  def install
    bin.mkpath
    system "make"
    system "make", "install", "BIN=#{bin}/"
  end

  test do
    system "#{bin}/dterm", "help"
  end
end
