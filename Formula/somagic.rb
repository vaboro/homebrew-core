class Somagic < Formula
  desc "Linux capture program for the Somagic variants of EasyCAP"
  homepage "https://code.google.com/archive/p/easycap-somagic-linux/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/easycap-somagic-linux/somagic-easycap_1.1.tar.gz"
  sha256 "3a9dd78a47335a6d041cd5465d28124612dad97939c56d7c10e000484d78a320"

  bottle do
    sha256 cellar: :any, catalina:    "41d2479b3d2a267bbcd8c5db4ea7a8fe04c120d260d2ac9f087bd386012a3971"
    sha256 cellar: :any, mojave:      "c2a69924be6f0d397b244955cfa841567ecd3171dc2674a4ac9748f49f58a44b"
    sha256 cellar: :any, high_sierra: "b6c11695d2c25a49a4a2c5795764a83615a214630bc25914e65fc691662617fc"
    sha256 cellar: :any, sierra:      "377ecbdc01ebaab2acf1101aa00bbf5554e7d56b1b630baa28ef70d9deb10811"
    sha256 cellar: :any, el_capitan:  "ed8a82423daaabaca0a7ab203edc68b3c0a1a1d617eb24d46486dfa974e9eb4f"
    sha256 cellar: :any, yosemite:    "9c87f9d7a694509b446ce726cedcb731c0185b589a1cdfa96c0346f883a75e5d"
    sha256 cellar: :any, mavericks:   "0684417c6e1f1b498d10c5d24171217fb2e70ed0c8f9bacdd7365e8be8af20fc"
  end

  depends_on "libgcrypt"
  depends_on "libusb"
  depends_on "somagic-tools"

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end

  def caveats
    <<~EOS
      Before running somagic-capture you must extract the official firmware from the CD.
      See https://code.google.com/archive/p/easycap-somagic-linux/wikis/GettingStarted.wiki for details.
    EOS
  end
end
