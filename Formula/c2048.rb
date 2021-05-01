class C2048 < Formula
  desc "Console version of 2048"
  homepage "https://github.com/mevdschee/2048.c"
  url "https://github.com/mevdschee/2048.c.git", revision: "578a5f314e1ce31b57e645a8c0a2c9d9d5539cde"
  version "0+20150805"
  license "MIT"
  head "https://github.com/mevdschee/2048.c.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "727165d714b210f559b5f5450d6608bed0e7bfbf87c7a7cd5994259b65865411"
    sha256 cellar: :any_skip_relocation, mojave:      "dd0cc60f407ccb43f471d7123b9a09fa0b2161ee083638a432ee25795a96ca8f"
    sha256 cellar: :any_skip_relocation, high_sierra: "e5f553baf87fc7ac9f0fa4471d3e9be29328df167700181d9663f61293436888"
    sha256 cellar: :any_skip_relocation, sierra:      "d2f33783cf7cd2ac69eaed113d940aca31e02e5863fcdb40e200e3fe9a4d0623"
    sha256 cellar: :any_skip_relocation, el_capitan:  "8f9e75196f87718be0c572f731cecba0c8cd4e8dc35f8b3027392cd6e1c45f5d"
    sha256 cellar: :any_skip_relocation, yosemite:    "c06bde9e58788a1a4f16b6d0ace89be02cf07f86211e0c78af5fdaa7d70a3614"
  end

  def install
    system "make"
    bin.install "2048"
  end

  def caveats
    <<~EOS
      The game supports different color schemes.
      For the black-to white:
        2048 blackwhite
      For the blue-to-red:
        2048 bluered
    EOS
  end

  test do
    system "#{bin}/2048", "test"
  end
end
