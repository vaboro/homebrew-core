class Vimpc < Formula
  desc "Ncurses based mpd client with vi like key bindings"
  homepage "https://sourceforge.net/projects/vimpc/"
  url "https://github.com/boysetsfrog/vimpc/archive/v0.09.2.tar.gz"
  sha256 "caa772f984e35b1c2fbe0349bc9068fc00c17bcfcc0c596f818fa894cac035ce"
  license "GPL-3.0"
  head "https://github.com/boysetsfrog/vimpc.git"

  bottle do
    sha256 catalina:    "c8d1936d4ff7a8b85de154b64e7f7a276b6265c703029cca7c2e56ee4ca32abd"
    sha256 mojave:      "83dd8968d8fc7830c2dc90db35441c01bd62c567b8d2749e00edba7ee7429487"
    sha256 high_sierra: "d457ed5a1b85e88f721d7617753aee99a3a8ed17806b5925b6458c9fb9477423"
    sha256 sierra:      "af41091db0a875b5fa05d0b1cc969df649693f4ceb4e14b8cdd72a3b6527a741"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libmpdclient"
  depends_on "pcre"
  depends_on "taglib"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/vimpc", "-v"
  end
end
