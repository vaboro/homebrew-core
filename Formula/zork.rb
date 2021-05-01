class Zork < Formula
  desc "Dungeon modified from FORTRAN to C"
  homepage "https://github.com/devshane/zork"
  url "https://github.com/devshane/zork/archive/v1.0.2.tar.gz"
  sha256 "169e1848b1e3c503591c23ad4e66ce45e1d5ae617831634e1da9c8fca659e283"
  head "https://github.com/devshane/zork.git"

  bottle do
    sha256 catalina:    "e3beae53e804ba7ad871d84431b76e1e7ca958bb0db4b70506771107b3f25ca1"
    sha256 mojave:      "0290ba47e707b2812ae354672fd59409acd354fe00b445c424e07c2f3ae8133c"
    sha256 high_sierra: "13e9074fc59bcaeb1dbb5fdeb536da90cd33ef23889109fe20e79429ead56444"
    sha256 sierra:      "d2fe9ee55de4906a3a99d30070d81f73637f3972a6e0c44eb7ab2461c024c684"
    sha256 el_capitan:  "8dc6fd49cf72dfa69f677eb1cfd7850f781271c35e4adbacdac00bf918ce6fec"
    sha256 yosemite:    "cb1076cd985679e6d9d093f4887c95bc7f0eb046c2799ec5000611703f428d47"
  end

  uses_from_macos "ncurses"

  def install
    system "make", "DATADIR=#{share}", "BINDIR=#{bin}"
    system "make", "install", "DATADIR=#{share}", "BINDIR=#{bin}", "MANDIR=#{man}"
  end

  test do
    test_phrase = <<~EOS.chomp
      Welcome to Dungeon.\t\t\tThis version created 11-MAR-91.
      You are in an open field west of a big white house with a boarded
      front door.
      There is a small mailbox here.
      >Opening the mailbox reveals:
        A leaflet.
      >
    EOS
    assert_equal test_phrase, pipe_output("#{bin}/zork", "open mailbox", 0)
  end
end
