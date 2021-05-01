class Advancescan < Formula
  desc "Rom manager for AdvanceMAME/MESS"
  homepage "https://www.advancemame.it/scan-readme.html"
  url "https://github.com/amadvance/advancescan/releases/download/v1.18/advancescan-1.18.tar.gz"
  sha256 "8c346c6578a1486ca01774f30c3e678058b9b8b02f265119776d523358d24672"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "a2858248da2aa75092ab3511c6f9922bc85227e07c27444371e8d75931668bee"
    sha256 cellar: :any_skip_relocation, mojave:      "3aa20db4c47b16166b385d3e7e0c7af903833333757af7b1e0909dec00824ce2"
    sha256 cellar: :any_skip_relocation, high_sierra: "d0a8416434aa03573dcbadebd135fbcfa6f4829934622ab8afe68aa496ec5e48"
    sha256 cellar: :any_skip_relocation, sierra:      "0bc4290c65271b84aec455adbaf85795857b19102e6efb152a64623420ae5757"
    sha256 cellar: :any_skip_relocation, el_capitan:  "e4295866cda2370aa37cb1144ff1269ada4df6b76145a25efaf072d7a6b09b5c"
    sha256 cellar: :any_skip_relocation, yosemite:    "f91cbe31c7c8072fffffcd0cc8766e20df6f728abc73f66140f97c0a49d6f6c8"
  end

  uses_from_macos "zlib"

  def install
    system "./configure", "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/advdiff", "-V"
    system "#{bin}/advscan", "-V"
  end
end
