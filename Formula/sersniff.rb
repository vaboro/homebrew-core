class Sersniff < Formula
  desc "Program to tunnel/sniff between 2 serial ports"
  homepage "https://www.earth.li/projectpurple/progs/sersniff.html"
  url "https://www.earth.li/projectpurple/files/sersniff-0.0.5.tar.gz"
  sha256 "8aa93f3b81030bcc6ff3935a48c1fd58baab8f964b1d5e24f0aaecbd78347209"
  license "GPL-2.0"
  head "https://the.earth.li/git/sersniff.git"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:    "96f5d56b1d6c9acb8b465a1912fbd03f6837e0ffabf643200b40528ec7984358"
    sha256 cellar: :any_skip_relocation, mojave:      "89c553505287f0cbd3ef2d46c6b04eb328d0748db6e60511b25d24cefcab83ce"
    sha256 cellar: :any_skip_relocation, high_sierra: "eb3cf737a135049c3f7b8bacf4d71670dfc755a1b266f41f0865fb8983a53d55"
    sha256 cellar: :any_skip_relocation, sierra:      "077112b0300e14f956fbe45ff650cf973e04c355707a3add63b8efc7fc047737"
    sha256 cellar: :any_skip_relocation, el_capitan:  "abde8af644fecfa883abf597486fd269b379001ae29161fbd21777d0506edc86"
    sha256 cellar: :any_skip_relocation, yosemite:    "c0c00897dd19dc6f8dff05b57e961079c8f783ba9afc345cac9f064dd2ae6630"
    sha256 cellar: :any_skip_relocation, mavericks:   "cd8d98e4360a068975fa25f1816e1a79533b46e5da65e455a0498d334daa1761"
  end

  def install
    system "make"
    bin.install "sersniff"
    man8.install "sersniff.8"
  end

  test do
    assert_match(/sersniff v#{version}/,
                 shell_output("#{bin}/sersniff -h 2>&1", 1))
  end
end
