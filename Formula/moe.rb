class Moe < Formula
  desc "Console text editor for ISO-8859 and ASCII"
  homepage "https://www.gnu.org/software/moe/moe.html"
  url "https://ftp.gnu.org/gnu/moe/moe-1.10.tar.lz"
  mirror "https://ftpmirror.gnu.org/moe/moe-1.10.tar.lz"
  sha256 "8cfd44ab5623ed4185ee53962b879fd9bdd18eab47bf5dd9bdb8271f1bf7d53b"
  license "GPL-2.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 catalina:    "204f87443d288dd953d310ca2e2fa3de0051f460f1586e357ddfdcc540411412"
    sha256 mojave:      "934ee30ec5f7f95c74183e5faf6ccc7ac36c426747476a5a0fb9628a6169de04"
    sha256 high_sierra: "fdfffe18871a25a5f0a8cf86ac8682f2cc6623dea335575d39f1dd529ee2ae46"
    sha256 sierra:      "f83a8e961f1a7d295741a6abfe7434580761fa485e32498327ffb0e09322fa1e"
  end

  uses_from_macos "ncurses"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/moe", "--version"
  end
end
