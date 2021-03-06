class Lbzip2 < Formula
  desc "Parallel bzip2 utility"
  homepage "https://github.com/kjn/lbzip2"
  url "https://web.archive.org/web/20170304050514/archive.lbzip2.org/lbzip2-2.5.tar.bz2"
  mirror "https://fossies.org/linux/privat/lbzip2-2.5.tar.bz2"
  sha256 "eec4ff08376090494fa3710649b73e5412c3687b4b9b758c93f73aa7be27555b"
  license "GPL-3.0"
  revision 1

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "6643ba1c0f17a13e742383c69112df62c1d6bce80e6833d717df4e112922deb5"
    sha256 cellar: :any_skip_relocation, mojave:      "5f7f053aac95586cdcacb2528fe4540bd16522707e9d7bbbf8e6d38012378e06"
    sha256 cellar: :any_skip_relocation, high_sierra: "3d4e0de242b81f83ba2addd163688647288fb17f3a3ae3ccd37a2e62f20871d4"
  end

  # Fix crash on macOS >= 10.13.
  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/6b276429dbe68323349e1eda09b7e5d5a1082671/lbzip2/gnulib-vasnprintf-port-to-macOS-10-13.diff"
    sha256 "5b931e071e511a9c56e529278c249d7b2c82bbc3deda3dd9b739b3bd67d3d969"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    touch "fish"
    system "#{bin}/lbzip2", "fish"
    system "#{bin}/lbunzip2", "fish.bz2"
  end
end
