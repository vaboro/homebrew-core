class Midicsv < Formula
  desc "Convert MIDI audio files to human-readable CSV format"
  homepage "https://www.fourmilab.ch/webtools/midicsv"
  url "https://www.fourmilab.ch/webtools/midicsv/midicsv-1.1.tar.gz"
  sha256 "7c5a749ab5c4ebac4bd7361df0af65892f380245be57c838e08ec6e4ac9870ef"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "5d36fed687c5f4b23c0705ff261a798697bcda5d4fefa6d86d6a1449ad1efa50"
    sha256 cellar: :any_skip_relocation, mojave:      "3fcfcbe9f5b248c681f57eccd4c17c2f93d1a977c3a19949cbeee6dd77038787"
    sha256 cellar: :any_skip_relocation, high_sierra: "737ea2eda70a778d076568af902f16d609aaae4baeb7ada7795c32d4de886f81"
    sha256 cellar: :any_skip_relocation, sierra:      "314a21ac6aaad39594a54bae4bf3ecc64e3ef0cd655e7c18c6ff05ebd72c9b86"
    sha256 cellar: :any_skip_relocation, el_capitan:  "230ba9ec9cbb40c2c128c1a063152fd07888210f59bf37f1f68bcd2f33d4d863"
    sha256 cellar: :any_skip_relocation, yosemite:    "f649e02908dee31c35e9b73954b8faad2da70e1c7e621fddb64f18dbad897036"
    sha256 cellar: :any_skip_relocation, mavericks:   "289d13313a2f5d7dbc8ebf61450ba336bdba9849be352dc5b705c0d2c4b13d3e"
  end

  def install
    system "make"
    system "make", "check"
    system "make", "install", "INSTALL_DEST=#{prefix}"
    share.install prefix/"man"
  end

  test do
    system "#{bin}/midicsv", "-u"
  end
end
