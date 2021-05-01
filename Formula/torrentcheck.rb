class Torrentcheck < Formula
  desc "Command-line torrent viewer and hash checker"
  homepage "https://torrentcheck.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/torrentcheck/torrentcheck-1.00.zip"
  sha256 "a839f9ac9669d942f83af33db96ce9902d84f85592c99b568ef0f5232ff318c5"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "b8100aac4cf74924411b389b8e2c45656d621e8ef3281b21e761188859a36f2e"
    sha256 cellar: :any_skip_relocation, mojave:      "68fe4afd56987956e760e7dc7cac8db8677dd9c4aee2b844435fbc90e0da039a"
    sha256 cellar: :any_skip_relocation, high_sierra: "7d214899822d24fabad867f67d8062bb689a74e8f7975ea2209bf69aca342abe"
    sha256 cellar: :any_skip_relocation, sierra:      "c1169f112306b1f235297cba2c8920894e063b9b1f774e36be75f3f2c194bda5"
    sha256 cellar: :any_skip_relocation, el_capitan:  "ea6fbaa86be1c799c3baa4405aa1a750c2b3e1deb4bea0a412027d427f0922da"
    sha256 cellar: :any_skip_relocation, yosemite:    "46426cdf1c627f448d54895b7f08379b90948030be346753104f5f6a5fabca3b"
    sha256 cellar: :any_skip_relocation, mavericks:   "ed300dfc8d1f7f7fe3c9c161b8f86cc6a379c7a4cca3914bb0c665d66ec6596a"
  end

  def install
    inreplace "torrentcheck.c", "#include <malloc.h>", ""
    system ENV.cc, "torrentcheck.c", "sha1.c", "-o", "torrentcheck", *ENV.cflags.to_s.split
    bin.install "torrentcheck"
  end
end
